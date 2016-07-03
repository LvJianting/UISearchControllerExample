//
//  SearchResultsController.swift
//  UISearchController
//
//  Created by 吕建廷 on 16/7/2.
//  Copyright © 2016年 吕建廷. All rights reserved.
//

import UIKit

protocol SearchResultsControllerDelegate: class {
    func didClickResult(searchResultsController: SearchResultsController, didSelectRowAtIndexPath indexPath: NSIndexPath)
}

class SearchResultsController: UIViewController {

    var tableView: UITableView!
    
    var searchController: UISearchController!
    
    var originalDataSource: [String]! {
        didSet {
            dataSource = originalDataSource
        }
    }
    
    var dataSource: [String]!
    
    var fixedTableViewOriginY: CGFloat = 0
    
    weak var delegate: SearchResultsControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildUserInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Private
extension SearchResultsController {
    private func buildUserInterface() {
        tableView = UITableView(frame: CGRectMake(0, fixedTableViewOriginY, view.bounds.width, view.bounds.height), style: .Plain)
        view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor.lightGrayColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    private func searchKeywords(keywords: String) {
        dataSource.removeAll()
        for str in originalDataSource {
            guard let _ = str.rangeOfString(keywords) else {
                continue
            }
            dataSource.append(str)
        }
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource
extension SearchResultsController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.backgroundColor = UIColor.clearColor()
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        
        return cell!
    }
}

extension SearchResultsController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        delegate?.didClickResult(self, didSelectRowAtIndexPath: indexPath)
    }
}

//MARK: UISearchResultsUpdating
extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if self.searchController == nil {
            self.searchController = searchController
        }
        guard searchController.searchBar.text ?? "" != "" else {
            return
        }
        searchKeywords(searchController.searchBar.text!)
    }
}

extension SearchResultsController {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}
