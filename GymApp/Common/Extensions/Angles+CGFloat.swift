//
//  Angles+CGFloat.swift
//  GymApp
//
//  Created by rafael.rollo on 11/11/21.
//

import UIKit

extension CGFloat {

    static func angle(_ degrees: CGFloat) -> CGFloat {
        return .init(.pi * degrees / 180.0)
    }

}
