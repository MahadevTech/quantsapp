//
//  GradientView.swift
//  Narnolia
//
//  Created by Rupeeseed on 24/11/15.
//  Copyright © 2015 Rupeeseed. All rights reserved.
//

import UIKit

@IBDesignable public class GradientView: UIView {
    
    @IBInspectable public var topColor: UIColor? {
        didSet {
            configureView()
        }
    }
    @IBInspectable public var bottomColor: UIColor? {
        didSet {
            configureView()
        }
    }
    
    override open class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        configureView()
    }
    
    func configureView() {
        let layer = self.layer as! CAGradientLayer
        let locations = [ 0.0, 1.0 ]
        layer.locations = locations as [NSNumber]
        let color1 = topColor ?? self.tintColor as UIColor
        let color2 = bottomColor ?? UIColor.black as UIColor
        let colors: Array <AnyObject> = [ color1.cgColor, color2.cgColor ]
        layer.colors = colors
    }
}
