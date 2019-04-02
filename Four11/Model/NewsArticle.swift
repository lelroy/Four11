//
//  NewsArticle.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-16.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import Foundation

class NewsArticle {
    
    var headline:String
    var description:String
    var source:String
    var imageURL:String
    var articleURL:String
    
    init(headline:String, source:String, description:String, imageURL:String, articleURL:String){
        self.headline = headline
        self.source = source
        self.imageURL = imageURL
        self.articleURL = articleURL
        self.description = description
    }
}
