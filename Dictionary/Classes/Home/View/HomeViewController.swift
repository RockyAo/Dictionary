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
        
        searchBar.rx.text.orEmpty.asDriver()
            .map {
                return $0.characters.count <= 0
            }
            .drive(wordView.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        viewModel.translateData
            .drive(wordView.rx.configureData)
            .addDisposableTo(disposeBag)
        

        
        wordView.playButton.rx.bind(to: viewModel.playAudioAction) { _  in
            
            return self.wordView.data?.finalUrl ?? ""
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
    }
}
