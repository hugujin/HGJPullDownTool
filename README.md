
# HGJPullDownTool
* 制作类似微信下拉选择器
* 只支持右上角按钮，不然小箭头会显示有误

##CocoaPods

* 你可以
``` pod 'HGJPullDownTool' ```

* 也可以`Clone or download`，然后把`HGJPullDownTool.swift`拖入你的项目中



##Requirements
* Swift
* Xcode 5 or higher
* iOS 6.0 or higher
* ARC

##ScreenShot
![](https://thumbnail0.baidupcs.com/thumbnail/0752911363111bb760023b3f09110782?fid=1649281771-250528-516542598084636&time=1488186000&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-2G90hkw2yv4c%2Bm29hRPSKRM8%2BzA%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=1339282281263123214&dp-callid=0&size=c710_u400&quality=100)

##Usage Demo
+ FirstStep （创建对象）
```swift
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

            // 点击按钮后的回调
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

```
+ Second （创建方法点击按钮显示下拉窗）
```swift
    private func showToolView() {
        self.pullDownTool?.show()
    }
```

##Demo
> DownLoad获取压缩文件里面的Demo获取更详细的信息


##Contact
>如果你发现bug或有更好的改进，please pull reqeust me
