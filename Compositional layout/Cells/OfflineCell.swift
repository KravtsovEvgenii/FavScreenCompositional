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
    static let reuseId = "OfflineCell"
    //MARK: Configure
    func configure(withData data: Stream) {
        cellContentView.avatarImageView.image = data.streamer.image
        cellContentView.streamTitleLabel.text = data.streamer.name
        if let announce = data.announce {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.green,
            ]
            
            let attributedDate = NSAttributedString(string: announce.stringDate, attributes: attributes)
            cellContentView.streamerComplexString.attributedText = attributedDate
            
        }else {
            cellContentView.streamerComplexString.text = "Недавно"
            cellContentView.streamerComplexString.textColor = .white
        }
    }
    //MARK:  init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layer.cornerRadius = 20
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
    }
    //MARK: Layout
    private func layout() {
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cellContentView)
        cellContentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
