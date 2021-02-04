//
//  CollectionManager.swift
//  Compositional layout
//
//  Created by User on 04.02.2021.
//

import UIKit

class CollectionManager:
    UICollectionViewDiffableDataSource<Section, Stream> {
    
    init(collectionView: UICollectionView) {
        
        super.init(collectionView: collectionView) { collection, indexPath, stream -> UICollectionViewCell? in
            collection.register(OnlineCell.self, forCellWithReuseIdentifier: OnlineCell.reuseId)
            collection.register(OfflineCell.self, forCellWithReuseIdentifier: OfflineCell.reuseId)
            collection.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)
            
            guard let section = Section(rawValue: indexPath.section) else {return nil}
            switch section {
            
            case .online:
                return CollectionManager.makeCell(withCollectionView: collection, cellType: OnlineCell.self, stream: stream, forIndexPath: indexPath)
            case .offline,.announce:
                return CollectionManager.makeCell(withCollectionView: collection, cellType: OfflineCell.self, stream: stream, forIndexPath: indexPath)
            }
        }
        supplementaryViewProvider = {
            collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier, for: indexPath) as! SimpleHeaderView
            
            switch Section(rawValue: indexPath.section) {
            
            case .online:
                header.configure(with: "Online")
            case .offline:
                header.configure(with: "Offline")
            case .announce:
                header.configure(with: "Announce")
            case .none:
                header.configure(with: "Error")
            }
            
            return header
            
        }
        collectionView.delegate = self
    }
    
}

//MARK: UICollectionViewDelegate
extension CollectionManager: UICollectionViewDelegate{
    
    
    
}
extension CollectionManager {
    static func makeCell<T: ConfigurableCell>(withCollectionView collection: UICollectionView,
                                              cellType: T.Type,
                                              stream: Stream,
                                              forIndexPath indexPath: IndexPath)-> T {
        
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
        cell.configure(withData: stream as! T.CellData)
        return cell
    }
}

