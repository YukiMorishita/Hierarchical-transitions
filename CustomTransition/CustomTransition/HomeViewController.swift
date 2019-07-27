//
//  ViewController.swift
//  CustomTransition
//
//  Created by admin on 2019/07/23.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let padding: CGFloat = 4
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            layout.minimumLineSpacing = padding
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 230/255)
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        
        cell.textLabel.text = "Cell \(indexPath.item)"
        
        return cell
    }
    
    var cardView: UIView?
    var startingCardViewFrame: CGRect?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCell else {
            return
        }
        
        if let cardViewFrame = cell.cardView.superview?.convert(cell.cardView.frame, to: nil) {
            startingCardViewFrame = cardViewFrame
            
            cardView = UIView(frame: startingCardViewFrame!)
            cardView?.backgroundColor = UIColor.white
            view.addSubview(cardView!)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                
                self.cardView?.frame = CGRect(x: self.startingCardViewFrame!.origin.x, y: self.view.frame.origin.y, width: self.startingCardViewFrame!.width, height: self.view.frame.height)
                
            }, completion: { completed in
                
                let detailVc = DetailViewController()
                detailVc.delegate = self
                detailVc.text = cell.textLabel.text
                detailVc.modalTransitionStyle = .crossDissolve
                detailVc.modalPresentationStyle = .overCurrentContext
                
                self.present(detailVc, animated: true, completion: nil)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 2 * padding, height: 72)
    }
}

extension HomeViewController: DetailViewControllerDelegate {
    
    func contractCardView() {
        UIView.animate(withDuration: 0.3, animations: {

            self.cardView?.frame = self.startingCardViewFrame!

        }, completion: { completed in

            self.cardView?.removeFromSuperview()
        })
    }
}

class CustomCell: UICollectionViewCell {
    
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

//class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DetailViewControllerDelegate {
//
//    fileprivate let padding: CGFloat = 16
//
//    fileprivate let cellId = "cellId"
//
//    fileprivate let texts: [String] = ["Swift", "C++", "Java", "JavaScript", "Python"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupCollectionViewLayout()
//        setupCollectionview()
//    }
//
//    fileprivate func setupCollectionViewLayout() {
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
//            layout.minimumLineSpacing = 4
//        }
//    }
//
//    fileprivate func setupCollectionview() {
//        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9529411765, blue: 0.9607843137, alpha: 1)
//        collectionView.alwaysBounceVertical = true
//
//        collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: cellId)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardViewCell
//
//        cell.textLabel.text = texts[indexPath.item]
//
//        return cell
//    }
//
//    var copyCardView: UIView?
//    var startingCardViewFrame: CGRect?
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? CardViewCell else {
//            return
//        }
//
//        if let cardViewFrame = cell.cardView.superview?.convert(cell.cardView.frame, to: nil) {
//            self.startingCardViewFrame = CGRect(x: 0, y: cardViewFrame.origin.y, width: view.frame.width, height: cardViewFrame.height)
//
//            self.presentViewController(indexPath)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width - 2 * 4, height: 72)
//    }
//
//    fileprivate func presentViewController(_ indexPath: IndexPath) {
//        copyCardView = UIView(frame: startingCardViewFrame!)
//        copyCardView?.backgroundColor = .white
//        view.addSubview(copyCardView!)
//
//        UIView.animate(withDuration: 0.3 , animations: {
//
//            self.copyCardView?.frame = self.view.frame
//
//        }, completion: { completed in
//
//            let detailVc = DetailViewController()
//            detailVc.delegate = self
//            detailVc.text = texts[indexPath.item]
//            detailVc.modalTransitionStyle = .crossDissolve
//            detailVc.modalPresentationStyle = .overCurrentContext
//            detailVc.modalPresentationCapturesStatusBarAppearance = true
//
//            self.present(detailVc, animated: true, completion: nil)
//        })
//    }
//
//    func contractCardView() {
//        UIView.animate(withDuration: 0.3, animations: {
//
//            self.copyCardView?.frame = self.startingCardViewFrame!
//
//        }, completion: { completed in
//
//            self.copyCardView?.removeFromSuperview()
//        })
//    }
//}
