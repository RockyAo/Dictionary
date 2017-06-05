//
//  WordView.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class VocabularyView: UIView {
    
    let disposeBag = DisposeBag()

    fileprivate lazy var centerSeperateView:UIView = {
    
        return UIView.getSeperateView()
    }()
    
    fileprivate lazy var bottomSeperateView:UIView = {
    
        return UIView.getSeperateView()
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        
        let tl = UILabel()
        
        tl.textColor = UIColor.Main.gray.dark
        
        tl.font = UIFont.main.titleFont
        
        tl.sizeToFit()
        
        return tl
    }()
    
    lazy var playButton: UIButton = {
        let pb = UIButton(type: .custom)
        pb.setBackgroundImage(#imageLiteral(resourceName: "home_play_button"), for: .normal)
        
        return pb
    }()
    
    lazy var collectionButton: UIButton = {
        let cb = UIButton(type: .custom)
        cb.setBackgroundImage(#imageLiteral(resourceName: "collect"), for: .normal)
        cb.setBackgroundImage(#imageLiteral(resourceName: "select_collect"), for: .selected)
        return cb
    }()
    
    fileprivate lazy var usPronounceLabel: UILabel = {
        
        let up = UILabel()
        up.textColor = UIColor.Main.gray.weak
        up.font = UIFont.main.desFont
        up.sizeToFit()
        return up
    }()
    
    fileprivate lazy var ukPronounceLabel: UILabel = {
        
        let up = UILabel()
        up.textColor = UIColor.Main.gray.weak
        up.font = UIFont.main.desFont
        up.sizeToFit()
        return up
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.Main.gray.middle
        dl.font = UIFont.main.desFont
        dl.sizeToFit()
        dl.numberOfLines = 0
        return dl
    }()
    
    
    var data:WordModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.top.equalTo(25)
            
        }
        
        addSubview(collectionButton)
        collectionButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(-25)
            make.centerY.equalTo(titleLabel.snp.centerY).offset(0)
            make.height.width.equalTo(18)
        }
        
        addSubview(playButton)
        
        playButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(collectionButton.snp.left).offset(-25)
            make.centerY.equalTo(titleLabel.snp.centerY).offset(1)
            make.width.height.equalTo(18)
        }
        
        addSubview(usPronounceLabel)
        
        usPronounceLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        addSubview(ukPronounceLabel)
        
        ukPronounceLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(usPronounceLabel.snp.bottom).offset(25)
            make.left.equalTo(25)
        }
        
        addSubview(centerSeperateView)
        
        centerSeperateView.snp.makeConstraints { (make) in
            make.top.equalTo(ukPronounceLabel.snp.bottom).offset(25)
            make.left.equalTo(25)
            make.right.equalTo(0)
            make.height.equalTo(0.5)
        }
        
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.top.equalTo(centerSeperateView.snp.bottom).offset(25)
        }
        
        addSubview(bottomSeperateView)
        
        bottomSeperateView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            make.height.equalTo(0.5)
        }
        
        collectionButton.rx.tap
            .asDriver()
            .map{ [unowned self] in
               
               return !self.collectionButton.isSelected
            }
            .drive(collectionButton.rx.isSelected)
            .addDisposableTo(disposeBag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureAction(collectAction:Action<WordModel,WordModel>,playAudioAction:Action<String,Void>) -> Void {
        
        
        collectionButton.rx.bind(to: collectAction){ _ in
            
            self.data?.selected = self.collectionButton.isSelected
            
            return self.data!
        }
        
        playButton.rx.bind(to: playAudioAction){ _ in
            
            return self.data?.finalUrl ?? ""
        }
    }
}

extension Reactive where Base:VocabularyView{

    var configureData:UIBindingObserver<Base,WordModel>{
    
        return UIBindingObserver(UIElement: base, binding: { (wordView, data) in
            
            wordView.data = data
            
            wordView.titleLabel.text = data.query
            
            if let ukString = data.basicTranslation?.ukPhonetic,
                let usString = data.basicTranslation?.usPhonetic{
                
                wordView.ukPronounceLabel.text = "英:\(ukString)"
                wordView.usPronounceLabel.text = "美:\(usString)"
            }else{
                 wordView.usPronounceLabel.text = ""
                wordView.ukPronounceLabel.text = ""
            }
            
            guard let explains = data.basicTranslation?.explains else { return }
            
            var desString:String = ""
            
            for text in explains{
                desString.append(text)
                desString.append("\n")
            }
            
            let attrString = NSMutableAttributedString(string: desString)
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 20
            attrString.addAttributes([NSParagraphStyleAttributeName:style], range: NSRange(location: 0, length: desString.characters.count))
            wordView.descriptionLabel.attributedText = attrString
        })
    }
    
    
}
