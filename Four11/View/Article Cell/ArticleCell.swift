//
//  ArticleCell.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-26.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UICollectionViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK: - Configure cell
    func configure (with article:NewsArticle?){
        if article != nil {
            sourceLabel.text = article!.source
            summaryLabel.text = article!.description
            headlineLabel.text = article!.headline
            articleImage.sd_setImage(with: URL(string: article!.imageURL), placeholderImage: UIImage(named: IMAGES.PLACEHOLDER))
            
        } else {
            sourceLabel.text = "Random source news"
            summaryLabel.text = "This is a long description on purpose, the whole point is to test how long descriptions behave in the UI. Ultimately the goal is to see whether the text is readable and overall looks. Hopefully newswriters will take the time to write short and understandable descriptions. In the meantime this long ass description is here to show the worst case scenario. "
            headlineLabel.text = "This is a random headline. The headline is relatively long and the point is to show how a headline would look if it were unnecessarily long."
        }
        
    }

}
