//
//  UIView+Extension.swift
//  LSCompose
//
//  Created by WangBiao on 2016/11/24.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

extension UIView {
    
    //  扩展计算属性 -> 不能提供存储属性
    //  x坐标
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame.origin.x = newValue
        }
    }
    
    //  y坐标
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame.origin.y = newValue
        }
    }
    
    //  width宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        } set {
            self.frame.size.width = newValue
        }
    }
    //  height 高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        } set {
            self.frame.size.height = newValue
        }
    }
    
    //  size 大小
    var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    //  获取中心 x
    var centerX: CGFloat {
        get {
            return self.center.x
        } set {
            self.center.x = newValue
        }
    }
    
    //  获取中心 y
    var centerY: CGFloat {
        get {
            return self.center.y
        } set {
            self.center.y = newValue
        }
    }
    
    
}
