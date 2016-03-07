//
//  MyUtils.swift
//  Shooting Star
//
//  Created by Jeffery Kelly on 2/18/16.
//  Copyright © 2016 Jeffery Kelly. All rights reserved.
//

import Foundation
import CoreGraphics

func +(left: CGPoint, right:CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y);
}

func +=(inout left: CGPoint, right:CGPoint) {
    left = left + right;
}


func -(left: CGPoint, right:CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y);
}

func -=(inout left: CGPoint, right:CGPoint) {
    left = left - right;
}

func *(left: CGPoint, right:CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right);
}

func *=(inout left: CGPoint, right:CGFloat) {
    left = left * right;
}

func /(left: CGPoint, right:CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right);
}

func /=(inout left: CGPoint, right:CGFloat) {
    left = left / right;
}

func *(left: CGPoint, right:CGPoint) -> CGPoint {
    return CGPoint(x:left.x * right.x, y:left.y * right.y);
}

func *=(inout left: CGPoint, right:CGPoint) {
    left = left * right;
}

func /(left: CGPoint, right:CGPoint) -> CGPoint {
    return CGPoint(x:left.x / right.x, y:left.y / right.y);
}

func /=(inout left: CGPoint, right:CGPoint) {
    left = left / right;
}

let pi = CGFloat(M_PI);

func radsToDeg(ang:CGFloat) -> CGFloat {
    return ang * 180.0 / pi;
}

func degsToRad(ang:CGFloat) -> CGFloat {
    return ang * pi / 180.0;
}
#if !(arch(x86_64) || arch(arm64))
    func atan2(y:CGFloat, x:CGFloat) -> CGFloat {
        return CGFloat(atan2f(Float(y), Float(x)));
    }
    
    func sqrt(a:CGFloat) -> CGFloat {
        return CGFloat(sqrt(Float(a)));
    }
#endif
extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y);
    }
    
    func normalized() -> CGPoint {
        return self / length();
    }
    
    var angle: CGFloat {
        return atan2(y, x);
    }
    
    func distance(p:CGPoint) -> CGFloat {
        return (self - p).length();
    }
    
}

extension CGFloat {
    func sign() -> CGFloat {
        return (self >= 0) ? 1.0 : -1.0;
    }
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX));
    }
    
    static func random(min min: CGFloat, max:CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min;
    }
}
