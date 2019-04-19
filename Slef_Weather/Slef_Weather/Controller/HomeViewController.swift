//
//  ViewController.swift
//  Slef_Weather
//
//  Created by Caulifeld on 2019/4/17.
//  Copyright © 2019 caulifeld. All rights reserved.
//

import UIKit
import FWPopupView

/// 状态栏高度
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let kNavBarHeight: CGFloat = 44.0


class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageLab: UILabel!
    @IBOutlet weak var tempLab: UILabel!
    @IBOutlet weak var aqiBtn: UIButton!
    
    
    
    let titles = ["创建群聊", "加好友/群", "扫一扫", "面对面快传", "付款", "拍摄"]
    let images2 = [UIImage(named: "right_menu_multichat_white"),
                   UIImage(named: "right_menu_addFri_white"),
                   UIImage(named: "right_menu_QR_white"),
                   UIImage(named: "right_menu_facetoface_white"),
                   UIImage(named: "right_menu_payMoney_white"),
                   UIImage(named: "right_menu_sendvideo_white")]
    
    lazy var menuView2: FWMenuView = {
        
        let vProperty = FWMenuViewProperty()
        vProperty.popupCustomAlignment = .topRight
        vProperty.popupAnimationType = .scale
        vProperty.maskViewColor = UIColor(white: 0, alpha: 0.2)
        vProperty.touchWildToHide = "1"
        vProperty.popupViewEdgeInsets = UIEdgeInsets(top: kStatusBarHeight + kNavBarHeight, left: 0, bottom: 0, right: 8)
        vProperty.topBottomMargin = 0
        vProperty.animationDuration = 0.3
        vProperty.popupArrowStyle = .round
        vProperty.popupArrowVertexScaleX = 1
        vProperty.backgroundColor = kPV_RGBA(r: 64, g: 63, b: 66, a: 1)
        vProperty.splitColor = kPV_RGBA(r: 64, g: 63, b: 66, a: 1)
        vProperty.separatorColor = kPV_RGBA(r: 91, g: 91, b: 93, a: 1)
        vProperty.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        vProperty.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        let menuView = FWMenuView.menu(itemTitles: titles, itemImageNames: images2 as? [UIImage], itemBlock: { (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
        }, property: vProperty)
        //                menuView.attachedView = self.view
        
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupContext()
        
//        messageLab
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*2)
        
    }
    @IBAction func clickMore(_ sender: Any) {
        print(123)
        self.menuView2.show()
    }
}

extension HomeViewController{
    
    fileprivate func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        
        
    }
    fileprivate func setupContext (){
//        let  ContextView = UIScrollView()
//        ContextView.isPagingEnabled = true
//        ContextView.frame = self.view.frame
//        ContextView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*2)
//        ContextView.isPagingEnabled = false
//        ContextView.showsVerticalScrollIndicator = true
//        ContextView.indicatorStyle = .white
//        //打开交互事件
//        ContextView.isUserInteractionEnabled = true
//
//        //1.创建textView对象
//        //UITextView:UIScrollView : UIView
//        let textView = UITextView.init(frame: CGRect(x: 0, y: 0, width:view.bounds.width , height: 20))
//        //2.添加到界面上
//        textView.font = UIFont.systemFont(ofSize: 10)
//        textView.textColor = UIColor.lightGray
//        //3.设置背景颜色
//        textView.backgroundColor = UIColor.clear
//        //4.text属性
//        textView.text = " 晚睡的人很危险"
//        //5.设置是否可以选中和编辑
//        //默认是true -> 可以选中和编辑
//        textView.isSelectable = false
//        //6.是否可以选中删除所有
//       // textView.clearsOnInsertion = true
//        let temp_lable = UILabel.init()
//        let temp = 25
//        temp_lable.text = String(temp)+"°"
//        temp_lable.textColor = UIColor.white
//
//        temp_lable.font =  UIFont.init(name: "PingFangSC-Thin", size: 60)
//        temp_lable.frame = CGRect(x: 5, y: view.bounds.height-200, width: 100, height: 60)
//
//
//        ContextView.addSubview(temp_lable)
//         ContextView.addSubview(textView)
//        self.view.addSubview(ContextView)
        
        
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.contentOffset.y

    }
}
