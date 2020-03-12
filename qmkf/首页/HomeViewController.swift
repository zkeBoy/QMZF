//
//  HomeViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/9.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

var homeNav : UINavigationController? = UINavigationController()

class HomeViewController : HideNavibarViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var homeNavView: UIView!
    @IBOutlet weak var homeBackImageView: UIImageView!
    @IBOutlet weak var backScrollView: MFAllowGestureEventPassTableView!
    @IBOutlet weak var funcCollectionView: UICollectionView!
    @IBOutlet weak var advertisementCollectionView: UICollectionView!
    @IBOutlet weak var hangqingCollectionView: UICollectionView!
    @IBOutlet weak var bannerBackView: UIView!
    @IBOutlet weak var bannerContentBackView: UIView!
    @IBOutlet weak var bannerContentBackViewHeight: NSLayoutConstraint!
    var contentCollectionView: UICollectionView!
    
    let functionCollectionController = FunctionCollectionController()
    let advertisementCollectionController = AdvertisementCollectionController()
    let hangqingCollectionController = HangqingCollectionController()
    let contentCollectionController = ContentCollectionController()
    
    var canScrollTable : [UITableView?] = []
    var canBackScroll = true
    var canContentScroll = false
    var backStopOffset = CGFloat(0)
    var segmentV : UserOrderSegmentView?
    var nowContentTable : UITableView?
    var newHouseModel : ZJSON = [] {
        didSet {
            self.nowContentTable!.reloadData()
        }
    }
    
    @objc func refreshData() {
        
        weak var weakSelf = self
        var parameters : ZParameters = [
                "curPage": 0,
                "pageSize": 0,
                "portId": "cms_port_ios",
                "showType": "cms_banner_new_house_sale",
                "title": "string"
            ]
        post("cms-banner/list", parameters: parameters, true, false) {(result) in
            advertiseDataModel = ZJSON(result)
            weakSelf!.advertisementCollectionController.arrayM = advertiseDataModel!
        }
        
        parameters = [
             "regionId": "string",
            "regionName": "string"
        ]
        post("cms-region/qegionalQuotations", parameters: parameters, true, false) {(result) in
            weakSelf!.hangqingCollectionController.arrayM = ZJSON(result)
        }
        
        parameters = [
            "curPage": 0,
            "pageSize": 0,
            "salesStatus": "",
            "buildingType": "",
            "name": ""
        ]
        post("hou-properties/properties/list", parameters: parameters, true, false) {(result) in
            weakSelf!.newHouseModel = ZJSON(result)
        }
         
        self.backScrollView.mj_header?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        homeNav = self.navigationController
        
        backScrollView.delegate = self
        
        // 购房，计算器等功能 collection
        functionCollectionController.setFuncCollection(funcCollectionView)
        
        // 广告轮播图 collection
        advertisementCollectionController.setFuncCollection(advertisementCollectionView)
        
        // 行情 collection
        hangqingCollectionController.setFuncCollection(hangqingCollectionView)
        
        // 横向滚动分类
        setBanner(bannerBackView)
        
        
        // 分类内容
        // 先设置内容高度
        bannerContentBackViewHeight.constant =  zScreenHeight-getHeight(bannerBackView)-CGFloat(zTabBar_Height)-CGFloat(113+zNaviBar_Height-44)
        
        contentCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: bannerContentBackViewHeight.constant),collectionViewLayout: UICollectionViewFlowLayout())
        
        initCanScrollTable()
        contentCollectionController.setFuncCollection(contentCollectionView,canScrollTable)
        contentCollectionController.baseBlock = {(index)->() in
            self.segmentV?.setSelectedIndex(index)
        }
        bannerContentBackView.addSubview(contentCollectionView)
        
        mj_refresh(self.backScrollView, self, #selector(refreshData))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeNavView.layer.masksToBounds = true
    }
    
    @IBAction func getLocation(_ sender: Any) {
        weak var weakSelf = self
        var parameters : [String : Any] = ["":""]
        post("cms-region/all", parameters: parameters, true, false) {(result) in
            weakSelf!.newHouseModel = ZJSON(result)
        }
    }
    
    // MARK: 横向分类
    func setBanner(_ backView : UIView) {
        segmentV = UserOrderSegmentView.init(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: 34))
        weak var weakSelf = self
        segmentV!.clickedBlock = { (index) -> () in
            weakSelf!.contentCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
            weakSelf!.nowContentTable = weakSelf!.canScrollTable[index]
        }
        backView.addSubview(segmentV!)
    }
    
    func getHeight(_ view : UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        backStopOffset = getHeight(funcCollectionView) + getHeight(advertisementCollectionView) + getHeight(hangqingCollectionView)
        
        // 如果背景可以滚动时
        if canBackScroll {
            // 子table保持相对静止
            if self.canScrollTable.contains(scrollView as? UITableView) {
                // 这里通过固定contentOffset，来实现不滚动
                scrollView.contentOffset = .zero
            }
            // 滚动，当滚动到超过设定高度时，重设以停止背景
            if scrollView.contentOffset.y >= backStopOffset {
                // 禁止背景滚动，进入子table滚动判断
                canBackScroll = false
                canContentScroll = true
            }
        }
            // 背景不能滚动，子table能滚动
        else {
            if !self.canScrollTable.contains(scrollView as? UITableView) {
                // 这里通过固定contentOffset，来实现不滚动
                scrollView.contentOffset.y = backStopOffset
            }
            if canContentScroll && scrollView.contentOffset.y <= 0 {
                // 如果子table向下滚动到超出自己的内容时
                canBackScroll = true
                canContentScroll = false
                scrollView.contentOffset = .zero
                for scrollV in self.canScrollTable {
                    scrollV?.contentOffset = .zero
                }
            }
        }
    }
    
    func initCanScrollTable() {
        for i in 0 ..< 7{
            let table = UITableView()
            table.delegate = self
            table.dataSource = self
            table.tag = i + 10015
            table.showsVerticalScrollIndicator = false
            table.separatorStyle = .none
            
            //XIB加载
            table.register(UINib.init(nibName: ContentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ContentTableViewCell.reuseId)
            self.canScrollTable.add(table)
        }
        nowContentTable = self.canScrollTable[0]
        self.backScrollView.allowGestureEventPassViews = self.canScrollTable as [Any]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newHouseModel["data"]["records"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withReuseIdentifier: ContentTableViewCell.reuseId, for: indexPath) as! ContentTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.reuseId, for: indexPath) as! ContentTableViewCell
        cell.selectionStyle = .none
        cell.model = self.newHouseModel["data"]["records"][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
//        houseID = ZJSON(self.newHouseModel["data"]["records"][indexPath.row])["id"].string ??
            houseID = "2d93acd7be3b503a23dd3ef0eece2214"
        if tableView.tag - 10015 == 0 {
            detailTitle = "新房"
            homeNav?.pushViewController(zXinFangStoryboard("XinFangDetailViewController") as! UIViewController, animated: true)
        }
        else if tableView.tag - 10015 == 1 {
            detailTitle = "二手房"
//            homeNav?.pushViewController(zErShouFangStoryboard("ErShouFangDetailViewController") as! UIViewController, animated: true)
            homeNav?.pushViewController(zXinFangStoryboard("XinFangDetailViewController") as! UIViewController, animated: true)
        }
        else if tableView.tag - 10015 == 2 {
            detailTitle = "租房"
            homeNav?.pushViewController(zZuFangStoryboard("ZuFangDetailViewController") as! UIViewController, animated: true)
        }
        
    }
}

class ContentTableViewCell : UITableViewCell {
    
    static let reuseId = "ContentTableViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var houseName: UILabel!
    @IBOutlet weak var privice: UILabel!
    @IBOutlet weak var mianji: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var model : Any? {
        didSet {
            let m = model as! ZJSON
            houseName.text = m["name"].string
            title.text = m["label"].string
            privice.text = m["unitPrice"].string
            mianji.text = m["floorSpace"].string
            self.imageView!.sd_setImage(with: URL(string: m["showPictures"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
        }
    }
}

// MARK: 分栏内容 collection
class ContentCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //无参无返回值
    typealias baseBlock = (Int) -> () //或者 () -> Void
    var baseBlock : baseBlock?
    var collectionView : UICollectionView!
    var tableArray : [UITableView?] = []
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            //            self.collectionView.zAutoConstant()
        }
    }
    
    func setFuncCollection(_ collectionView : UICollectionView,_ tmpTableArray : [UITableView?]) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
        
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: ContentCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: ContentCollectionCell.reuseId)
        
        tableArray = tmpTableArray
        
        // 加载数据
        loadData()
    }
    
    // 从polist中加载数据
    func loadData() {
        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "AdvertisementData.plist", ofType: nil)!)!
        var temArr = [HomeModel]()
        for dict in stemp {
            let model = HomeModel.init(dict: dict as! [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth, height: collectionView.frame.size.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionCell.reuseId, for: indexPath) as! ContentCollectionCell
        cell.model = self.arrayM[indexPath.row % self.arrayM.count]
        cell.contentTable = tableArray[safe:indexPath.row]!!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.baseBlock!(Int(scrollView.contentOffset.x / zScreenWidth))
    }
    
}

class ContentCollectionCell : BaseCollectionViewCell {
    
    var contentTable: UITableView! {
        didSet {
            self.contentTable.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.contentView.addSubview(self.contentTable)
        }
    }
    static let reuseId = "ContentCollectionCell"
    
    override var model : Any? {
        didSet {
            let m = model as! HomeModel
            if let image = UIImage.init(named: (m.name)!) {
                
            }
        }
    }
    
}

// MARK: 行情 collection
class HangqingCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : ZJSON = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: HangqingCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: "\(HangqingCollectionCell.reuseId)0")
        self.collectionView?.register(UINib.init(nibName: HangqingCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: "\(HangqingCollectionCell.reuseId)1")
        self.collectionView?.register(UINib.init(nibName: HangqingCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: "\(HangqingCollectionCell.reuseId)2")
         
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (zScreenWidth-35)/3, height: zSetWidth(80))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HangqingCollectionCell.reuseId)\(indexPath.row)", for: indexPath) as! HangqingCollectionCell
        
        cell.index = indexPath.row
        cell.model = self.arrayM["data"]["records"][indexPath.row]
        switch indexPath.row {
        case 0:
            cell.titleIcon.isHidden = false
            cell.detailLabel.text = "详细"
            break
        case 1:
            cell.detailLabel1.isHidden = false
            cell.detailIconDown.isHidden = false
            cell.detailLabel1.text = "-15.38%"
            cell.detailIconRise.isHidden = true
            break
        case 2:
            cell.detailLabel1.isHidden = false
            cell.detailLabel1.text = "+5.38%"
            cell.detailIconRise.isHidden = false
            cell.detailIconDown.isHidden = true
            break
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
class HangqingCollectionCell : BaseCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailLabel1: UILabel!
    @IBOutlet weak var titleIcon: UIImageView!
    @IBOutlet weak var detailIconRise: UIImageView!
    @IBOutlet weak var detailIconDown: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var index = 0
    static let reuseId = "HangqingCollectionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override var model : Any? {
        didSet {
            let m = model as! ZJSON
            if index == 0 {
                
            } else if index == 1 {
                self.titleLabel.text = m["newPrice"].string ?? m["secondPrice"].string ?? "13956元/㎡"
                self.detailLabel1.text = m["newGrowth"].string ??  m["secondGrowth"].string ?? "城市行情"
            } else {
                self.titleLabel.text = m["newPrice"].string ?? m["secondPrice"].string ?? "15956元/㎡"
                self.detailLabel1.text = m["newGrowth"].string ??  m["secondGrowth"].string ?? "城市行情"
            }
        }
    }
}

// MARK: 广告轮播图 collection
class AdvertisementCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : ZJSON = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    var timer : Timer?
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: AdvertisementCornerCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: AdvertisementCornerCollectionCell.reuseId)
        
        // 加载数据
//        loadData()
        startTimer()
    }
    
//    // 从plist中加载数据
//    func loadData() {
//        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "AdvertisementData.plist", ofType: nil)!)!
//        var temArr = [HomeModel]()
//        for dict in stemp {
//            let model = HomeModel.init(dict: dict as! [String : Any])
//            temArr.append(model)
//        }
//        self.arrayM = temArr
//    }
    
    // 开启定时器
    func startTimer () {
        let timer = Timer.init(timeInterval: 3, target: self, selector: #selector(self.nextPage), userInfo: nil, repeats: true)
        // 这一句代码涉及到runloop 和 主线程的知识,则在界面上不能执行其他的UI操作
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)

        self.timer = timer

    }
    
    // 在1秒后,自动跳转到下一页
    @objc func nextPage() {
        // 如果到达最后一个,则变成第四个
        if collectionView.contentOffset.x == CGFloat(3 * self.arrayM.count - 1) * self.collectionView.bounds.width {
            self.collectionView.contentOffset.x = CGFloat(self.arrayM.count) * self.collectionView.bounds.width
        }else {
            // 每过一秒,contentOffset.x增加一个cell的宽度
            self.collectionView.contentOffset.x += self.collectionView.bounds.size.width
        }
        
    }
    
    // 当collectionView开始拖动的时候,取消定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // 当用户停止拖动的时候,开启定时器
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        startTimer()
    }
    
    // 滚动到头或尾时跳转
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //contentOffset.x == 0 时,重新设置contentOffset.x的值
        if collectionView.contentOffset.x == 0 {
            self.collectionView.contentOffset.x = CGFloat(2 * self.arrayM.count) * self.collectionView.bounds.width
            
        }
        //当到达最后一个cell时,重新设置contentOffset.x的值
        if collectionView.contentOffset.x == CGFloat(3 * self.arrayM.count - 1) * self.collectionView.bounds.width {
            self.collectionView.contentOffset.x = CGFloat(self.arrayM.count - 1) * self.collectionView.bounds.width
        }
        
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth, height: zSetWidth(120))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayM["data"]["records"].count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementCornerCollectionCell.reuseId, for: indexPath) as! AdvertisementCornerCollectionCell
        cell.model = self.arrayM["data"]["records"][indexPath.row % self.arrayM.count]
        cell.imageView.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个section的头尾视图
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //    }
}

class AdvertisementCornerCollectionCell : BaseCollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    static let reuseId = "AdvertisementCornerCollectionCell"
    
    override var model : Any? {
        didSet {
            let m = model as! ZJSON
            self.imageView!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
        }
    } 
}

class HomeModel : NSObject {
    
    var hangqingModel = [Any]()
    var name : String! = nil
    var imgName : String! = nil
    var index : NSNumber!
    var selected : Bool!
    var textTheme : zTextTheme! = zTextThemeFont13()
    
    init(dict : [String : Any]) {
        self.name = dict["name"] as? String
        self.imgName = dict["imgName"] as? String
        self.index = dict["index"] as? NSNumber
        self.selected = false
    }
    
    init(hangqing : [Any]) {
        self.hangqingModel = hangqing
    }
}


// MARK: 购房，计算器等功能 collection
class FunctionCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    // 从plist中加载数据
    func loadData() {
        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "FunctionData.plist", ofType: nil)!)!
        var temArr = [HomeModel]()
        for dict in stemp {
            let model = HomeModel.init(dict: dict as! [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: FunctionCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: FunctionCollectionCell.reuseId)
        
        loadData()
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth/5, height: zSetWidth(75))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayM != nil ? self.arrayM.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FunctionCollectionCell.reuseId, for: indexPath) as! FunctionCollectionCell
        cell.model = self.arrayM[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FunctionCollectionCell
        if cell.titleLabel.text == "新房开售" {
            homeNav?.pushViewController(zXinFangStoryboard("") as! UIViewController, animated: true)
        } else if cell.titleLabel.text == "二手房" {
            homeNav?.pushViewController(zErShouFangStoryboard("") as! UIViewController, animated: true)
        } else if cell.titleLabel.text == "租房" {
            homeNav?.pushViewController(zZuFangStoryboard("") as! UIViewController, animated: true)
        } else if cell.titleLabel.text == "购房百科" {
            homeNav?.pushViewController(zBaiKeStoryboard("") as! UIViewController, animated: true)
        } else if cell.titleLabel.text == "贷款计算" {
            homeNav?.pushViewController(zHomeStoryboard("daiKuan") as! UIViewController, animated: true)
        } else if cell.titleLabel.text == "论坛" {
            homeNav?.pushViewController(zHomeStoryboard("lunTan") as! UIViewController, animated: true)
        } else {
            homeNav?.pushViewController(zXinFangStoryboard("ZhaoJinJiRenViewController") as! UIViewController, animated: true)
            
        }
    }
    
    // 每个section的头尾视图
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //    }
}
