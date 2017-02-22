# HGJPullDownTool
* 制作类似微信下拉选择器
* 只支持右上角按钮，不然小箭头会显示有误

##CocoaPods
``` pod 'HGJPullDownTool' ```

##Requirements
* Swift
* Xcode 5 or higher
* iOS 6.0 or higher
* ARC

##ScreenShot
![](https://nj01ct01.baidupcs.com/file/0752911363111bb760023b3f09110782?bkt=p3-14000752911363111bb760023b3f09110782eb0c068800000001dfb2&fid=1649281771-250528-516542598084636&time=1487763526&sign=FDTAXGERLBHS-DCb740ccc5511e5e8fedcff06b081203-asAcsYf1cqei8UDUIpSl98YpzRU%3D&to=63&size=122802&sta_dx=122802&sta_cs=0&sta_ft=gif&sta_ct=0&sta_mt=0&fm2=MH,Yangquan,Netizen-anywhere,,guangdongct&newver=1&newfm=1&secfm=1&flow_ver=3&pkey=14000752911363111bb760023b3f09110782eb0c068800000001dfb2&sl=80937039&expires=8h&rt=sh&r=381943428&mlogid=1225012193629819486&vuk=1649281771&vbdid=107365255&fin=HGJPullDownTool1.gif&fn=HGJPullDownTool1.gif&rtype=1&iv=0&dp-logid=1225012193629819486&dp-callid=0.1.1&hps=1&csl=268&csign=gRHdHZJ9bvk2W7rLBQZAODX4I9c%3D&by=themis)

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
