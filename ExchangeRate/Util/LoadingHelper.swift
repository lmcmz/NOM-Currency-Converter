//
//  LoadingHelper.swift
//  ExchangeRate
//
//  Created by lmcmz on 19/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class LodingHelper: NSObject, NVActivityIndicatorViewable {
    static let sharedHelper = LodingHelper()
    
    func show() {
        let size = CGSize(width: 40, height: 40)
        
//        startAnimating(size, message: "", type: NVActivityIndicatorType(rawValue: sender.tag)!)
        
        let data = ActivityData(size: size, message: "Updating", messageFont: nil, messageSpacing: nil, type: .ballScaleRippleMultiple, color: nil, padding: nil, displayTimeThreshold: 2, minimumDisplayTime: 2, backgroundColor: nil, textColor: nil)
        
         NVActivityIndicatorPresenter.sharedInstance.startAnimating(data)
    }
    
    func remove()  {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
