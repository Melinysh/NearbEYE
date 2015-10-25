//
//  CameraOverlayView.swift
//  NearbEYE
//
//  Created by Ethan Hardy on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView, UIGestureRecognizerDelegate {

    var attractionsList : UITableView!
    var swipeRecog : UISwipeGestureRecognizer!
    var cameraVC : CameraViewController!
    var nothingNearbEYELabel : UILabel!

    
    init(frame: CGRect, vc: CameraViewController) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        cameraVC = vc
        configureTableView()
        swipeRecog = UISwipeGestureRecognizer(target: self, action: "moveToDetailVC")
        swipeRecog.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(swipeRecog)
        
        nothingNearbEYELabel = UILabel()
        nothingNearbEYELabel.text = "Nothing NearbEYE"
        nothingNearbEYELabel.font = UIFont(name: "System-Light", size: 18)
        nothingNearbEYELabel.textColor = UIColor(red: 170.0/255.0, green: 222.0/255.0, blue: 255.0/255.0, alpha: 0.6)
        nothingNearbEYELabel.sizeToFit()
        nothingNearbEYELabel.center = CGPoint(x: self.center.x, y: nothingNearbEYELabel.frame.size.height / 2 + 20)
        nothingNearbEYELabel.hidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func moveToDetailVC() {
        if let path = attractionsList.indexPathsForVisibleRows?.first {
				cameraVC.presentDetailViewControllerForAttractionNumber(path.row)
		}
    }
    
    func configureTableView() {
        attractionsList = UITableView(frame: self.bounds, style: UITableViewStyle.Plain)
        attractionsList.delegate = cameraVC
        attractionsList.dataSource = cameraVC
        
        attractionsList.registerNib(UINib(nibName: "TableViewCellArt", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Art.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellParks", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Park.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellPlayground", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Playground.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellPOI", bundle: nil), forCellReuseIdentifier: NSStringFromClass(PointOfInterest.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellRink", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Rink.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellSportField", bundle: nil), forCellReuseIdentifier: NSStringFromClass(SportField.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellUrbanDesign", bundle: nil), forCellReuseIdentifier: NSStringFromClass(UrbanDesignAward.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellWorship", bundle: nil), forCellReuseIdentifier: NSStringFromClass(PlaceOfWorship.self))

        attractionsList.separatorStyle = UITableViewCellSeparatorStyle.None
        attractionsList.allowsSelection = false
        attractionsList.showsVerticalScrollIndicator = false
        attractionsList.pagingEnabled = true
        attractionsList.backgroundColor = UIColor.clearColor()
        self.addSubview(attractionsList)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
