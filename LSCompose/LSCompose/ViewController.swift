//
//  ViewController.swift
//  LSCompose
//
//  Created by WangBiao on 2016/11/24.
//  Copyright © 2016年 lsrain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /* 点击屏幕即可触发pop动画 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let composeView = LSComposeView()
        
        composeView.show(target: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

