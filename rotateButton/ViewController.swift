//
//  ViewController.swift
//  rotateButton
//
//  Created by 横山祥平 on 2016/01/24.
//  Copyright © 2016年 Shohei. All rights reserved.
//

//http://qiita.com/rnsm504/items/ba11864516af9d59c0cf
//http://qiita.com/edo_m18/items/45fcbc67154eb68ef469

//http://www.indetail.co.jp/blog/ios-animation-rotation/

import UIKit

class ViewController: UIViewController {
    let frontView = UIView(frame: CGRectMake(0, 300, 200, 44))
    let backView = UIView(frame: CGRectMake(0, 300, 200, 44))
    
    let front = UIButton(frame: CGRectMake(0, 0, 200, 44))
    let back = UIButton(frame: CGRectMake(0, 0, 200, 44))
    var toggleFlg : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.frontView.backgroundColor = UIColor.redColor()
        self.frontView.layer.doubleSided = false
        
        self.backView.backgroundColor = UIColor.blueColor()
        self.backView.layer.doubleSided = false
        self.backView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0)
        
        back.setTitle("back", forState: .Normal)
        back.backgroundColor = UIColor.blackColor()
        back.addTarget(self, action: "animation:", forControlEvents: .TouchUpInside)
        back.layer.doubleSided = true
        self.backView.addSubview(back)
        
        front.setTitle("front", forState: .Normal)
        front.backgroundColor = UIColor.blackColor()
        front.addTarget(self, action: "animation:", forControlEvents: .TouchUpInside)
        front.layer.doubleSided = false
        front.layer.zPosition = 1
        self.frontView.addSubview(front)
        
        self.view.addSubview(backView)
        self.view.addSubview(frontView)
        
        
    }
    
    func rotate3() {
        CATransaction.begin()
        let toFrontTransform: CATransform3D  = CATransform3DMakeRotation(CGFloat(M_PI) * 2, 1.0, 0.0, 0.0)
        let toBackTransform: CATransform3D   = CATransform3DMakeRotation(CGFloat(M_PI),     1.0, 0.0, 0.0)
        
        let toFrontAnim: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        let toBackAnim: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        
        toFrontAnim.removedOnCompletion = false
        toFrontAnim.fillMode            = kCAFillModeForwards
        toBackAnim.removedOnCompletion  = false
        toBackAnim.fillMode             = kCAFillModeForwards
        
        toFrontAnim.toValue   = NSValue(CATransform3D : toFrontTransform)
        toFrontAnim.duration  = 0.5
        
        toBackAnim.toValue   = NSValue(CATransform3D : toBackTransform)
        toBackAnim.duration   = 0.5
        
        CATransaction.setCompletionBlock { () -> Void in
            if (self.toggleFlg) {
                self.frontView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0);
                self.backView.layer.transform  = CATransform3DMakeRotation(0,    1.0, 0.0, 0);
                self.frontView.hidden = true;
            }
            else {
                self.frontView.layer.transform = CATransform3DMakeRotation(0,    1.0, 0.0, 0);
                self.backView.layer.transform  = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0);
                self.backView.hidden = true;
            }
            self.rotate3()
        }
        
        self.frontView.hidden = false;
        self.backView.hidden  = false;
        
        self.toggleFlg = !self.toggleFlg
        var transform : CATransform3D = CATransform3DIdentity
//        transform.m34 = 1.0 / 1000
        transform.m34 = 1.0 / -420.0
        
        if (self.toggleFlg) {
            self.frontView.layer.addAnimation(toBackAnim, forKey: "toBack")
            self.backView.layer.addAnimation(toFrontAnim, forKey: "toFront")
        }
        else {
            self.frontView.layer.addAnimation(toFrontAnim, forKey: "toBack")
            self.backView.layer.addAnimation(toBackAnim, forKey: "toFront")
        }
        
        CATransaction.commit()
    }

    
    func animation(button: UIButton) {
        rotate3()
    }


}

