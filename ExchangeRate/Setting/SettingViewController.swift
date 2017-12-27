//
//  SettingViewController.swift
//  ExchangeRate
//
//  Created by lmcmz on 22/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit
import FoldingCell
import MessageUI

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {

    let kCloseCellHeight: CGFloat = 85
    let kOpenCellHeight: CGFloat = 230
    let kLanguageCellHeight: CGFloat = 210
    let kAppsCellHeighet: CGFloat = 280
    let kVersionCellHeight: CGFloat = 440
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    var isSleeping: Bool = true
    var language: Language = Language.English
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLanguage(notification:)), name: NSNotification.Name(rawValue: SettingLanguageTableViewCell.languageNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(nibName: SettingChartTableViewCell.nameOfClass)
        tableView.registerCell(nibName: SettingNotificationTableViewCell.nameOfClass)
        tableView.registerCell(nibName: SettingRateTableViewCell.nameOfClass)
        tableView.registerCell(nibName: SettingFeedbackTableViewCell.nameOfClass)
        tableView.registerCell(nibName: SettingLanguageTableViewCell.nameOfClass)
        tableView.registerCell(nibName: SettingAppTableViewCell.nameOfClass)
        tableView.registerCell(nibName: SettingVersionTableViewCell.nameOfClass)
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clear
        
        let layer = CAGradientLayer()
        let color1 = self.view.backgroundColor?.cgColor
        let color2 = UIColor(hexString: "2D354F").cgColor
        layer.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT)
        layer.colors = [color1!, color2]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        self.view.layer.insertSublayer(layer, at: 0)
        
        let numberRoll = Int(arc4random_uniform(5))
        isSleeping = numberRoll > 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingChartTableViewCell.nameOfClass, for: indexPath) as! SettingChartTableViewCell
            cell.configure(language: self.language)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingLanguageTableViewCell.nameOfClass, for: indexPath) as! SettingLanguageTableViewCell
            cell.refrenceVC = self
            cell.configure(language: self.language)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingNotificationTableViewCell.nameOfClass, for: indexPath) as! SettingNotificationTableViewCell
            cell.configure(language: self.language)
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingRateTableViewCell.nameOfClass, for: indexPath) as! SettingRateTableViewCell
            cell.configure(language: self.language)
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingFeedbackTableViewCell.nameOfClass, for: indexPath) as! SettingFeedbackTableViewCell
            cell.configure(language: self.language)
            return cell
        }
        
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingAppTableViewCell.nameOfClass, for: indexPath) as! SettingAppTableViewCell
            cell.configure(language: self.language)
            return cell
        }
        
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingVersionTableViewCell.nameOfClass, for: indexPath) as! SettingVersionTableViewCell
            cell.configure(isSleeping: self.isSleeping)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 5 {
            return cellHeights[indexPath.row]
        }
        
        if indexPath.row == 6 {
            return kVersionCellHeight
        }
        
        return kCloseCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            
            if indexPath.row == 3 {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/id1329241386?mt=8")!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string:"itms-apps://itunes.apple.com/us/app/apple-store/id1329241386?mt=8")!)
                }
            }
            
            if indexPath.row == 4 {
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients(["lmcmze@gmail.com"])
                    mail.setSubject("Feedback")
                    mail.setMessageBody("Hi" , isHTML: false)
                    present(mail, animated: true)
                }
            }
            
            return
        }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            var height = kOpenCellHeight
            
            if indexPath.row == 1 {
                height = kLanguageCellHeight
            }
            
            if indexPath.row == 5 {
                height = kAppsCellHeighet
            }
            cellHeights[indexPath.row] = height
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as SettingChartTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        //        cell.number = indexPath.row
    }
    
    // MARK: - Navigation
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let maxSet = scrollView.contentSize.height - scrollView.frame.height
        let offSet = scrollView.contentOffset.y
        if offSet > maxSet {
            scrollView.contentOffset.y = maxSet
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @objc func updateLanguage (notification: Notification) {
        let tag = notification.object as! Int
        self.language = Language(rawValue: tag)!
        self.tableView.reloadData()
    }
}
