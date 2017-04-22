//
//  ItemCell.swift
//  dreamLister
//
//  Created by Luke Morrison on 2017-04-20.
//  Copyright © 2017 Andrew Morrison. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    
    func configureCell(item: Item) {
        titleLbl.text = item.title
        priceLbl.text = "$\(item.price)"
        detailsLbl.text = item.details
        thumbnailImg.image = item.toImage?.image as? UIImage
    }
    
}
