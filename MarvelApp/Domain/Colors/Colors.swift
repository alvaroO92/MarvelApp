//
//  Colors.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

public enum Colors {}

public protocol ColorStyle {
    var name: String { get }
    var uiColor: UIColor { get }
}

public extension ColorStyle {
    var uiColor: UIColor {
        UIColor(named: name,
                in: .main,
                compatibleWith: nil) ?? UIColor.clear
    }
}

public extension ColorStyle where Self: RawRepresentable, Self.RawValue == String {
    var name: String {
        self.rawValue
    }
}
