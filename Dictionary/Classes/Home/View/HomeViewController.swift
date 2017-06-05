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
    
    lazy var wordView: VocabularyView = {
        let wv = VocabularyView()
        wv.sizeToFit()
        wv.isHidden = true
        return wv
    }()
    
    lazy var tabbleView: UITableView = {
        
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.register(UINib.init(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tb.hideBottomLine()
        tb.sectionHeaderHeight = 35
        tb.delegate = self
        return tb
    }()
    
    lazy var deleteButton: UIButton = {
        
        let db = UIButton(type: .custom)
        db.setBackgroundImage(#imageLiteral(resourceName: "delete"), for: .normal)
        db.setBackgroundImage(#imageLiteral(resourceName: "delete"), for: .highlighted)
        return db
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
        
        wordView.configureAction(collectAction: viewModel.collectAction, playAudioAction:viewModel.playAudioAction)
        
        wordView.rx.hidden.asDriver(onErrorJustReturn: false)
            .map{ return !$0 }
            .drive(tabbleView.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        deleteButton.rx.action = viewModel.deleteAction
        
    }
    
    func configureTabbleView(){
    
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].model
        }
        
        dataSource.configureCell = { [weak self] dataSource, tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier:
                cellIdentifier, for: indexPath) as! HistoryTableViewCell
            
//                cell.configure(with: item)
            if let strongSelf = self {
                
                cell.configure(with: item,action: strongSelf.viewModel.collectAction)
            }
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

extension HomeViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? UITableViewHeaderFooterView else { return  }
        
        headerView.textLabel?.font = UIFont.main.desFont
        headerView.textLabel?.textColor = UIColor.Main.gray.weak
        
        headerView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(9)
            make.right.equalTo(-12)
            make.width.height.equalTo(18)
        }
    }
}
