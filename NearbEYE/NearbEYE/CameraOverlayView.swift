//
//  CameraOverlayView.swift
//  NearbEYE
//
//  Created by Ethan Hardy on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView {

    var attractionsList : UITableView!
    
    init(frame: CGRect, vc: CameraViewController) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        configureTableView(vc)
        let swipeRecog = UISwipeGestureRecognizer(target: self, action: "hideOrShowTableView:")
        swipeRecog.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(swipeRecog)
        self.addSubview(UIButton(frame: CGRectMake(30,30,60,60)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureTableView(vc: CameraViewController) {
        attractionsList = UITableView(frame: CGRectMake(20, self.frame.height / 2 - 60, self.frame.width - 40, self.frame.height / 2 + 60), style: UITableViewStyle.Plain)
        attractionsList.delegate = vc
        attractionsList.dataSource = vc
        
        attractionsList.registerNib(UINib(nibName: "TableViewCellArt", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Art.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellParks", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Park.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellPlayground", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Playground.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellPOI", bundle: nil), forCellReuseIdentifier: NSStringFromClass(PointOfInterest.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellRink", bundle: nil), forCellReuseIdentifier: NSStringFromClass(Rink.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellSportField", bundle: nil), forCellReuseIdentifier: NSStringFromClass(SportField.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellUrbanDesign", bundle: nil), forCellReuseIdentifier: NSStringFromClass(UrbanDesignAward.self))
        attractionsList.registerNib(UINib(nibName: "TableViewCellWorship", bundle: nil), forCellReuseIdentifier: NSStringFromClass(PlaceOfWorship.self))

        attractionsList.backgroundColor = UIColor.clearColor()
        attractionsList.userInteractionEnabled = false
        self.addSubview(attractionsList)
    }
    
    func hideOrShowTableView(recog: UISwipeGestureRecognizer) {
        if (recog.direction == UISwipeGestureRecognizerDirection.Up) {
            recog.direction = UISwipeGestureRecognizerDirection.Down
            UIView.animateWithDuration(NSTimeInterval(200.0/1000.0), animations: { () -> Void in
                self.frame.origin.y -= self.frame.height / 2 - 60
            })
            attractionsList.userInteractionEnabled = true
        }
        else {
            recog.direction = UISwipeGestureRecognizerDirection.Up
            UIView.animateWithDuration(NSTimeInterval(200.0/1000.0), animations: { () -> Void in
                self.frame.origin.y += self.frame.height / 2 - 60
            })
            attractionsList.userInteractionEnabled = false
        }
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
