//
//  CardViewCell.swift
//  CustomTransition
//
//  Created by admin on 2019/07/27.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(cardView)
        
        cardView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 16),
            textLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16),
            textLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
}
