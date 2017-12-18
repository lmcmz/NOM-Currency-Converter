//
//  CurrencyCollectionViewCell.swift
//  ExchangeRate
//
//  Created by lmcmz on 11/12/2017.
//  Copyright © 2017 lmcmz. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(currency: Currency) {
        self.currencyLabel.text = Currency.symbol(currency: currency)
        self.nameLabel.text = currency.rawValue
        self.imageView.image = Currency.image(currency: currency)
        
        self.currencyLabel.font = self.currencyLabel.font.withSize(38)
        
        if currencyLabel.text?.count == 2 {
            self.currencyLabel.font = self.currencyLabel.font.withSize(25)
        }
        
        if currencyLabel.text?.count == 3 {
            self.currencyLabel.font = self.currencyLabel.font.withSize(20)
        }
    }

}
