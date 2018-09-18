//
//  CanvasView.swift
//  MLMath
//
//  Created by Santos on 2018-09-15.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit
class CanvasView : UIView {
    private final var LINE_WIDTH = 15
    private final var LINE_COLOUR = UIColor.white.cgColor
    var path : UIBezierPath!
    var touchPoint : CGPoint!
    var startingPoint : CGPoint!
    
    override func layoutSubviews() {
        //Call when view is layed out by the system
        self.isMultipleTouchEnabled = false
        self.clipsToBounds = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        drawShape()
    }
    func drawShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = self.path.cgPath
        shapeLayer.strokeColor = LINE_COLOUR
        shapeLayer.lineWidth = CGFloat(LINE_WIDTH)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = "round"
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    func eraseCanvas() {
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }
}
extension UIImage {
    convenience init(view :UIView){
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 1)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: imageSnapshot!.cgImage!)
    }
}
