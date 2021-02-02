//
//  FooterView.swift
//  Compositional layout
//
//  Created by User on 01.02.2021.
//

import UIKit
class FooterView: UIView {
    //MARK: Properties
    var avatarImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 84, height: 84)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    var streamerComplexString: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    var streamTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .white
    
        return label
    }()
   //MARK: init
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    //MARK: Layout
    private func layout() {
        self.addSubview(avatarImageView)
        self.addSubview(streamTitleLabel)
        self.addSubview(streamerComplexString)
        avatarImageView.layer.cornerRadius = self.frame.width / 2
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        
        streamTitleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        streamTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 16).isActive = true
        streamTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        streamerComplexString.topAnchor.constraint(equalTo: streamTitleLabel.bottomAnchor, constant: 8).isActive = true
        streamerComplexString.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 16).isActive = true
        streamerComplexString.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    //MARK: Configure cell
    func configure(_ stream: Stream) {
        self.avatarImageView.image = stream.streamer.image
        self.streamerComplexString.text = stream.streamer.name + " | " + stream.game
        self.streamTitleLabel.text = stream.title
    }
    
    
}
