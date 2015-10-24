//
//  CameraOverlayView.swift
//  NearbEYE
//
//  Created by Ethan Hardy on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView, UITableViewDelegate, UITableViewDataSource {

    var attractionsList : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        configureTableView()
        let swipeRecog = UISwipeGestureRecognizer(target: self, action: "hideOrShowTableView:")
        swipeRecog.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(swipeRecog)
        self.addSubview(UIButton(frame: CGRectMake(30,30,60,60)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func hideOrShowTableView(recog: UISwipeGestureRecognizer) {
        if (recog.direction == UISwipeGestureRecognizerDirection.Up) {
            recog.direction = UISwipeGestureRecognizerDirection.Down
            UIView.animateWithDuration(NSTimeInterval(200.0/1000.0), animations: { () -> Void in
                self.frame.origin.y -= self.frame.height / 2 - 60
            })
        }
        else {
            recog.direction = UISwipeGestureRecognizerDirection.Up
            UIView.animateWithDuration(NSTimeInterval(200.0/1000.0), animations: { () -> Void in
                self.frame.origin.y += self.frame.height / 2 - 60
            })
        }
    }
    
    func configureTableView() {
        attractionsList = UITableView(frame: CGRectMake(20, self.frame.height / 2 - 60, self.frame.width - 40, self.frame.height / 2 + 60), style: UITableViewStyle.Plain)
        attractionsList.delegate = self
        attractionsList.dataSource = self
        attractionsList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "attraction")
        attractionsList.backgroundColor = UIColor.clearColor()
        self.addSubview(attractionsList)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //TODO implement stephen's methods
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO implement stephen's methods
        if let cell = attractionsList.dequeueReusableCellWithIdentifier("attraction") {
            cell.textLabel?.text = "Generic Attraction"
            cell.detailTextLabel?.text = "Prototype Content"
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "attraction")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        //TODO implement stephen's methods
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
