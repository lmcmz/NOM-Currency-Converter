//
//  CountryViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 11/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let changeCurrencyNotification = "changeCurrencyNotification"
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
    
    class func showInWindow(controller: UIViewController) {
        
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        let vc = CountryViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: CurrencyCollectionViewCell.nameOfClass, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CurrencyCollectionViewCell.nameOfClass)
        
        let layer  = CAGradientLayer()
        
        let width = Constants.SCREEN_WIDTH - 4 * Constants.padding
        let height = width * (2.0 / 1.3)
        
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let color1 = UIColor(white: 0, alpha: 0.9)
        let color2 = UIColor(white: 0, alpha: 0.7)
        let color3 = UIColor.clear
        
        layer.colors = [color3.cgColor, color2.cgColor, color1.cgColor,
                        color1.cgColor, color2.cgColor, color3.cgColor]
        
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.locations = [0.0, 0.2, 0.5, 0.5, 0.8, 1.0]
        self.containerView.layer.mask = layer
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.nameOfClass, for: indexPath) as! CurrencyCollectionViewCell
        let index = indexPath.item
        cell.configure(currency: Currency.supportCurrency[index])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Constants.SCREEN_WIDTH - 4*Constants.padding) / 2 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let currency = Currency.supportCurrency[index]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CountryViewController.changeCurrencyNotification), object: currency)
        self.backButtonClick()
    }
    
}
