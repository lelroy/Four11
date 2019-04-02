//
//  ArticleFeedNetworking.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-28.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import Foundation

extension ArticleFeedViewController {
    
    //Regular call with no parameters
    func fetchArticles(country:String,category:String, completion: @escaping ([NewsArticle])->Void) {
        ResponseManager.fetchArticles(country:country,category:category) { (response, articles, totalArticles) in
            if response == "ok" {
                self.articles[category] = articles
                self.articlesTotals[category] = totalArticles
                self.loadingFlags[category] = false
                self.page[category] = 1
                completion(articles)
            } else {
                AlertUtil.showAlert(in: self, msg: ERROR.NO_DATA , title: response)
            }
        }
    }
    
    func fetchMoreArticles(country:String,currentArticles:[NewsArticle],category:String, page:Int, completion: @escaping([NewsArticle])->Void) {
        let stringPage = String(page)
        loadingFlags[category] = true
        ResponseManager.fetchArticles(page: stringPage,country:country, category: category) { (response, articles, totalArticles) in
            
            if response == "ok" {
                let newArticlesArray = currentArticles + articles
                self.articles[category] = newArticlesArray
                self.loadingFlags[category] = false
                self.page[category] = page
                completion(newArticlesArray)
            } else {
                AlertUtil.showAlert(in: self, msg: ERROR.NO_DATA , title: response)
            }
        }
    }
    
}
