//
//  ViewController.swift
//  CollectionViewDiffableDataSource
//
//  Created by Bitmorpher 4 on 12/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int>

    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseId = "reuse-id"
    
    private lazy var dataSource = makeDataSource()
    var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: reuseId)
        
        applySnapshot()
    }

    
    // 1
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    
    func makeDataSource() -> DataSource {
        // 1
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, title) ->
                UICollectionViewCell? in
                // 2
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: self.reuseId,
                    for: indexPath) as? CollectionViewCell
                cell?.titleLabel.text = "\(title)"
                return cell
            })
    
        return dataSource
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}

