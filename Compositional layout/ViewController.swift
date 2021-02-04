//
//  ViewController.swift
//  Compositional layout
//
//  Created by User on 31.01.2021.
//

import UIKit
 
class ViewController: UIViewController,ViewHolder {
    typealias RootViewType = FavoriteStreamsView
    
    
    //MARK: Properties

    var streams: AllStreams!
    var refresh = UIRefreshControl()
    var collectionManager: CollectionManager!
    
    //MARK: Lifecycle
    override func loadView() {
        view = FavoriteStreamsView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        streams = makeStreams(count: 10)
        
        collectionManager = CollectionManager(collectionView: rootView.collectionView)

        setupRefreshControl()
       
        reloadData()
    }
    //Reload data
    private func reloadData() {
        var snapshot = collectionManager.snapshot()
        snapshot.deleteAllItems()
        if snapshot.numberOfSections == 0 {
            snapshot.appendSections([.online,.offline,.announce])
        }
        snapshot.appendItems(streams.onlineStreams, toSection: .online)
        snapshot.appendItems(streams.offlineStreams, toSection: .offline)
        snapshot.appendItems(streams.announceStreams, toSection: .announce)
        collectionManager?.apply(snapshot)
    }
}

//MARK: Setup Refresh Control
extension ViewController {
    private func setupRefreshControl() {
        rootView.collectionView.refreshControl = refresh
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    @objc
    private func refreshAction() {
        streams = makeStreams(count: 10)
        reloadData()
        refresh.endRefreshing()
    }
   
}
