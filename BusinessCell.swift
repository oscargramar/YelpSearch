//
//  BusinessCell.swift
//  Yelp
//
//  Created by Oscar G.M on 2/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    var number: Int = 0
    
    var business: Business! {
        didSet{
            nameLabel.text = "\(number+1). " + business.name!
            distanceLabel.text = business.distance
            categoriesLabel.text = business.categories
            reviewsCountLabel.text = " \( business.reviewCount! ) Reviews"
            ratingImageView.setImageWithURL(business.ratingImageURL!)
            thumbImageView.setImageWithURL(business.imageURL!)
            addressLabel.text = business.address
        }
    }
    func setBusinessNumber(num: Int){
        self.number = num
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
