//
//  Texts.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import Foundation

public extension Colors {

    enum App: String {
        case text01
        case view01
        case view02
        case offline01
        case shadow01
        case white01
    }

}

extension Colors.App: ColorStyle { }
