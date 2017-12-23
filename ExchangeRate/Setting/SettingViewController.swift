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
    
    var dynamicHeight: CGFloat = 510
    var cellHeights: [CGFloat] = []
    
    @IBOutlet var tableView: UITableView!
    
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

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingChartTableViewCell.nameOfClass, for: indexPath) as! FoldingCell
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingLanguageTableViewCell.nameOfClass, for: indexPath)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingNotificationTableViewCell.nameOfClass, for: indexPath) as! SettingNotificationTableViewCell
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingRateTableViewCell.nameOfClass, for: indexPath) as! SettingRateTableViewCell
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingFeedbackTableViewCell.nameOfClass, for: indexPath) as! SettingFeedbackTableViewCell
            return cell
        }
        
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingAppTableViewCell.nameOfClass, for: indexPath) as! SettingAppTableViewCell
            return cell
        }
        
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingVersionTableViewCell.nameOfClass, for: indexPath) as! SettingVersionTableViewCell
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
                UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/id375380948?mt=8")!, options: [:], completionHandler: nil)
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
        let offSet = scrollView.contentOffset.y
        if offSet > 100 {
        }
        if offSet > 250 {
            scrollView.contentOffset.y = 250
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}