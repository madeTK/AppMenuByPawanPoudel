//
//  MenuViewController.swift
//  AppMenu
//
//  Created by Pawan Poudel on 8/25/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: MenuTableDataSource?
    var tapHandlerBuilder: MenuItemTapHandlerBuilder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "App Menu"
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didSelectMenuItemNotification:",
            name: MenuTableDataSourceDidSelectItemNotification,
            object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: MenuTableDataSourceDidSelectItemNotification,
            object: nil)
    }
    
    // MARK: - Notification handling
    
    func didSelectMenuItemNotification(notification: NSNotification?) {
        println(notification!.object as? MenuItem)
        var menuItem: MenuItem? = notification!.object as? MenuItem

        if let tapHandler = tapHandlerBuilder?.tapHandlerForMenuItem(menuItem) {

            println("currentTopVC: \(navigationController?.topViewController)")
            navigationController?.pushViewController(tapHandler, animated: false)
            println("VC after Pushing: \(navigationController?.topViewController)")
            println("No of VC: \(navigationController?.viewControllers.count)")
        }
    }
}
