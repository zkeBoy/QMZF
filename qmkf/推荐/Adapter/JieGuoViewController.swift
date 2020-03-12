
//
//  JieGuoViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class JieGuoViewController: ShowNavibarViewController {
    
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "计算结果"
        
        drawPieChart(pieChartView)
        initTable(tableView)
        initTypeBannerCollectionView(typeCollectionView)
    }
    func initTypeBannerCollectionView(_ collectionView: UICollectionView) {
        let arr = NSMutableArray()
        loadFakeModelData(arr,2)
        (arr[0] as! HomeModel).selected = true
        (arr[0] as! HomeModel).textTheme.size = 20
        setupHorizontalCollectionFlowlayout(collectionView, zScreenWidth / 2, 43)
        let adapter = TypeBannerColectionViewAdapter(collectionView: collectionView, datas: arr, xib: true)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
            (arr[indexPath.row] as! HomeModel).textTheme.size = 20
        }
        self.adapters.add(adapter)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        tableViewHeight.constant = CGFloat(50 * arr.count + 70)
        
        let adapter = BaseSectionViewAdapter(tableView: table, sectionHeader: nil, sectionFooter: UIView.loadView(nibName:"TableFooterView_0"), cellClass: TableViewCell_7.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func drawPieChart(_ view : UIView) {
        let pieChart = CircleRingChartView(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: view.height), atPostiion: LegendPosition.bottom, withNameArray: ["首付总额","贷款总额","利息总计"], andDataArray: ["44","23","11"], andRadius: 86, andLineWidth: 30)
        pieChart.backgroundColor = .white
        pieChart.showPercentage = true
        pieChart.touchEnable = true
        pieChart.centerTitle = "月供"
        view.addSubview(pieChart)
        pieChart.resetData()
    }
}
