////
////  ListAdapterProtocal.swift
////  qmkf
////
////  Created by Mac on 2019/12/23.
////  Copyright © 2019 Mac. All rights reserved.
////
//
//import UIKit
//
//// Cell适配器层->CellAdapterProtocal
//protocol CellAdapterProtocal : UITableViewDataSource,UITableViewDelegate {
//    
////    func numberOfSections(in tableView: UITableView) -> Int
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//}
//
//// Section适配器层->SectionAdapterProtocal
//protocol SectionAdapterProtocal : UITableViewDataSource,UITableViewDelegate {
//    
////    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
////    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
////    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
////    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
////    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
//}
//
//// List列表适配器层->ListAdapterProtocal
//protocol ListAdapterProtocal : SectionAdapterProtocal,CellAdapterProtocal {
////    func numberOfSections(in tableView:UITableView) -> UIView
//}
