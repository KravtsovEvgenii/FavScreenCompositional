//
//  ViewersView.swift
//  Compositional layout
//
//  Created by User on 01.02.2021.
//

import UIKit
class ViewersView: UIView {
    //MARK: Properties
    var viewersCountLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .white
        label.text = "1000"
        return label
    }()
    private var viewersImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .white
        return imageView
    }()
    //MARK: init
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Layout
    private func layout() {
        addSubview(viewersImageView)
        addSubview(viewersCountLabel)
        
        viewersImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewersImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewersImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewersImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.4).isActive = true
        viewersImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        viewersCountLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewersCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewersCountLabel.leadingAnchor.constraint(equalTo: viewersImageView.trailingAnchor).isActive = true

    }
    
}
