//
//  RootViewController.swift
//  Demo
//
//  Created by 胡古斤 on 2017/2/22.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    //MARK: - Property
    
    var pullDownTool : HGJPullDownTool?
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 添加右上角加号按钮
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        rightBtn.setBackgroundImage(UIImage.init(named: "addIcon"), for: .normal)
        rightBtn.addTarget(self, action: #selector(self.showToolView), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        // 2. 设置数据源
        let items = HGJPullDownToolItem.itemArrayFrom(iconNameArr:["1", "2", "3",], titleArr:["查找好友", "新的朋友", "查找群组"])
        
        
        // 3 创建下拉菜单
        self.pullDownTool = HGJPullDownTool(superView: UIApplication.shared.windows[0], clickView: rightBtn, itemArr: items, selectedItem: { (i, item) in
            
            // 0.1 创建控制器
            let vc = UIViewController()
            var titleArr = ["查找好友","新的朋友","查找群组"]
            var colorArr = [UIColor.red, UIColor.green, UIColor.brown]
            
            // 0.2 个性化
            vc.title = titleArr[i]
            vc.view.backgroundColor = colorArr[i]
            
            
            // 1.显示控制器
            self.navigationController?.pushViewController(vc, animated: true)
            
        })
   
    }
    
    
    
    //MARK: - BtnAction
    
    /** AddBtnAction */
    func showToolView() {
        self.pullDownTool?.show()
    }
    
    
    


}
