//
//  StreamListView.swift
//  Compositional layout
//
//  Created by User on 04.02.2021.
//

import UIKit

class FavoriteStreamsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView  = {
        return UICollectionView(frame: frame, collectionViewLayout: creatingCompositionalLayout())
    }()
}

extension FavoriteStreamsView {
    private func layout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func creatingCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {[weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {return nil}
            
            switch section {
            
            case .online:
                return self?.onlineStreamLayout()
            case .offline:
                return self?.offlineStreamLayout()
            case .announce:
                return self?.offlineStreamLayout()
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
    
    //MARK: Sections
    private func onlineStreamLayout() -> NSCollectionLayoutSection{
        let itemHeight: NSCollectionLayoutDimension = .fractionalWidth(0.75)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
        let group: NSCollectionLayoutGroup = .vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8)
        section.interGroupSpacing = 8
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    
    private func offlineStreamLayout() -> NSCollectionLayoutSection{
        let itemHeight: NSCollectionLayoutDimension = .fractionalWidth(0.25)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
        let group: NSCollectionLayoutGroup = .vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 36, leading: 8, bottom: 0, trailing: 8)
        section.interGroupSpacing = 8
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension:  .fractionalWidth(1),
                                                       heightDimension: .estimated(1))
    
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}
