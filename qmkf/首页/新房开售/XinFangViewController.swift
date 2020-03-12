//
//  HomeViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/9.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class XinFangViewController : HideNavibarViewController,UITableViewDelegate,UITableViewDataSource {
     
    @IBOutlet weak var funcCollectionView: UICollectionView!
    @IBOutlet weak var advertisementCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerContentBackView: UIView!
    @IBOutlet weak var tableHeaderView: UIView!
    var contentCollectionView: UICollectionView!
    
    let functionCollectionController = XinFangFunctionCollectionController()
    let advertisementCollectionController = XinFangAdvertisementCollectionController()
    let bannerCollectionController = XinFangBannerCollectionController()
     
    var myTable : UITableView!
    var canBackScroll = true
    var canContentScroll = false
    var bannerBack = UIView()
    var backStopOffset = CGFloat(0)
    var segmentV : UserOrderSegmentView?
    let filter = MiddleFilterObject()
    var zDataModel : ZJSON? {
        didSet {
            self.myTable.reloadData()
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.addChild(advertisementCollectionController)
        self.addChild(bannerCollectionController)
        self.addChild(functionCollectionController)
         
        // 购房，计算器等功能 collection
        functionCollectionController.setFuncCollection(funcCollectionView)
        
        // 广告轮播图 collection
        advertisementCollectionController.setFuncCollection(advertisementCollectionView)
        
        // 横向滚动分类
        bannerBack.insertSubview(filter.getXinFangMenu(), at:0)
        weak var weakSelf = self
        filter.menuView.baseBlock = {(Any)->() in
            weakSelf!.bannerAction()
        }
        filter.menuView.y = 0
        
        // 内容
        initTable()
        self.advertisementCollectionController.arrayM = advertiseDataModel ?? []
        
           mj_refresh(self.myTable, self, #selector(refreshData))
    }
            
    @objc func refreshData() {

        let parameters : ZParameters = [
                "curPage": 0,
                "name": "string",
                "pageSize": 10
            ]
        weak var weakSelf = self
        post("hou-properties/properties/list", parameters: parameters, true, false) {(result) in
            weakSelf!.zDataModel = ZJSON(result)
            weakSelf?.myTable.reloadData()
        }
        self.myTable.mj_header?.endRefreshing()
    }
    
    func bannerAction() {
        myTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: false)
        filter.menuView.removeFromSuperview()
        filter.menuView.y = zNaviBar_Height
        self.view.addSubview(filter.menuView)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if filter.menuView.superview == self.view {
            bannerBack.insertSubview(filter.menuView, at:0)
            filter.menuView.y = 0
            filter.menuView.hideMenuList()
        }
    }
    
    func getHeight(_ view : UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    func initTable() {
        myTable = UITableView(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: zScreenHeight-CGFloat(zNaviBar_Height)), style: .plain)
        myTable.delegate = self
        myTable.dataSource = self
        myTable.showsVerticalScrollIndicator = false
        myTable.separatorStyle = .none
        
        let advertisementFrame = advertisementCollectionView.frame
        advertisementCollectionView.frame = CGRect(x: advertisementFrame.origin.x, y: advertisementFrame.origin.y + zSetWidth(5), width: advertisementFrame.size.width, height: zSetWidth(190))
        
        let frame = tableHeaderView.frame
        tableHeaderView.frame = CGRect(x: frame.origin.x, y: frame.origin.y , width: frame.size.width, height: zSetWidth(275))
        
        advertisementCollectionView.width = zScreenWidth
        funcCollectionView.width = zScreenWidth
        bannerBack.width = zScreenWidth
        
        myTable.tableHeaderView = self.tableHeaderView
        
        //XIB加载
        myTable.register(UINib.init(nibName: XinFangContentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: XinFangContentTableViewCell.reuseId)
        
        bannerContentBackView.addSubview(myTable)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let back = self.bannerBack
        return back
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zDataModel?["data"]["records"].count ?? 0 < 6 ? 6 : self.zDataModel?["data"]["records"].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XinFangContentTableViewCell.reuseId, for: indexPath) as! XinFangContentTableViewCell
        cell.selectionStyle = .none
        cell.model = self.zDataModel?["data"]["records"][indexPath.row] ?? ZJSON()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let xinFangDetail = "xinFangDetail"
        houseID = ZJSON(self.zDataModel?["data"]["records"][indexPath.row] ?? ZJSON())["id"].string ?? "2d93acd7be3b503a23dd3ef0eece2214"
        self.performSegue(withIdentifier: xinFangDetail, sender: "")
    }
}
 
class XinFangContentCollectionCell : BaseCollectionViewCell {
    
    var contentTable: UITableView! {
        didSet {
            self.contentTable.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.contentView.addSubview(self.contentTable)
        }
    }
    static let reuseId = "XinFangContentCollectionCell"
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            guard let image = UIImage.init(named: (m.name)!) else {
                return
            }
        }
    }
    
}

class XinFangContentTableViewCell : UITableViewCell {
    
    static let reuseId = "XinFangContentTableViewCell"
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var mianji: UILabel!
    @IBOutlet weak var xiaoqu: UILabel!
    @IBOutlet weak var houseType: UILabel!
    @IBOutlet weak var saleStatus: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var jijiren: UILabel!
    @IBOutlet weak var jinjirenImg: UIImageView!
    @IBOutlet weak var shop: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var model : Any! {
        didSet {
            let m = model as! ZJSON
            title.text = m["name"].string
            mianji.text = "\(m["coveredArea"].int ?? 0)m²"
            xiaoqu.text = m["residentiaName"].string ?? m["name"].string
//            houseType.text = m["buildingType"].string
            saleStatus.text = m["status"].string ?? m["salesStatus"].string
            location.text = m["salesAddress"].string
            self.type1.text = (m["houseType"].string ?? "").components(separatedBy: ",").count > 0 ? (m["houseType"].string ?? "").components(separatedBy: ",")[0] : ""
            self.type2.text = (m["houseType"].string ?? "").components(separatedBy: ",").count > 1 ? (m["houseType"].string ?? "").components(separatedBy: ",")[1] : "" 
            jijiren.text = m["title"].string
            shop.text = m["title"].string
//            jinjirenImg.text = m["title"].string
            self.img!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
        }
    }
}

// MARK: 购房，计算器等功能 collection
class XinFangFunctionCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    // 从polist中加载数据
    func loadData() {
        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "XinFangFunctionData.plist", ofType: nil)!)!
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
        flowLayout.itemSize = CGSize(width: zScreenWidth/5.5, height: zSetWidth(75))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
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
        if indexPath.row == 1 {
            self.parent!.performSegue(withIdentifier: zhaoJinJiRen, sender: "")
        } else if indexPath.row == 0 {
            loupanType  = .TypeAll 
            self.parent!.performSegue(withIdentifier: louPanList, sender: "")
        } else if indexPath.row == 2 {
            loupanType  = .TypeNew
            self.parent!.performSegue(withIdentifier: louPanList, sender: "")
        } else if indexPath.row == 3 {
            loupanType  = .TypeSale
            self.parent!.performSegue(withIdentifier: louPanList, sender: "")
        } else if indexPath.row == 4 {
            homeNav?.pushViewController(zHomeStoryboard("daiKuan") as! UIViewController, animated: true)
        }
    }
    
}

// MARK: 分栏排序 collection
class XinFangBannerCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //无参无返回值
    typealias baseBlock = () -> () //或者 () -> Void
    var baseBlock : baseBlock?
    
    var collectionView : UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    // 从polist中加载数据
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
        collectionView.isScrollEnabled = false
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: SortBannerCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: SortBannerCollectionCell.reuseId)
        
        loadData()
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth/4, height: zSetWidth(26))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortBannerCollectionCell.reuseId, for: indexPath) as! SortBannerCollectionCell
        cell.title = (self.arrayM[indexPath.row] as HomeModel).name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ((self.baseBlock) != nil) {
            self.baseBlock!()
        }
    }
} 

// MARK: 广告轮播图 collection
class XinFangAdvertisementCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
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
        collectionView.isScrollEnabled = false
        self.collectionView = collectionView
        
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: PuzzleAdvertisementCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: PuzzleAdvertisementCollectionCell.reuseId)
        
        startTimer()
    }
    
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
        flowLayout.itemSize = CGSize(width: zScreenWidth, height: zSetWidth(190))
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuzzleAdvertisementCollectionCell.reuseId, for: indexPath) as! PuzzleAdvertisementCollectionCell
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
