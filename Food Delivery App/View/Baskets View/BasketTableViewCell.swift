//
//  BasketTableViewCell.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 15.10.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodCountLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
