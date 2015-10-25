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
    
    init(frame: CGRect, vc: CameraViewController) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        configureTableView(vc)
        swipeRecog = UISwipeGestureRecognizer(target: self, action: "hideOrShowTableViewFromSwipe:")
        swipeRecog.direction = UISwipeGestureRecognizerDirection.Up
        swipeRecog.delegate = self
        let tapRecog = UITapGestureRecognizer(target: self, action: "hideOrShowTableViewFromTap:")
        tapRecog.delegate = self
        self.addGestureRecognizer(tapRecog)
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

        attractionsList.scrollEnabled = true
        attractionsList.backgroundColor = UIColor.clearColor()
        attractionsList.userInteractionEnabled = false
        self.addSubview(attractionsList)
    }
    
    func hideOrShowTableViewFromSwipe(recog: UISwipeGestureRecognizer) {
        if (recog.direction == UISwipeGestureRecognizerDirection.Up) {
            hideOrShowTableView(true)
        }
        else {
            hideOrShowTableView(false)
        }
    }
    
    func hideOrShowTableViewFromTap(recog: UITapGestureRecognizer) {
        if (attractionsList.userInteractionEnabled == true) {
            hideOrShowTableView(false)
        }
        else {
            hideOrShowTableView(true)
        }
    }

    func hideOrShowTableView(show: Bool) {
        if (show) {
            UIView.animateWithDuration(NSTimeInterval(200.0/1000.0), animations: { () -> Void in
                self.frame.origin.y -= self.frame.height / 2 - 60
            })
            attractionsList.userInteractionEnabled = true
            swipeRecog.direction = UISwipeGestureRecognizerDirection.Down
        }
        else {
            UIView.animateWithDuration(NSTimeInterval(200.0/1000.0), animations: { () -> Void in
                self.frame.origin.y += self.frame.height / 2 - 60
            })
            attractionsList.userInteractionEnabled = false
            swipeRecog.direction = UISwipeGestureRecognizerDirection.Up
        }

    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if (attractionsList.frame.contains(touch.locationInView(self))) {
            return false
        }
        else {
            return true
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
