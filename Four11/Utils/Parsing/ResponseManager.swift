//
//  ResponseManager.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-16.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseManager {
    
    //Fetch articles and deal with response.
    static func fetchArticles(page:String = "",
                              country:String = API_COUNTRY.CANADA,
                              category:String = "",
                              context:String = API_CONTEXT.TOP,
                              completion: @escaping(String,[NewsArticle],Int)->Void){
        
        NetworkingManager.makeAPICall(page: page,context: context, category: category, country: country) { (response) in
        
            var articles = [NewsArticle]()
            var totalItems = 0
            let statusCode = parseStatus(statusCode: response.response?.statusCode)
            if statusCode == "ok" {
                if let value = response.result.value {
                    let jsonResponse = JSON(value)
                    (articles,totalItems)  = parseResponse(response: jsonResponse)
                }
                completion(statusCode,articles,totalItems)
            } else {
                completion(statusCode, [],0)
            }
        }
    }
    
    //Parse response
    static func parseResponse(response:JSON)->([NewsArticle],Int) {
        let jsonArticles = response[API_STRUCTURE.ARTICLES]
        var parsedArticles = [NewsArticle]()
        let totalItems = response[API_STRUCTURE.TOTAL_RESULTS].int!
        //Iterate through articles and parse
        for index in 0..<jsonArticles.count{
            let url = jsonArticles[index][API_STRUCTURE.URL].string
            let title = jsonArticles[index][API_STRUCTURE.TITLE].string
            var source = jsonArticles[index][API_STRUCTURE.SOURCE][API_STRUCTURE.SOURCE_NAME].string
            if source == nil {
                source = ""
            }
            var description = jsonArticles[index][API_STRUCTURE.DESCRIPTION].string
            if description == nil {
                description = ""
            }
            var imageURL = jsonArticles[index][API_STRUCTURE.URL_IMAGE].string
            if imageURL == nil {
                imageURL = ""
            }
            if url != nil && title != nil {
                let newsArticle = NewsArticle(headline: title!, source: source!, description: description!, imageURL: imageURL!, articleURL: url!)
                parsedArticles.append(newsArticle)
            }
        }
        return (parsedArticles, totalItems)
    }
    
    //Parse status code
    static func parseStatus (statusCode: Int?) -> String {
        var response_status = "Unknown"
        if let code = statusCode {
            switch code {
            case 200:
                response_status = "ok"
            case 400:
                response_status = "Bad request"
            case 401:
                response_status = "Unauthorized"
            case 429:
                response_status = "Too many requests"
            case 500:
                response_status = "Sever error"
            default:
                response_status = "Unknown"
            }
        }
        return response_status
    }
    
}
