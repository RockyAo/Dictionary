//
//  HistoryTableViewCell.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift
import Action

class HistoryTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var collectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionButton.rx.tap.asDriver()
            .map{ [unowned self] in
                
                return !self.collectionButton.isSelected
            }
            .drive(collectionButton.rx.isSelected)
            .addDisposableTo(disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: WordModel,action:Action<WordModel,WordModel>) {
        
        wordLabel.text = item.query
        
        var transString = ""
        
        for item in item.basicTranslation?.explains ?? []{
            
            transString.append(item)
            transString.append("  ")
            
        }
        
        translationLabel.text = transString
        
        collectionButton.isSelected = item.selected
        
        var returnData = item
        
        
        collectionButton.rx.bind(to: action) { [weak self] _ in
            
            returnData.selected = (self?.collectionButton.isSelected)!
            
            return returnData
        }
    }

}
