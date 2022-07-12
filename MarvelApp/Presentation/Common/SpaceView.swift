//
//  SpaceView.swift
//  MarvelApp
//
//  Created by Alvaro Orti Moreno on 1/7/22.
//

import UIKit

final class SpaceView: UIView {
    enum Axis {
        case vertical, horizontal
    }

    let space: CGFloat
    let axis: Axis

    init(_ space: CGFloat, in axis: Axis) {
        self.space = space
        self.axis = axis
        super.init(frame: .zero)
        let constraint: NSLayoutConstraint
        switch axis {
        case .horizontal:
            constraint = widthAnchor.constraint(equalToConstant: space)
        case .vertical:
            constraint = heightAnchor.constraint(equalToConstant: space)
        }
        constraint.isActive = true
    }

    required init?(coder: NSCoder) {
        self.space = .zero
        self.axis = .vertical
        super.init(coder: coder)
    }
}
