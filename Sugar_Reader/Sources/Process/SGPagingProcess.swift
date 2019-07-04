//
//  SGPagingProcess.swift
//  Sugar_Reader
//
//  Created by YY on 2019/7/4.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import CoreText
import TYAttributedLabel
import TYText


typealias SGPagingProcessBlock = (_ status: Bool,_ PagingModel:SGPagingModel?) -> Void

class SGPagingProcess: NSObject {
    var content:String?
    var index:Int?
    var title:String?
    private var showTextRect:CGRect{
        var rect = CGRect.zero
        rect.size = SGReaderSetDataManager.shared.readerTextSize
        return rect
    }
    
    private var pageAttStrings:Array<NSAttributedString> = Array()
    private var pagingProcessBlock:SGPagingProcessBlock?
    func `do`() {
        let chapterPagingModel = SGPagingModel()
        let contentLength = content?.count ?? 0
        if contentLength <= 0{
            blockPagingProcess(false, nil)
            return
        }
        var pageStartIndex = 0
        let chapterAttriString = makeChapterAttributedString()
        while (pageStartIndex < contentLength){
            let surplusCount = contentLength - pageStartIndex
            let pageRange = NSRange(location: pageStartIndex, length: surplusCount)
            let surplusAttrString = chapterAttriString.attributedSubstring(from: pageRange)
            let subFramesetter = CTFramesetterCreateWithAttributedString(surplusAttrString)
            let bezierPath = UIBezierPath(rect: showTextRect)
            let subFrame  = CTFramesetterCreateFrame(subFramesetter, CFRangeMake(0, 0), bezierPath.cgPath, nil)
            //let pageLines = CTFrameGetLines(subFrame)
            let subPageFrameRange = CTFrameGetVisibleStringRange(subFrame)
            let subRange = NSRange(location: 0, length: subPageFrameRange.length)
            if subPageFrameRange.length > 0{
                let pageSubAttriString = NSMutableAttributedString(attributedString:surplusAttrString.attributedSubstring(from: subRange))
                if pageAttStrings.count > 0{
                    if let attString = pageAttStrings.last{
                        if let pageLastCharacter = attString.string.last{
                            
                            if pageLastCharacter != "\n"{
                                /*
                                 let allRange = NSRange(location: 0, length: pageSubAttriString.string.count)
                                 let nextReturnRange = (pageSubAttriString.string as NSString).range(of: "\n")
                                 let otherRange = NSRange(location: nextReturnRange.location, length: pageSubAttriString.string.count - nextReturnRange.location)
                                 
                                 pageSubAttriString.ty_addFirstLineHeadIndent(MRReaderSetting.shared.firstLineHeadIndent, range: otherRange)
                                 pageSubAttriString.ty_addHeadIndent(0, range: NSRange(location: 0, length: nextReturnRange.location))*/
                            }else{
                                //let allRange = NSRange(location: 0, length: pageSubAttriString.string.count)
                                //pageSubAttriString.ty_addFirstLineHeadIndent(MRReaderSetting.shared.firstLineHeadIndent, range: allRange)
                            }
                        }
                    }
                }
                
                pageAttStrings.append(pageSubAttriString)
                pageStartIndex += subRange.length
                if pageStartIndex >= contentLength{
                    if pageSubAttriString.string.wrapTrim().count == 0{
                        pageAttStrings.removeLast()
                    }
                }
            }
        }
        chapterPagingModel.attrString = chapterAttriString
        chapterPagingModel.chapterIndex = index
        chapterPagingModel.pageAttrStrings = pageAttStrings
        chapterPagingModel.title = title
        blockPagingProcess(true, chapterPagingModel)
    }
    
    func adaptersPageAttString(_ attributedString: NSAttributedString, _ frame: CTFrame, _ lines: CFArray) -> NSAttributedString {
        let pageAttString = NSMutableAttributedString(attributedString: attributedString)
        let lineCount = CFArrayGetCount(lines)
        if lineCount > 0 {
            var origins:[CGPoint] = Array(repeating:CGPoint.zero, count:lineCount)
            CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &origins)
            let y = origins[lineCount - 1].y
            var ascent:CGFloat = 0
            var descent:CGFloat = 0
            var leading:CGFloat = 0
            let endLineRef = unsafeBitCast(CFArrayGetValueAtIndex(lines,lineCount-1), to: CTLine.self)
            let endLineWidth = CTLineGetTypographicBounds(endLineRef, &ascent, &descent, &leading)
            let freeBottom = y + descent + 1
            var charSpacing: CGFloat = 0
            let lineCFRange = CTLineGetStringRange(endLineRef)
            let lineRange = NSRange(location: lineCFRange.location, length: lineCFRange.length)
            let lineAttributedString = attributedString.attributedSubstring(from: lineRange)
            let rect = lineAttributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: [.truncatesLastVisibleLine,.usesLineFragmentOrigin], context: nil)
            let freeSpace = CGFloat(endLineWidth) - rect.width
            if freeSpace > 0 {
                charSpacing = freeSpace / CGFloat(lineRange.length)
            }
            let readerSet = SGReaderSetDataManager.shared
            let lineSpacing = freeBottom / CGFloat(lineCount)
            let allRange = NSRange(location: 0, length: attributedString.string.count)
            pageAttString.ty_addLineSpacing(readerSet.linesSpacing + lineSpacing, range: allRange)
            pageAttString.ty_addCharacterSpacing(charSpacing, range: lineRange)
        }
        return pageAttString
    }
    
    
    
    func makeChapterAttributedString() -> NSMutableAttributedString {
        let allRange:NSRange = NSRange(location: 0, length: content!.count)
        let readerSet = SGReaderSetDataManager.shared
        let attriString = NSMutableAttributedString(string: content!)
        // 添加首行缩进
        attriString.ty_addFirstLineHeadIndent(readerSet.firstLineHeadIndent, range: allRange)
        // 添加段间距
        attriString.ty_addParagraphSpacing(readerSet.paragraphSpacing, range: allRange)
        // 添加换行方式
        attriString.ty_add(.byWordWrapping,range: allRange)
        // 添加对齐方式
        attriString.ty_add(.justified,range: allRange)
        // 添加行间距
        attriString.ty_addLineSpacing(readerSet.linesSpacing, range: allRange)
        // 设置字间距
        attriString.ty_addCharacterSpacing(readerSet.characterSpacing, range: allRange)
        // 设置字体
        if title != nil{
            attriString.ty_add(readerSet.readerTitleFont, range: NSRange(location: 0, length: title!.count))
            let noneTitleRange = NSRange(location: title!.count, length: content!.count - title!.count)
            attriString.ty_add(readerSet.readerFont, range: noneTitleRange)
        }else{
            attriString.ty_add(readerSet.readerFont, range: allRange)
        }
        return attriString
    }
}

extension SGPagingProcess{
    
    func setPagingProcessBlock(_ block: @escaping SGPagingProcessBlock) {
        pagingProcessBlock = block
    }
    func blockPagingProcess(_ status: Bool,_ pagingModel:SGPagingModel?)  {
        if pagingProcessBlock != nil{
            DispatchQueue.main.async {
                self.pagingProcessBlock!(status,pagingModel)
            }
        }
    }
}
