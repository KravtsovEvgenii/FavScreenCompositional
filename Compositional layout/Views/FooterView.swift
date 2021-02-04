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
    var streamerComplexLabel: UILabel =  {
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
        self.addSubview(streamerComplexLabel)
        avatarImageView.layer.cornerRadius = self.frame.width / 2
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        
        streamTitleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        streamTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 16).isActive = true
        streamTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        streamerComplexLabel.topAnchor.constraint(equalTo: streamTitleLabel.bottomAnchor, constant: 8).isActive = true
        streamerComplexLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 16).isActive = true
        streamerComplexLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    //MARK: Configure cell
    func configure(_ stream: Stream) {
        self.avatarImageView.image = stream.streamer.image
        var complexText = ""
        var textColor: UIColor = .white
        switch stream.state {
        case .online:
            complexText = stream.streamer.name + " | " + stream.game
            streamTitleLabel.text = stream.title
        case .offline:
            complexText = "Недавно"
            streamTitleLabel.text = stream.streamer.name
        case .announce:
            textColor = .green
            complexText = stream.announce?.stringDate ?? ""
            streamTitleLabel.text = stream.streamer.name
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
        ]
        
        let attributedComplexText = NSAttributedString(string: complexText, attributes: attributes)
        streamerComplexLabel.attributedText = attributedComplexText
        
    }
}
