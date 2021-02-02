//
//  SimpleHeader.swift
//  Compositional layout
//
//  Created by User on 02.02.2021.
//

import UIKit
class SimpleHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SimpleHeaderView"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    private func setupView() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15)
        ])
    }
}

