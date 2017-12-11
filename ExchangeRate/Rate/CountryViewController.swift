//
//  CountryViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 11/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    class func showInController(controller: UIViewController) -> UIViewController?{
        
//        guard let controller = controller else{
//            return nil
//        }
        
        let fromVC = controller
        let vc = CountryViewController()
        fromVC.showChildViewController(childController: vc)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: CurrencyCollectionViewLongCell.nameOfClass, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CurrencyCollectionViewLongCell.nameOfClass)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.alpha = 0
        self.containerView.layer.cornerRadius = 10
        self.containerView.alpha = 0
        self.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.3, delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.3,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: {
                        self.containerView.alpha = 1
                        self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.view.alpha = 1
        }, completion: nil)
    }
    
    
    @IBAction func backButtonClick() {
        
        UIView.animate(withDuration: 0.3, delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.3,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: {
                        self.containerView.alpha = 0
                        self.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        self.view.alpha = 0
        }, completion: { (true) in
            if self.presentingViewController == nil {
                self.removeFromParentViewController()
            } else {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.supportCurrency
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewLongCell.nameOfClass, for: indexPath) as! CurrencyCollectionViewLongCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = 60 as CGFloat
        return CGSize(width: width, height: height)
    }
}
