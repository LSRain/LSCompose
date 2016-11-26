//
//  LSComposeMenuButton.swift
//  LSCompose
//
//  Created by WangBiao on 2016/11/24.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit
//  自定义撰写菜单按钮
class LSComposeMenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //  重写isHighlighted 取消高亮效果
    override var isHighlighted: Bool {
        get {
            return false
        } set {
        
        }
    }
    
    
    private func setupUI() {
        //  设置图片的显示模式
        imageView?.contentMode = .center
        //  设置文字居中方式
        titleLabel?.textAlignment = .center
        //  设置文字颜色
        setTitleColor(UIColor.darkGray, for: .normal)
        //  设置文字字体大小
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    
    

    //  调整子控件的布局
    override func layoutSubviews() {
        super.layoutSubviews()
        //  设置图片控件的宽度
        imageView?.width =  self.width
        //  设置图片控件的高度
        imageView?.height = self.width
        //  设置 y
        imageView?.y = 0
        
        //  设置文件控件的高度
        titleLabel?.height = self.height - self.width
        titleLabel?.width = self.width
        
        //  设置 y
        titleLabel?.y = self.width
        titleLabel?.x = 0
        
    }
    
    
}
