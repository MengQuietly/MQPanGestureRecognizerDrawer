//
//  MQDemoMainController.swift
//  MQPanGestureRecognizerDrawer
//
//  Created by mengmeng on 16/8/1.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/// Demo VC 继承了 ViewController 则就会拥有 ViewController 的效果
class MQDemoMainController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let table = MQDemoTableController()
        table.view.frame = self.view.bounds
        // 设计原理：若A 控制器的View 成为 B控制器View 的子控件，注意 A 控制器一定要成为B控制器的子控制器（防止控制器被销毁）
        self.addChildViewController(table)
        // 主视图展示 tableview
        mainView.addSubview(table.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
