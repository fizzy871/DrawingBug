//
//  DrawingView.swift
//  StandardModules
//
//  Created by Алексей Саечников on 17.02.17.
//  Copyright © 2017 Tapp Solutions, LLC. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    let imageView = UIImageView()
    
    // drawing properties
    let lineWidth = CGFloat(5.0)
    let lineColor = UIColor.black
    var lastPoint = CGPoint.zero
    var swiped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    func clear() {
        imageView.image = nil
    }
    
    func getImage() -> UIImage {
        return imageView.image ?? UIImage()
    }
    
    func prepareView() {
        imageView.frame = bounds
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(imageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: imageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: imageView)
            drawLine(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLine(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
//        // Merge tempImageView into mainImageView
//        UIGraphicsBeginImageContext(mainImageView.frame.size)
//        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
//        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
//        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        tempImageView.image = nil
    }
    
    func drawLine(fromPoint fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)

        context?.setLineCap(.round)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(lineColor.cgColor)
//        context?.setBlendMode(.normal)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}
