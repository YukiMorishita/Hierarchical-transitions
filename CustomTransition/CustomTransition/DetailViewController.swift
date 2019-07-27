//
//  DetailViewController.swift
//  CustomTransition
//
//  Created by admin on 2019/07/24.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func contractCardView()
}

class DetailViewController: UIViewController {
    
    weak var delegate: DetailViewControllerDelegate?

    var text: String? {
        didSet {
            textLabel.text = self.text
        }
    }

    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 1
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap)))

        setupViews()
    }

    fileprivate func setupViews() {
        view.addSubview(textLabel)

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    @objc func handleViewTap() {
        self.delegate?.contractCardView()
        dismiss(animated: true, completion: nil)
    }
}
