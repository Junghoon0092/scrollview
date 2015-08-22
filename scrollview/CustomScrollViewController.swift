//
//  CustomScrollViewController.swift
//  scrollview
//
//  Created by gainell on 15/8/21.
//  Copyright © 2015年 AppCode. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerSize = CGSize(width: 640, height: 640)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize))
        scrollView.addSubview(containerView)
        
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 80))
        redView.backgroundColor = UIColor.redColor()
        containerView.addSubview(redView)
        
        let blueView = UIView(frame: CGRect(x: 0, y: 560, width: 640, height: 80))
        blueView.backgroundColor = UIColor.blueColor()
        containerView.addSubview(blueView)
        
        let greenView = UIView(frame: CGRect(x: 160, y: 160, width: 320, height: 320))
        greenView.backgroundColor = UIColor.greenColor()
        containerView.addSubview(greenView)
        
        let imageView = UIImageView(image: UIImage(named: "slow.png"))
        imageView.center = CGPoint(x: 320, y: 320)
        containerView.addSubview(imageView)
        
        scrollView.contentSize = containerSize
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
}
