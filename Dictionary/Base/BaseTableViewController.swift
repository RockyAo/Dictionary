//
//  BaseTableViewController.swift
//  Dictionary
//
//  Created by Rocky on 2017/6/16.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewController: UITableViewController {

    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = [.left,.right,.bottom]
    }

}
