//
//  SGAttributesExtension.swift
//  Sugar_Reader_VC
//
//  Created by YY on 2019/7/6.
//  Copyright © 2019 Sugar. All rights reserved.
//

import UIKit
import SwiftEntryKit

extension EKAttributes{
    public var readerToolAttributes:EKAttributes{
        var attributes: EKAttributes = .bottomFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.entryBackground = .color(color: .white)
        //attributes.screenBackground = .color(color: .dimmedLightBackground)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 25)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBar = .dark
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.5, spring: .init(damping: 1, initialVelocity: 0)))
        //attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor.LightPink.first, EKColor.LightPink.last], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.positionConstraints = .fullWidth
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.roundCorners = .top(radius: 20)
        //descriptionString = "Bottom toast popup with gradient background"
        //descriptionThumb = ThumbDesc.bottomPopup.rawValue
        //description = .init(with: attributes, title: "Pop Up III", description: descriptionString, thumb: descriptionThumb)
        //presets.append(description)
        return attributes
    }
}

extension UIScreen{
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}

