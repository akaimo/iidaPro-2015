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
        
        self.setupView()
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
    
    
    private func setupView() {
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self.searchModel
        
        self.view.layer.contents = UIImage(named: "Base")?.CGImage
        self.searchTableView.backgroundColor = UIColor.clearColor()
        self.searchTableView.sectionIndexColor = UIColor.whiteColor()
        self.searchTableView.sectionIndexBackgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        self.searchTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        self.searchTableView.registerNib(nib, forCellReuseIdentifier: "Trash")
    }
    
    private func setSearchBar() {
        let baseFrame = CGRectMake(0, 0, self.view.bounds.width, 66)
        let baseView = UIView(frame: baseFrame)
        baseView.backgroundColor = UIColor.blackColor()
        baseView.tag = 11
        
        let frame = CGRectMake(0, 0, self.view.bounds.width, 66)
        let searchView = UIView(frame: frame)
        searchView.backgroundColor = UIColor(red: 86/255.0, green: 96/255.0, blue: 133/255.0, alpha: 1.0)
        
        let searchFrame = CGRectMake(10, 22, self.view.bounds.width - 10, 44)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = UIColor.whiteColor()
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.blueColor()
        searchBar.becomeFirstResponder()
        
        baseView.addSubview(searchView)
        searchView.addSubview(searchBar)
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.window?.addSubview(baseView)
    }
    
    private func removeSearchBar() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.window?.viewWithTag(11)?.removeFromSuperview()
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.removeSearchBar()
        self.searchModel.result = false
        self.searchTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.searchModel.fetchTrashData(text)
        searchBar.resignFirstResponder()
        self.searchTableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        headerView.backgroundColor = UIColor(red: 41/255.0, green: 52/255.0, blue: 92/255.0, alpha: 0.95)
        
        let label = UILabel(frame: CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height))
        label.text = self.searchModel.sectionList[section]
        label.font = UIFont.boldSystemFontOfSize(16.0)
        label.shadowOffset = CGSizeMake(0, 1)
        label.shadowColor = UIColor.grayColor()
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        
        headerView.addSubview(label)
        tableView.sectionHeaderHeight = headerView.frame.size.height
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.searchModel.result ? 0 : 22.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.searchModel.result != true || self.searchModel.searchResultArray.count != 0 {
            performSegueWithIdentifier("SearchDetail", sender: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "SearchDetail":
            let vc: SearchDetailViewController = segue.destinationViewController as! SearchDetailViewController
            guard let indexPath = sender as? NSIndexPath else { return }
            
            if self.searchModel.result == true && self.searchModel.searchResultArray.count != 0 {
                vc.trashData = self.searchModel.searchResultArray[UInt(indexPath.row)]
            } else {
                vc.trashData = self.searchModel.sectionArray[indexPath.section][UInt(indexPath.row)]
            }
            
        default: break
        }
    }
    
}
