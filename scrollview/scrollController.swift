//
//  scrollController.swift
//  scrollview
//
//  Created by gainell on 15/8/21.
//  Copyright © 2015年 AppCode. All rights reserved.
//

import UIKit

class scrollController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let image = UIImage(named: "photo1.png")! // 一定有值
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        scrollView.contentSize = image.size
        scrollView.addSubview(imageView)
        
        // 2
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // 3
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = minScale
        
        // 4
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale
        
        // 5
        centerScrollViewContents()
    }
    
    func centerScrollViewContents(){
        
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        // 下面这两个if条件用来设置image在scrollView中的显示位置
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
        
        imageView.frame = contentsFrame
    }
    
    // 双击
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 获取鼠标点击位置的坐标
        let pointInView = recognizer.locationInView(imageView)
        
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        let rectToZoomTo = CGRectMake(x, y, w, h)
        
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    // MARK: - UIScrollViewDelegate
    // 此方法返回被缩放的对象
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // 只要缩放比例改变, 此方法就会被调用
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
}
