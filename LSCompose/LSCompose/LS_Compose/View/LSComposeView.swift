//
//  LSComposeView.swift
//  LSCompose
//
//  Created by WangBiao on 2016/11/24.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit
import pop
import YYModel

/*
    依赖：
    # pop 动画
    pod 'pop'
 
    桥接路径：
    LSCompose/LS_Compose/ls_compose-Bridging-Header.h
 **/

//  罩层
class LSComposeView: UIView {

    // MARK: - 懒加载
//    fileprivate lazy var bgImageView: UIImageView = UIImageView(image: self.getScreenShot())
    
    fileprivate lazy var bgImageView: UIImageView = {
        //  把图片改成模糊效果
        let image = self.getScreenShot().applyLightEffect()
        let imageView = UIImageView(image: image)
        return imageView
    }()
    //  标语
    fileprivate lazy var sloganImageView: UIImageView = UIImageView(image: UIImage(named: "compose_slogan"))
    //  记录当前创建6个撰写菜单按钮
    fileprivate lazy var composeButtonArray: [UIButton] = [UIButton]()
    
    //  记录当前传入过来的目标控制器
    fileprivate var target: UIViewController?
    
    //  获取 plist 数组模型数据
    fileprivate lazy var composeMenuArray: [LSComposeMenu] = self.loadComposeData()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //  设置大小
        size = CGSize(width: LSSCREENW, height: LSSCREENH)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  添加控件
    private func setupUI() {
        
        addSubview(bgImageView)
       
        addSubview(sloganImageView)
        sloganImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(bgImageView)
            make.top.equalTo(bgImageView).offset(100)
        }
        
        
        addChildButton()
        
        
    }
    
    //  添加6个子按钮方法
    private func addChildButton() {
        
        //  按钮的宽度
        let buttonWidth: CGFloat = 80
        //  按钮的高度
        let buttonHeight: CGFloat = 110
        //  计算每个按钮的间距
        let buttonMargin: CGFloat = (width - 3 * buttonWidth) / 4
        
        
        for i in 0..<composeMenuArray.count {
            //  计算列的索引
            let colIndex = i % 3
            //  计算行的索引
            let rowIndex = i / 3
            
            let button = LSComposeMenuButton()
            //  设置 tag
            button.tag = i
            //  添加点击事件
            button.addTarget(self, action: #selector(buttonAction(btn:)), for: .touchUpInside)
            //  根据下标获取对应的菜单模型数据
            let model = composeMenuArray[i]
            button.setImage(UIImage(named: model.icon!), for: .normal)
            button.setTitle(model.title!, for: .normal)
            //  设置大小
            button.size = CGSize(width: buttonWidth, height: buttonHeight)
            //  设置x,y 坐标
            button.x = CGFloat(colIndex) * buttonWidth + CGFloat(colIndex + 1) * buttonMargin
            button.y = CGFloat(rowIndex) * buttonMargin + CGFloat(rowIndex) * buttonHeight + LSSCREENH
            
            addSubview(button)
            //  保存菜单按钮
            composeButtonArray.append(button)
        }
    }
    
    //  截取当前屏幕的图片
    func getScreenShot() -> UIImage {
        //  获取当前 主window
        let window = UIApplication.shared.keyWindow!
        
        //  开启图片上下文
        UIGraphicsBeginImageContext(window.frame.size)
        let rect = CGRect(origin: CGPoint.zero, size: window.frame.size)
        //  根据指定区域绘制
        //  afterScreenUpdates 是否等到屏幕更新完成还以后在绘制
        window.drawHierarchy(in: rect, afterScreenUpdates: false)
        //  通过图片上下文获取绘制的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //  关闭图片上下文
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
    // MARK: - 开始 pop 动画
    fileprivate func startPopAnimation(isUp: Bool) {
        
        if isUp == false {
            //  表示向下的 pop 动画, 数组反转
            composeButtonArray = composeButtonArray.reversed()
        }
        
        //  遍历菜单按钮
        for (i, button) in self.composeButtonArray.enumerated() {
            //  创建 pop 动画对象
            let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            
            
            if isUp {
                //  动画执行的目的地
                animation?.toValue = NSValue(cgPoint: CGPoint(x: button.centerX, y: button.centerY - 350))
            } else {
                //  动画执行的目的地
                animation?.toValue = NSValue(cgPoint: CGPoint(x: button.centerX, y: button.centerY + 350))
                
            }
            
            //  弹簧系数 -> [0-20] 弹簧系数越大, 抖动幅度就越大
            animation?.springBounciness = 10
            //  初始速度系统 -> [0-20] 系数越大,动画结束越快
            animation?.springSpeed = 10
            //  设置动画开始时间, CACurrentMediaTime()获取系统的绝对时间-> 开机时间到现在的时间的秒数
            animation?.beginTime = CACurrentMediaTime() + Double(i) * 0.025
            button.pop_add(animation, forKey: nil)
            
            
            
        }
    }
    
    // MARK: - 点击菜单按钮操作
    @objc private func buttonAction(btn: UIButton) {
        
        UIView.animate(withDuration: 0.25, animations: { 
            
            for button in self.composeButtonArray {
                button.alpha = 0.2
                if button == btn {
                    //  表示要执行放大操作
                    
                    button.transform = CGAffineTransform(scaleX: 2, y: 2)
                    
                } else {
                    //  表示要执行缩小操作
                    button.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                    
                }
                
                
            }
            
            }) { (_) in
                
                
                UIView.animate(withDuration: 0.25, animations: { 
                    for button in self.composeButtonArray {
                        button.alpha = 1
                        button.transform = CGAffineTransform.identity
                    }
                    }, completion: { (_) in
                        //  弹出控制器
                        //  类名字符串转成对象的问题
                        //  1. 直接通过类名获取 class 返回 nil -> 解决办法 自己定义的类需要加上命名空间  let className = NSStringFromClass(HMComposeViewController.self)
                        //  2. 直接通过 class 创建对象保存,原因需要制定是什么 class 类型
                        //  获取控制类型
//                        let a = HMComposeViewController.self
                        
                        //  获取点击按钮对应的模型
                        
                        /******************** 跳转到目标控制器 start ***********************/
//                        let model = self.composeMenuArray[btn.tag]
                        
//                        let classType = NSClassFromString(model.className!) as! UIViewController.Type
//                        
//                        //  直接调用 init 构造函数
//                        let vc = classType.init()
//                        //  初始化导航视图控制器
//                        let nav = UINavigationController(rootViewController: vc)
//                       
//                        
//                        self.target?.present(nav, animated: true, completion: {
//                            //  移除罩层
//                            self.removeFromSuperview()
//                        })
                        /******************** 跳转到目标控制器 end ***********************/
                })
                
                
                
        }
    }
    
    //  显示罩层
    /*
        1. 要传人目标控制器
        2. 封装添加视图操作
     */
    func show(target: UIViewController) {
        //  记录目标控制器
        self.target = target
        //  获取 window , 获取最上面的 window
//        let window = UIApplication.shared.windows.last!
//        window.addSubview(self)
        //  把视图添加到目标控制器
        target.view.addSubview(self)
        //  开启 pop 动画
        startPopAnimation(isUp: true)
    
    }
    
    //  加载 plist 数据
    fileprivate func loadComposeData() -> [LSComposeMenu] {
        //  plist 文件路径
        let path = Bundle.main.path(forResource: "compose.plist", ofType: nil)!
        //  加载 plist 文件里面的数据
        let dicArray = NSArray(contentsOfFile: path)!
        
        //  使用 YYModel 完成字典转模型
        let modelArray = NSArray.yy_modelArray(with: LSComposeMenu.self, json: dicArray) as! [LSComposeMenu]
        
        return modelArray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
       startPopAnimation(isUp: false)
        //  使用 gcd 延时0.3秒后执行
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.removeFromSuperview()
       }
    }
}
