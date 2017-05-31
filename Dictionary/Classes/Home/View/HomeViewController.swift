//
//  HomeViewController.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import SnapKit
import Action
import SVProgressHUD
import RxDataSources

let cellIdentifier = "HOME_TABLE_CELL"

class HomeViewController: BaseViewController {

    var viewModel: HomeViewModel!
    
    lazy var searchBar: UISearchBar = {
        
        let sb = UISearchBar()
        sb.placeholder = "input word what you want to search"
        sb.tintColor = UIColor.black
        sb.barTintColor = UIColor.Main.backgroundGray
        sb.searchBarStyle = .minimal
        let textfield = sb.value(forKey: "_searchField") as? UITextField
        textfield?.textColor = UIColor.Main.gray.dark
    
        return sb
    }()
    
    lazy var wordView: WordView = {
        let wv = WordView()
        wv.sizeToFit()
        wv.isHidden = true
        return wv
    }()
    
    lazy var tabbleView: UITableView = {
        
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.register(UINib.init(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tb.hideBottomLine()
        return tb
    }()
    
    let dataSource = RxTableViewSectionedAnimatedDataSource<WordSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        initializeCoordinator()
        
        setupSubviews()
        
        bindViewModel()
        configureTabbleView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = ""
        
        
    }
    
    func bindViewModel() {
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        searchBar.rx.text.orEmpty.asDriver()
            .map {
                return $0.characters.count <= 0
            }
            .drive(wordView.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        viewModel.translateData
            .drive(wordView.rx.configureData)
            .addDisposableTo(disposeBag)
        
        viewModel.sectionItems
            .bind(to: tabbleView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        wordView.playButton.rx.bind(to: viewModel.playAudioAction) { _  in
            
            return self.wordView.data?.finalUrl ?? ""
        }
        
        wordView.rx.hidden.asDriver(onErrorJustReturn: false)
            .map{ return !$0 }
            .drive(tabbleView.rx.isHidden)
            .addDisposableTo(disposeBag)
    }
    
    func configureTabbleView(){
        
//        dataSource.titleForHeaderInSection = { dataSource, index in
//            dataSource.sectionModels[index].model
//        }
        
        dataSource.configureCell = { [weak self] dataSource, tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier:
                cellIdentifier, for: indexPath) as! HistoryTableViewCell
            
                cell.configure(with: item)
//            if let strongSelf = self {
//                
//                cell.configure(with: item)
//            }
            return cell
        }

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
        
        view.addSubview(wordView)
        
        wordView.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(0)
            make.top.equalTo(0)
        }
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
        
        view.addSubview(tabbleView)
        tabbleView.snp.makeConstraints { (make) in
            
            make.left.right.top.bottom.equalTo(0)
        }
    }
}
