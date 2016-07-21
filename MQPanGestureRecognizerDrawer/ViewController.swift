//
//  ViewController.swift
//  MQPanGestureRecognizerDrawer
//
//  Created by mengmeng on 16/7/21.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit
/**
 1. 使用 pan 手势，实现抽屉效果
 2. KVO 监听 frame 值改变，显示／隐藏 View
 */
class ViewController: UIViewController {
    
    let leftView = UIView()
    let rightView = UIView()
    let mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpChildViews()
        
        // 添加拖拽手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        view.addGestureRecognizer(pan)
        
        /// 使用 KVO 实时监听 mainView 的 frame 属性
        ///
        /// - parameter forKeyPath: 观察者（谁想监听）
        /// - parameter options:    监听的属性
        /// - parameter context:    监听新值的改变
        mainView.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    /// 只要监听到属性一改变，就会调用观察者的此方法，通知有新值
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        // 判断是否左／右滑动
        if mainView.frame.origin.x > 0 { // 右滑
            rightView.hidden = true
        } else if mainView.frame.origin.x < 0 { // 左滑
            rightView.hidden = false
        }
    }
    
    // 移除观察者
    deinit{
        mainView.removeObserver(self, forKeyPath: "frame")
    }
    
    func panClick(pan:UIPanGestureRecognizer){
        
        // 获取移动位置
        let transP = pan.translationInView(view)
        mainView.frame = frameWithOffsetX(transP.x)
        // 复位
        pan.setTranslation(CGPoint.zero, inView: view)
        
    }
    
    /// 根据偏移 x 重新设置 mainView.frame
    func frameWithOffsetX(offsetx:CGFloat)->CGRect{
        var mainF = mainView.frame
        mainF.origin.x += offsetx
        return mainF
    }
    
    // 设置 View
    func setUpChildViews(){
        leftView.frame = view.bounds
        leftView.backgroundColor = UIColor.greenColor()
        view.addSubview(leftView)
        rightView.frame = view.bounds
        rightView.backgroundColor = UIColor.yellowColor()
        view.addSubview(rightView)
        mainView.frame = view.bounds
        mainView.backgroundColor = UIColor.orangeColor()
        view.addSubview(mainView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

