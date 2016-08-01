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
        
//        /// 使用 KVO 实时监听 mainView 的 frame 属性（比较耗性能）
//        ///
//        /// - parameter forKeyPath: 观察者（谁想监听）
//        /// - parameter options:    监听的属性
//        /// - parameter context:    监听新值的改变
//        mainView.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
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
    
//    // 移除观察者
//    deinit{
//        mainView.removeObserver(self, forKeyPath: "frame")
//    }
    
    func panClick(pan:UIPanGestureRecognizer){
        
        // 获取移动位置
        let transP = pan.translationInView(view)
        mainView.frame = frameWithOffsetX(transP.x)
        
        // (不使用KVO)判断 mainView 的X 是否 >0
        observeValueForKeyPath(nil, ofObject: nil, change: nil, context: nil)
        
        // 复位
        pan.setTranslation(CGPoint.zero, inView: view)
        
    }
    
    /// 根据偏移 x 重新设置 mainView.frame
    /// 手指往右移，视图X轴也要右移（x++），Y轴往下移（y增加）,尺寸缩放（按比例）
    func frameWithOffsetX(offsetx:CGFloat)->CGRect{
        
        // 获取上一次的frame
        var mainF = mainView.frame
        
        // mainView 下移的最大值
        let maxY:CGFloat = 80.0
        let screenH = UIScreen.mainScreen().bounds.size.height
        
        // X 轴每平移一点，Y轴也需要移动
        let offsetY = offsetx * maxY / screenH
        
        // 获取上一次的高度
        let preH = mainF.size.height
        let preW = mainF.size.width
        
        // 获取当前高度
        var currentH = preH - 2 * offsetY
        
        if mainF.origin.x < 0 { // 左移
            currentH = preH + 2 * offsetY
        }
        
        // 获取缩放比例
        let scale = currentH / preH

        // 获取当前宽度
        let currentW = preW * scale
        // 获取当前X
        mainF.origin.x += offsetx
        mainF.origin.y = (screenH - currentH) * 0.5
        
        mainF.size.height = currentH
        mainF.size.width = currentW
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

