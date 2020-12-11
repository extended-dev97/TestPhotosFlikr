//
//  Foundation+Extension.swift
//  Photos
//
//  Created by Ярослав Стрельников on 10.12.2020.
//

import Foundation
import UIKit

extension String {
    var toInt: Int {
        return Int(self) ?? 0
    }
}

extension Int {
    var toString: String {
        return "\(self)"
    }
    
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat {
    func getPercent(_ percent: Int) -> CGFloat {
        return (self / 100) * percent.toCGFloat
    }
}

extension CGSize {
    static func custom(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    static func identity(_ value: CGFloat) -> CGSize {
        return CGSize(width: value, height: value)
    }
}

extension UIEdgeInsets {
    static func identity(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    static func custom(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

extension DispatchQueue {
    func async(after delay: TimeInterval, execute: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: execute)
    }
}
