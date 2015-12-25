//
//  SearchViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/23/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchModel: SearchModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchModel = SearchModel()
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self.searchModel
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Utilities().setNavigation(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.removeSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tapSearch(sender: AnyObject) {
        self.setSearchBar()
    }
    
    private func setSearchBar() {
        let baseFrame = CGRectMake(0, -22, self.view.bounds.width, 66)
        let baseView = UIView(frame: baseFrame)
        baseView.backgroundColor = UIColor.blackColor()
        baseView.tag = 11
        
        let frame = CGRectMake(0, 0, self.view.bounds.width, 66)
        let searchView = UIView(frame: frame)
        searchView.backgroundColor = UIColor(red: 86/255.0, green: 96/255.0, blue: 133/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
        let searchFrame = CGRectMake(10, 22, self.view.bounds.width - 10, 44)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        searchBar.backgroundImage = UIImage()
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.blueColor()
        searchBar.becomeFirstResponder()
        
        baseView.addSubview(searchView)
        searchView.addSubview(searchBar)
        self.navigationController?.navigationBar.addSubview(baseView)
    }
    
    private func removeSearchBar() {
        let view = self.navigationController?.navigationBar.viewWithTag(11)
        view?.removeFromSuperview()
        self.navigationController?.navigationBar.backIndicatorImage = nil
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = nil
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.removeSearchBar()
    }
}
