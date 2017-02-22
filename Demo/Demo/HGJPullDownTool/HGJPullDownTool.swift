//
//  HGJPullDownTool.swift
//  test
//
//  Created by 胡古斤 on 2016/11/14.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

import UIKit

/** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 *//** 外部调用 */

class HGJPullDownTool: NSObject {
    
    //MARK: - Property
    private var overLayView : HGJOverlayView!
    private var toolView : HGJPullDownView!
    private var superView : UIView!
    
    /** block */
    private var clickBlock : HGJPullDownBlock?
    
    
    // 创建
    convenience init(superView: UIView, clickView: UIView, itemArr: Array<HGJPullDownToolItem>, selectedItem: @escaping HGJPullDownBlock) {
        self.init()
        
        self.superView = superView
        
        // 创建遮盖视图
        self.overLayView = HGJOverlayView(frame: superView.frame)
        superView.addSubview(self.overLayView)

        // 创建下拉视图
        self.toolView = HGJPullDownView(clickView: clickView, itemArr: itemArr, selectedItem: selectedItem)
        self.overLayView.addSubview(self.toolView)
        

        let triangle = HGJTriangle(standardView: clickView)
        self.overLayView.addSubview(triangle)
    }
    
    // 显示
    func show() -> Void {
        
        self.overLayView.show()
        
        self.superView.bringSubview(toFront: self.overLayView)
        
    }
    
    
}






























/** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 *//** 控件内使用 */






class HGJOverlayView: UIView {
    
    //MARK: - Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 通过设置半透明颜色保持子控件的透明度为1
        self.backgroundColor = UIColor(white: 92 / 255.0, alpha: 1).withAlphaComponent(0)
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - 单击消失
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.hide()
        
    }
    
    
    // 隐藏
    func hide() {
        
        
        // 隐藏triangle
        for triangle in self.subviews {
            if triangle.isKind(of: HGJTriangle.self) {
                (triangle as! HGJTriangle).hide()
            }
        }
        
        // 隐藏下拉菜单
        for view in self.subviews {
            if view.isKind(of: HGJPullDownView.self) {
                
                (view as! HGJPullDownView).hide {
                    
                    // 隐藏遮盖视图
                    self.backgroundColor = UIColor(white: 92 / 255.0, alpha: 1).withAlphaComponent(0)
                    self.isUserInteractionEnabled = false
                    
                }
                
            }
        }
        
    }
    
    
    
    // 显示
    func show() {
        
        self.backgroundColor = UIColor(white: 92 / 255.0, alpha: 1).withAlphaComponent(0.5)
        self.isUserInteractionEnabled = true
        
        
        // 显示triangle
        for triangle in self.subviews {
            if triangle.isKind(of: HGJTriangle.self) {
                (triangle as! HGJTriangle).show()
            }
        }

        
        // 显示下拉菜单
        for view in self.subviews {
            if view.isKind(of: HGJPullDownView.self) {
                
                (view as! HGJPullDownView).show {
                    
                }
            }
        }
        
        
    }
    
}










class HGJPullDownView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    /** 目标样式 */
    var toFrame = CGRect()
    var fromFrame = CGRect()
    
    /** 点击事件回调 */
    var clickBlock : HGJPullDownBlock?
    
    /** 数据源 */
    var getItemArr = Array<HGJPullDownToolItem>()
    var itemArr : Array<HGJPullDownToolItem> {
        
        set {
            self.getItemArr = newValue
            self.reloadData()
        }
        
        get {
            
            return self.getItemArr
            
        }
        
    }
    
    
    
    //MARK: - Initial
    convenience init(clickView: UIView, itemArr: Array<HGJPullDownToolItem>, selectedItem: @escaping HGJPullDownBlock) {
        
        // 设置自己的frame
        let width = 125
        let height = 44 * itemArr.count
        let x = UIScreen.main.bounds.width - (5 + 125)
        let y  = 64
        
        self.init(frame: CGRect(x: clickView.center.x, y: 64, width: 0, height: 0))
        
        // 赋值各项属性
        self.fromFrame = CGRect(x: Int(x + 30), y: 64, width: width - 30, height: height - 10 * itemArr.count)
        self.toFrame = CGRect(x: Int(x), y: y, width: Int(width), height: Int(height))
        self.itemArr = itemArr
        self.clickBlock = selectedItem
    }
    
    
    override func didMoveToSuperview() {
        
        // 设置表视图样式
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
        
        self.isScrollEnabled = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        
        self.delegate = self
        self.dataSource = self
        
    }
    
    
    //MARK: - PublicFunctions
    
    // 显示
    func show(finish: @escaping (Void) -> Void ) {
        
        // 显示所有cell
//        for i in 0..<self.numberOfRows(inSection: 0) {
//            let cell = self.cellForRow(at: IndexPath.init(row: i, section: 0))
//            cell?.isHidden = false
//        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.frame = self.toFrame
            }) { (bool) in
                finish()
        }
        
    }

    
    // 隐藏
    func hide(finish: @escaping (Void) -> Void ) {
        
        // 隐藏所有cell
//        for i in 0..<self.numberOfRows(inSection: 0) {
//            let cell = self.cellForRow(at: IndexPath.init(row: i, section: 0))
//            cell?.isHidden = true
//        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.frame = self.fromFrame
        }) { (bool) in
            finish()
        }
        
    }
    
    
    //MARK: - TableViewDatasource & TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HGJPullDownCell(style: .default, reuseIdentifier: "cell")
        
        cell.iconView.image = UIImage.init(named: self.itemArr[indexPath.row].iconName)
        cell.titleLable.text = self.itemArr[indexPath.row].title
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 取消选中状态
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 隐藏视图
        (self.superview as! HGJOverlayView).hide()
        
        // 回调
        if self.clickBlock != nil {
            self.clickBlock!(indexPath.row, self.itemArr[indexPath.row])
        }
        
    }
    
}













class HGJTriangle: UIView {
    
    var standardView = UIView()
    
    
    
    convenience init(standardView: UIView) {
        self.init()
        
        let height : CGFloat = 3.5
        let width : CGFloat = 125
        let x : CGFloat = UIScreen.main.bounds.width - 130
        let y = 64 - height
        
        self.backgroundColor = UIColor.clear
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.alpha = 0
        
        // 设置基准视图
        self.standardView = standardView
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        // 1.获取位图环境
        let context = UIGraphicsGetCurrentContext()
        
        // 2.设置路径
        let beginX = (self.frame.size.width + 5) - (UIScreen.main.bounds.width - self.standardView.center.x) - 3.5
        
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: beginX, y: 3.5))
        path.addLine(to: CGPoint(x: beginX + 3.5, y: 0))
        path.addLine(to: CGPoint(x: beginX + 7, y: 3.5))
        
        // 3.绘制路径
        context?.addPath(path)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillPath()
        
    }
    
    
    func hide() {
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        }
        
    }
    
    
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
}







class HGJPullDownCell: UITableViewCell {
    
    var iconView = UIImageView()
    var titleLable = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.titleLable.font = UIFont.systemFont(ofSize: 13)
        self.titleLable.adjustsFontSizeToFitWidth = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置图标约束
        self.setUpIconView()
        
        // 设置文本约束
        self.setUpTitleLabel()
    }
    
    
    /** 图标约束 */
    func setUpIconView() {
        
        self.contentView.addSubview(self.iconView)
        self.iconView.translatesAutoresizingMaskIntoConstraints = false
        
        // 水平居中
        let horizontal = NSLayoutConstraint(item: self.iconView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        self.contentView.addConstraint(horizontal)
        
        // 左对齐
        let left = NSLayoutConstraint(item: self.iconView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 21)
        self.contentView.addConstraint(left)
        
        // 1:1比例
        let ratio = NSLayoutConstraint(item: self.iconView, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: self.iconView, attribute: .height, multiplier: 1, constant: 0)
        self.iconView.addConstraint(ratio)
        
        // 宽高值
        let height = NSLayoutConstraint(item: self.iconView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        self.iconView.addConstraint(height)
        
        
    }
    
    /** 标题约束 */
    func setUpTitleLabel() {
        
        self.contentView.addSubview(self.titleLable)
        self.titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        // 水平居中
        let horizontal = NSLayoutConstraint(item: self.titleLable, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        self.contentView.addConstraint(horizontal)
        
        // 左对齐
        let left = NSLayoutConstraint(item: self.titleLable, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.iconView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 12)
        self.contentView.addConstraint(left)
        
        // 宽度
        let width = NSLayoutConstraint(item: self.titleLable, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 65)
        self.titleLable.addConstraint(width)
        
    }
    
    
    
}






class HGJPullDownToolItem: NSObject {
    
    /** 图片名 */
    var iconName = String()
    
    /** 标题 */
    var title = String()
    
    
    /** 快速创建item数组 */
    class func itemArrayFrom(iconNameArr: Array<String>, titleArr: Array<String>) -> Array<HGJPullDownToolItem> {
        
        var resultArr = Array<HGJPullDownToolItem>()
        
        if iconNameArr.count == titleArr.count {
            
            for i in 0..<iconNameArr.count {
                
                let item = HGJPullDownToolItem()
                item.iconName = iconNameArr[i]
                item.title = titleArr[i]
                resultArr.append(item)
                
            }
            
        }else {
            let item = HGJPullDownToolItem()
            item.iconName = "数组数量不一致"
            resultArr.append(item)
        }
        
        return resultArr
    }
    
}



/** 回调类型 */

typealias HGJPullDownBlock = (_ index: Int, _ item: HGJPullDownToolItem) -> Void









