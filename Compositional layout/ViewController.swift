//
//  ViewController.swift
//  Compositional layout
//
//  Created by User on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Stream>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section,Stream>
    var collectionView: UICollectionView!
    var dataSource: DataSource?
    var streams: AllStreams!
    var refresh = UIRefreshControl()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streams = makeStreams(count: 10)
        
        setupCollectionView()
        setupDataSource()
        reloadData()
    }
}
//MARK: Compositional Layout
extension ViewController {
    private func creatingCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {return nil}
            
            switch section {
            
            case .online:
                return self.onlineStreamLayout()
            case .offline:
                return self.offlineStreamLayout()
            case .announce:
                return self.offlineStreamLayout()
            }
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        layout.configuration = configuration
        return layout
    }
    
    //Reload data
    private func reloadData() {
        var snapshot = Snapshot()
        snapshot.deleteAllItems()
        if snapshot.numberOfSections == 0 {
            snapshot.appendSections([.online,.offline,.announce])
        }
        snapshot.appendItems(streams.onlineStreams, toSection: .online)
        snapshot.appendItems(streams.offlineStreams, toSection: .offline)
        snapshot.appendItems(streams.announceStreams, toSection: .announce)
        dataSource?.apply(snapshot)
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
    //MARK: Data Source
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Stream>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, stream) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {return nil}
            switch section {
            
            case .online:
                
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: OnlineCell.reuseId, for: indexPath) as! OnlineCell
                let stream = self.streams.onlineStreams[indexPath.row]
                
                cell.configure(withData: stream )
                
                return cell
            case .offline:
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: OfflineCell.reuseId, for: indexPath) as! OfflineCell
                let stream = self.streams.offlineStreams[indexPath.row]
                
                cell.configure(withData: stream )
                
                return cell
            case .announce:
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: OfflineCell.reuseId, for: indexPath) as! OfflineCell
                
                let stream = self.streams.announceStreams[indexPath.row]
                
                cell.configure(withData: stream )
                
                return cell
            }
        })
        dataSource?.supplementaryViewProvider = {
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
    }
}

//MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate{
    
    
    
}
//MARK: Setup Collection View
extension ViewController {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: creatingCompositionalLayout())
        
        collectionView.register(OnlineCell.self, forCellWithReuseIdentifier: OnlineCell.reuseId)
        collectionView.register(OfflineCell.self, forCellWithReuseIdentifier: OfflineCell.reuseId)
        collectionView.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)
        
        collectionView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        
        layoutCollectionview()
    }
    
    private func layoutCollectionview() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc
    private func refreshAction() {
        streams = makeStreams(count: 10)
        reloadData()
        refresh.endRefreshing()
    }
}
