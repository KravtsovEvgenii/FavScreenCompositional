//

import UIKit
//MARK: ConfigurableCell
protocol ConfigurableCell{
    associatedtype CellData: Equatable
    func configure(withData data: CellData)
    static var reuseId: String {get set}
}

class OnlineCell: UICollectionViewCell,ConfigurableCell {
    //MARK: Properties
    private let streamPreview = UIImageView()
    private let footerView = FooterView()
    private let viewersView = ViewersView()
    
    
    static var reuseId = "OnlineCell"
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layer.cornerRadius = 20
        layer.cornerRadius = 4
        clipsToBounds = true
        
    }
    //MARK: Layout
    private func layout() {
        addSubview(streamPreview)
        addSubview(footerView)
        addSubview(viewersView)
        streamPreview.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        viewersView.translatesAutoresizingMaskIntoConstraints = false
        
        streamPreview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        streamPreview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        streamPreview.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        streamPreview.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        
        viewersView.topAnchor.constraint(equalTo: self.topAnchor,constant: 16).isActive = true
        viewersView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        viewersView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewersView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        footerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        footerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Configure
    func configure(withData data: Stream) {
        footerView.configure(data)
        streamPreview.image = data.image
    }
}


