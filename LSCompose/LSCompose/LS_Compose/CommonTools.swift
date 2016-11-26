//
//  CommonTools.swift
//  LSOAuth
//
//  Created by WangBiao on 2016/10/29.
//  Copyright © 2016年 lsrain. All rights reserved.
//
/*
    - 等同于 OC中的 pch 文件   全局共享
 */
import UIKit

/*************************************************************************
 *
 *	宏
 *
 *************************************************************************/
/* 通知 */
let LSSWITCHROOTVCNOTI = "LSSWITCHROOTVCNOTI"

/* 屏幕的宽度和高度 */
let LSSCREENW = UIScreen.main.bounds.width
let LSSCREENH = UIScreen.main.bounds.height

/* 主题颜色 */
let LSTHEMECOLOR = UIColor.orange
/* 随机颜色 */
func LSRandomColor() -> UIColor{
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}

/* 常用字体大小 */
let LSBigFontSize: CGFloat = 18
let LSNormalFontSize: CGFloat = 14
let LSSmallFontSize: CGFloat = 10

