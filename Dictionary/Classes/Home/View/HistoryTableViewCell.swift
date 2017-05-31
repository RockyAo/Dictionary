//
//  HistoryTableViewCell.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift

class HistoryTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var collectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: WordModel) {
        
        wordLabel.text = item.query
        
        var transString = ""
        
        for item in item.basicTranslation?.explains ?? []{
            
            transString.append(item)
            transString.append("  ")
            
        
        }
        
        translationLabel.text = transString
    }

}
