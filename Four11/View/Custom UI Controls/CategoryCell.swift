//
//  SectionCell.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-26.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isHighlighted: Bool {
        didSet {
            iconImageView.tintColor = isHighlighted ? COLORS.TERTIARY : COLORS.SECONDARY
        }
    }
    
    override var isSelected: Bool {
        didSet {
            iconImageView.tintColor = isSelected ? COLORS.TERTIARY : COLORS.SECONDARY
        }
    }
    
    func setupCell(section:String) {
       //elf.backgroundColor = UIColor.black
        iconImageView.tintColor = COLORS.SECONDARY
        switch section {
        case "Business":
            iconImageView.image = UIImage(named: "business")?.withRenderingMode(.alwaysTemplate)
        case "Entertainment":
            iconImageView.image = UIImage(named: "entertainment")?.withRenderingMode(.alwaysTemplate)
        case "Health":
            iconImageView.image = UIImage(named: "health")?.withRenderingMode(.alwaysTemplate)
        case "Science":
            iconImageView.image = UIImage(named: "science")?.withRenderingMode(.alwaysTemplate)
        case "Sports":
            iconImageView.image = UIImage(named: "sports")?.withRenderingMode(.alwaysTemplate)
        case "Technology":
            iconImageView.image = UIImage(named: "technology")?.withRenderingMode(.alwaysTemplate)
        default:
            iconImageView.image = UIImage()
        }
    }

}
