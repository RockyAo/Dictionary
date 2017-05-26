//
//  HomeViewController.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {

    var viewModel: HomeViewModel!
    
    lazy var searchBar: UISearchBar = {
        
        let sb = UISearchBar()
        sb.placeholder = "请输入要翻译的文本"
        sb.tintColor = UIColor.black
        sb.barTintColor = UIColor.Main.backgroundGray
        sb.searchBarStyle = .minimal
        let textfield = sb.value(forKey: "_searchField") as? UITextField
        textfield?.textColor = UIColor.Main.gray.dark
    
        return sb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        initializeCoordinator()
        
        setupSubviews()
        
        bindViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = ""
    }
    
    func bindViewModel() {
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        viewModel.translateData
            .subscribe{
        
                print($0)
            }
            .addDisposableTo(disposeBag)
    }

}

extension HomeViewController{

    fileprivate func initializeCoordinator(){
    
        let coordinator = SceneCoordinator(currentViewController: self)

        viewModel = HomeViewModel(coordinator: coordinator,service: HomeServices())
    }
    
    fileprivate func setupSubviews() {
        
        
        view.backgroundColor = UIColor.Main.backgroundGray
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { (make) in
            
            make.top.equalTo(0);
            make.left.equalTo(10);
            make.height.equalTo(44);
            make.right.equalTo(-10);
        }
    }
}
