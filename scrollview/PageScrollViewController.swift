//
//  PageScrollViewController.swift
//  scrollview
//
//  Created by gainell on 15/8/22.
//  Copyright © 2015年 AppCode. All rights reserved.
//

import UIKit

class PageScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageImages = [UIImage]()
    var pageViews = [UIImageView?]() // 设置为可选数组, 因为可能会有懒加载
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count + 1), height: pagesScrollViewSize.height)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadVisiblePages()
    }
    
    func purgePage(page: Int) {
        // 判断越界
        if page < 0 || page >= pageImages.count {
            return
        }
        
        // pageViews是可选数组,所以用let pageView解包
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            return
        }
        
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
            pageView.contentMode = .ScaleAspectFit
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }

    func loadVisiblePages() {
        let pageWidth = scrollView.frame.size.width
        // floor()方法返回不大于x的最大整数(向下取整)。
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
//        if firstPage > 0 {
//            for index in 0..<firstPage {
//                purgePage(index)
//                print("for-in:\(index)")
//            }
//        }
        
//        for index in firstPage...lastPage {
//            loadPage(index)
//        }
        
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
    }
}

extension PageScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
}
