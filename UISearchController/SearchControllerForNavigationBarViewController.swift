//
//  SearchControllerForNavigationBarViewController.swift
//  UISearchController
//
//  Created by 吕建廷 on 16/7/2.
//  Copyright © 2016年 吕建廷. All rights reserved.
//

import UIKit

class SearchControllerForNavigationBarViewController: UIViewController {
    var tableView: UITableView!
    
    var searchControllerForNavigationBar: UISearchController!
    
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateDataSource()

        buildUserInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Private
extension SearchControllerForNavigationBarViewController {
    private func buildUserInterface() {
        //此示例应用场景类似淘宝首页搜索
        title = "ForNavigationBar"
        
        definesPresentationContext = true
        
        tableView = UITableView(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        buildSearchController(&searchControllerForNavigationBar)
        navigationItem.titleView = searchControllerForNavigationBar.searchBar
    }
    
    private func buildSearchController(inout searchController: UISearchController!){
        let searchResultsVC = SearchResultsController()
        
        searchResultsVC.originalDataSource = dataSource
        
        searchResultsVC.delegate = self
        
        searchController = UISearchController(searchResultsController: searchResultsVC)
        
        searchController.searchBar.frame = CGRectMake(0, 0, view.bounds.width, 44)
        searchController.searchBar.keyboardType = .NumberPad

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        
        searchController.searchResultsUpdater = searchResultsVC
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    private func generateDataSource() {
        for i in 0 ..< 100 {
            let str = String(i)
            dataSource.append(str)
        }
    }
}

//MARK: UITableViewDataSource
extension SearchControllerForNavigationBarViewController: UITableViewDataSource {
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
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        
        return cell!
    }
}

//MARK: UISearchControllerDelegate
extension SearchControllerForNavigationBarViewController: UISearchControllerDelegate {
    func willPresentSearchController(searchController: UISearchController) {
    }
}

//MARK: UISearchBarDelegate
extension SearchControllerForNavigationBarViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //点击键盘上的搜索按钮时执行此代理，可按实际需求进行处理
        print("didClickSearchBuuton")
    }
}

//MARK: SearchResultsControllerDelegate
extension SearchControllerForNavigationBarViewController: SearchResultsControllerDelegate {
    func didClickResult(searchResultsController: SearchResultsController, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchControllerForNavigationBar.active = false
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            let result = searchResultsController.dataSource[indexPath.row]
            
            let resultDetailVC = ResultDetailViewController()
            
            resultDetailVC.result = result
            
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(resultDetailVC, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
}