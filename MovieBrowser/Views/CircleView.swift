//
//  CircleView.swift
//  MovieBrowser
//
//  Created by Kirill Koleno on 25/11/2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    private let leftCircle = UIView(frame: .zero)
    private let centerCircle = UIView(frame: .zero)
    private let rightCircle = UIView(frame: .zero)
    
    public var circleRadius: CGFloat = 20
    public var centerCircleRadius: CGFloat = 25
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(leftCircle)
        addSubview(centerCircle)
        addSubview(rightCircle)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        addSubview(leftCircle)
        addSubview(centerCircle)
        addSubview(rightCircle)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // Left circle
        leftCircle.backgroundColor = superview?.backgroundColor
        leftCircle.alpha = 90
        leftCircle.frame = CGRect(x: bounds.minX,
                                  y: 0,
                                  width: circleRadius * 2,
                                  height: circleRadius * 2)
        leftCircle.center = CGPoint(x: bounds.minX,
                                    y: 0)
        leftCircle.layer.masksToBounds = true
        leftCircle.layer.cornerRadius = circleRadius
        
        // Center circle
        centerCircle.backgroundColor = superview?.backgroundColor
        centerCircle.alpha = 90
        centerCircle.frame = CGRect(x: bounds.midX,
                                    y: 0,
                                    width: centerCircleRadius * 2,
                                    height: centerCircleRadius * 1.5)
        centerCircle.center = CGPoint(x: bounds.midX,
                                      y: 0)
        centerCircle.layer.masksToBounds = true
        centerCircle.layer.cornerRadius = centerCircleRadius
        
        // Right circle
        rightCircle.backgroundColor = superview?.backgroundColor
        rightCircle.alpha = 90
        rightCircle.frame = CGRect(x: bounds.width - circleRadius,
                                   y: 0,
                                   width: circleRadius * 2,
                                   height: circleRadius * 2)
        rightCircle.center = CGPoint(x: bounds.maxX,
                                     y: 0)
        rightCircle.layer.masksToBounds = true
        rightCircle.layer.cornerRadius = circleRadius
    }
}
