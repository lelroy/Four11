//
//  NewsArticleCell.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-16.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit
import SDWebImage

class NewsArticleCell: UITableViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var storyImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Configure cell
    func configure (with article:NewsArticle?){
        if article != nil {
            sourceLabel.text = article!.source
            descriptionLabel.text = article!.description
            headlineLabel.text = article!.headline
            //storyImageView.sd_setImage(with: URL(string: article!.imageURL), placeholderImage: UIImage(named: IMAGES.PLACEHOLDER))
            
        } else {
            sourceLabel.text = "Random source news"
            descriptionLabel.text = "This is a long description on purpose, the whole point is to test how long descriptions behave in the UI. Ultimately the goal is to see whether the text is readable and overall looks. Hopefully newswriters will take the time to write short and understandable descriptions. In the meantime this long ass description is here to show the worst case scenario. "
            headlineLabel.text = "This is a random headline. The headline is relatively long and the point is to show how a headline would look if it were unnecessarily long."
        }
        
    }
    
}
