//
//  ViewController.swift
//  TableViewDiffableDataSource
//
//  Created by Bitmorpher 4 on 1/4/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int>
    
    let reuseId = "reuse-id"
    
    private lazy var dataSource = makeDataSource()
    var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: reuseId)
        
        applySnapshot()
    }
    
    // 1
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource { // reusing typealias
        // 1
        let dataSource = DataSource(
            tableView: tableView,
            
            // 2 cell provider Configuration
            cellProvider: { (tableView, indexPath, title) ->
                UITableViewCell? in
                
                // 4 display the date in the UI
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: self.reuseId,
                    for: indexPath) as? TableViewCell
                cell?.titleLabel.text = "\(title)" // from items
                return cell
            })
    
        return dataSource
    }

}

