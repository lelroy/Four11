//
//  NetworkingManager.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-16.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    //Check for internet connection
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //API call
    static func makeAPICall(page:String,
                            context:String ,
                            category:String,
                            country:String ,
                            completion: @escaping (DataResponse<Any>)->Void) {
        
        //Build url string based on inputs
        var url = API.BASEURL
        //Context
        url = url + context + "?"
        //API Key
        url = url + "apiKey="+API.API_KEY
        //Country
        url = url + "&country=" + country
        //Category
        if category != "" {
            url = url + "&category=" + category
        }
        if page != "" {
            url = url + "&page=" + page
        }
        //HTTP request
        Alamofire.request(url).responseJSON { (response) in
            completion(response)
        }
    }
}
