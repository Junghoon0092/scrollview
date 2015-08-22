//
//  ScrollViewContainer.swift
//  scrollview
//
//  Created by gainell on 15/8/22.
//  Copyright © 2015年 AppCode. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {
    @IBOutlet var scrollView: UIScrollView!
    
/**
    hitTest的作用:当在一个view上添加一个屏蔽罩，但又不影响对下面view的操作，也就是可以透过屏蔽罩对下面的view进行操作，这个函数就很好用了。
    hitTest的用法：将下面的函数添加到UIView的子类中，也就是屏蔽罩类中即可。
    -(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
    {
        UIView *hitView = [super hitTest:point withEvent:event];
        if (hitView == self) {
            return nil;
        } else {
        return hitView;
        }
    }
*/
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        return view
    }
}
