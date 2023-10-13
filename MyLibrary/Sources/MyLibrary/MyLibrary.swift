// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit


extension UIView {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Turns a view into a circle
    func circle() {
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
        self.layer.masksToBounds = true
    }
    
    func circularShadow() {
        self.layer.shadowColor = UIColor(red: 121/256, green: 45/256, blue: 236/256, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 8
    }
    
    func addBottomShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
    }
    
    func setRoundCorner(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setBorder(color:UIColor = UIColor.clear, size:CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = size
    }
    
    func setRoundBorder(radius:CGFloat, color:UIColor = UIColor.clear, size:CGFloat = 1) {
        self.setRoundCorner(radius: radius)
        self.setBorder(color: color, size: size)
    }
    
    func addTapGesture(target:AnyObject?, action:Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    func addDoubleTapGesture(target:AnyObject?, actionDouble:Selector, actionSingle:Selector) {
        let tapGestureSingle = UITapGestureRecognizer(target: target, action: actionSingle)
        tapGestureSingle.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGestureSingle)
        
        let tapGesture = UITapGestureRecognizer(target: target, action: actionDouble)
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapGesture)
        
        tapGestureSingle.require(toFail: tapGesture)
    }
    
    func roundedCorners(maskCorners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = maskCorners
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat? = 2.0) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        if let borderColor = borderColor, let borderWidth = borderWidth {
            var borderLayer: CAShapeLayer!
            for layer in self.layer.sublayers ?? [] {
                if layer.name == "borderLayer" {
                    borderLayer = (layer as? CAShapeLayer)!
                }
            }
            
            let borderPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            if borderLayer == nil {
                borderLayer = CAShapeLayer()
                self.layer.addSublayer(borderLayer)
            }
            borderLayer.path = borderPath.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.frame = self.bounds
            borderLayer.name = "borderLayer"
        }
    }
    
    func addSeparator(with color : UIColor, size : CGFloat, padding: CGFloat = 0,isAtTop : Bool = false) {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separator)
        separator.backgroundColor = color
        if isAtTop {
            separator.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        } else {
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        }
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding).isActive = true
        separator.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.bringSubviewToFront(separator)
    }
    
    
    // Adds a view as a subview of another view with anchors at all sides
    func addToView(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self)
        
        self.topAnchor.constraint(equalTo:    view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo:   view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo:  view.rightAnchor).isActive = true
    }
    
    
    /// Add Shadow to the View to particular Position
    ///
    /// - Parameter position: Accepts the enum value shadowPosition to specify the position of the shadow
    func addViewShadow(_ height :CGFloat =  3.0,_ color:UIColor = UIColor.lightGray) {
        let aRect : CGRect! = CGRect(x: -5, y: -5, width: frame.size.width + 8, height: frame.size.height + 8)
        let shadowPath = UIBezierPath(rect: aRect)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: height)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
        layer.shadowPath = shadowPath.cgPath
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
    }
    
    func addViewShadowExceptPosition(_ position:shadowPosition,_ height :CGFloat =  3.0,_ color:UIColor = UIColor.lightGray) {
        var aRect : CGRect! = CGRect(x: -5, y: -5, width: frame.size.width + 8, height: frame.size.height + 8)
        
        if position == .bottom {
            aRect = CGRect(x: -5, y: -5, width: frame.size.width + 8, height: frame.size.height)
        } else if position == .top {
            aRect = CGRect(x: -5, y: 0, width: frame.size.width + 8, height: frame.size.height + 8)
        } else if position == .left {
            aRect = CGRect(x: 0, y: 0, width: frame.size.width + 8, height: frame.size.height + 8)
        } else if position == .right {
            aRect = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height + 8)
        } else {
            aRect = bounds
        }
        
        let shadowPath = UIBezierPath(rect: aRect)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: height)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
    
    
    
    /// Add Shadow to the View to particular Position
    ///
    /// - Parameter position: Accepts the enum value shadowPosition to specify the position of the shadow
    func addViewShadowAtPosition(_ position:shadowPosition,_ height :CGFloat =  3.0,_ color:UIColor = UIColor.lightGray) {
        var aRect : CGRect!
        if position == .bottom {
            aRect = CGRect(x: 0, y: frame.size.height/2, width: frame.size.width, height: frame.size.height/2)
        } else if position == .top {
            aRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/2)
        } else if position == .line {
            aRect = CGRect(x: 0, y: frame.size.height-3, width: frame.size.width, height: 3)
        } else {
            aRect = bounds
        }
        
        let shadowPath = UIBezierPath(rect: aRect)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: height)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
    
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(by angle: CGFloat, animated:Bool = false) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransform(rotationAngle: radians)
        UIView.animate(withDuration: animated ? 0.4 : 0.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveLinear, animations: {
            self.transform = rotation
        }, completion: nil)
    }
    
    func shake(ratio:CGFloat?=10 , duration: Double = 0.07) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint.init(x:self.center.x - ratio!, y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint.init(x:self.center.x + ratio!, y:self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi / 8)
        rotation.duration = 2
        rotation.autoreverses = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

    
    
    func setCardViewShadow(cornerRadius:CGFloat? = 5.0, color:UIColor? = UIColor.lightGray) {
        
        let shadowOffsetWidth: CGFloat = 0.0
        let shadowOffsetHeight: CGFloat = 0.5
        let shadowColor: UIColor? = color
        let shadowOpacity: Float = 0.5
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius!)
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius!
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func setBottomRoundCornor() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        
        //Here I'm masking the textView's layer with rectShape layer
        self.layer.mask = rectShape
    }
    
    func getImageFromCurrentView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func addDashedBorder() {
        let color = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addHorizontalDashedLine() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = AppColor.AppVioletColor.color.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [5,3]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width + 18, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    


}

