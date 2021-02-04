//
//  OfflineCell.swift
//  Compositional layout
//
//  Created by User on 02.02.2021.
//

import UIKit

class OfflineCell: UICollectionViewCell, ConfigurableCell {
    typealias ContentView = FooterView
    private let cellContentView = ContentView()
    static var reuseId = "OfflineCell"
    //MARK: Configure
    func configure(withData data: Stream) {
        cellContentView.configure(data)
        
    }
    //MARK:  init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layer.cornerRadius = 20
        layer.cornerRadius = 4
        clipsToBounds = true
        
    }
    //MARK: Layout
    private func layout() {
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellContentView)
        cellContentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
