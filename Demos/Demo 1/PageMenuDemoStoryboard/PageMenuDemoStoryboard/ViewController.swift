//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var myData: [(String, Int)] = {
        var data = [(String, Int)]()
        
        data = [("Friends", 0), ("Enemies", 0), ("Schmoes", 0), ("Friends", 0), ("Mood", 1), ("Music", 2), ("Favorites", 3),("Something", 0), ("Wicked", 1), ("This", 2), ("Way", 3)]
        
        return data
    }()
    

    var pageMenu : CAPSPageMenu?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - UI Setup
        
        self.title = "PAGE MENU"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<-", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ViewController.didTapGoToLeft))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "->", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ViewController.didTapGoToRight))
        
        // MARK: - Scroll menu setup

        /*
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        for j in 1...8 {
        
        let controller1 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
        controller1.title = "FRIENDS\(j)"
        controllerArray.append(controller1)
        let controller2 : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
        controller2.title = "MOOD\(j)"
        controllerArray.append(controller2)
        let controller3 : TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
        controller3.title = "MUSIC\(j)"
        controllerArray.append(controller3)
        let controller4 : TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
        controller4.title = "FAVORITES\(j)"
        controllerArray.append(controller4)
        }
        */
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(dataSource: self, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)

		self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
		
		pageMenu!.didMoveToParentViewController(self)
    }
    
    func didTapGoToLeft() {
        let currentIndex = pageMenu!.currentPageIndex
        
        if currentIndex > 0 {
            pageMenu!.moveToPage(currentIndex - 1)
        }
    }
    
    func didTapGoToRight() {
        let currentIndex = pageMenu!.currentPageIndex
        
        if currentIndex < pageMenu!.menuItems.count {
            pageMenu!.moveToPage(currentIndex + 1)
        }
    }
	
	// MARK: - Container View Controller
	override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
		return true
	}
	
	override func shouldAutomaticallyForwardRotationMethods() -> Bool {
		return true
	}
}

extension ViewController: PageMenuDataSource {
    
    func pageTitlesForPageMenu(pageMenu: CAPSPageMenu) -> [String] {
        return myData.map({ return $0.0 })
    }
    
    func pageMenu(pageMenu: CAPSPageMenu, viewControllerForReuseIdentifier reuseIdentifier: String) -> UIViewController {
        switch reuseIdentifier {
        case "FriendsTable":
            let controller: TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
            controller.title = "FRIENDS"
            return controller

        case "MoodTable":
            let controller : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
            controller.title = "MOOD"
            return controller

        case "MusicTable":
            let controller3 : TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
            controller3.title = "MUSIC"
            return controller3

        case "FavoritesTable":
            let controller3 : TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
            controller3.title = "MUSIC"
            return controller3
            
        default:
            let controller: TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
            controller.title = "FRIENDS"
            return controller
        }
    }
    
    func pageMenu(pageMenu: CAPSPageMenu, viewControllerForIndex index: Int) -> UIViewController {
        let data = myData[index]

        let reuseIdentifier: String = {
            switch data.1 {
            case 0: return "FriendsTable"
            case 1: return "MoodTable"
            case 2: return "MusicTable"
            case 3: return "FavoritesTable"
            default: return "FriendsTable"
            }
        }()
        
        
        let vc = pageMenu.viewControllerForReuseIdentifier(reuseIdentifier)
        
        if let controller = vc as? TestViewController {
            controller.text = "Page is at index \(index + 1)"
        } else if let controller = vc as? TestTableViewController {
            controller.randomize()
        }
        
        // Would configure vc here.
        return vc
    }
}

