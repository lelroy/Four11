//
//  Constants.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-16.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

//MARK: - API
enum API {
    static let BASEURL="https://newsapi.org/v2/"
    static let API_KEY="YOUR API KEY"
}

//MARK: - API Countries
enum API_COUNTRY {
    static let ARGENTINA = "ar"
    static let AUSTRALIA = "au"
    static let AUSTRIA = "at"
    static let BELGIUM = "be"
    static let BRAZIL = "br"
    static let BULGARIA = "bg"
    static let CANADA = "ca"
    static let CHINA = "cn"
    static let COLOMBIA = "co"
    static let CUBA = "cu"
    static let CZECH_REPUBLIC = "cz"
    static let EGYPT = "eg"
    static let FRANCE = "fr"
    static let GERMANY = "de"
    static let GREECE = "gr"
    static let HONG_KONG = "hk"
    static let HUNGARY = "hu"
    static let INDIA = "in"
    static let INDONESIA = "id"
    static let IRELAND = "ie"
    static let ISRAEL = "il"
    static let ITALY = "it"
    static let JAPAN = "jp"
    static let LATVIA = "lv"
    static let LITHUANIA = "lt"
    static let MALAYSIA = "my"
    static let MEXICO = "mx"
    static let MOROCCO = "ma"
    static let NETHERLANDS = "nl"
    static let NEW_ZEALAND = "nz"
    static let NIGERIA = "ng"
    static let NORWAY = "no"
    static let PHILIPPINES = "ph"
    static let POLAND = "pl"
    static let PORTUGAL = "pt"
    static let ROMANIA = "ro"
    static let RUSSIA = "ru"
    static let SAUDI_ARABIA = "sa"
    static let SERBIA = "rs"
    static let SINGAPORE = "sg"
    static let SLOVAKIA = "sk"
    static let SLOVENIA = "si"
    static let SOUTH_AFRICA = "za"
    static let SOUTH_KOREA = "kr"
    static let SWEDEN = "se"
    static let SWITZERLAND = "ch"
    static let TAIWAN = "tw"
    static let THAILAND = "th"
    static let TURKEY = "tr"
    static let UAE = "ae"
    static let UKRAINE = "ua"
    static let UNITED_KINGDOM = "gb"
    static let UNITED_STATES = "us"
    static let VENEZUELA = "ve"
}

//MARK: - Defaults

enum DEFAULTS {
    static let COUNTRY = "Canada"
}

//MARK:- API Context
enum API_CONTEXT {
    static let TOP = "top-headlines"
    static let EVERYTHING = "everything"
    static let SOURCES = "sources"
}

//MARK: - API Categories
enum API_CATEGORIES {
    static let BUSINESS = "business"
    static let ENTERTAINMENT = "entertainment"
    static let TECHNOLOGY = "technology"
    static let HEALTH = "health"
    static let SCIENCE = "science"
    static let SPORTS = "sports"
}

//MARK: - API Structure
enum API_STRUCTURE {
    static let ARTICLES = "articles"
    static let TITLE = "title"
    static let URL = "url"
    static let SOURCE = "source"
    static let SOURCE_NAME = "name"
    static let URL_IMAGE = "urlToImage"
    static let DESCRIPTION = "description"
    static let TOTAL_RESULTS = "totalResults"
}

//MARK: - Custom Cells
enum CUSTOM_CELLS {
    static let ARTICLE_CELL = "ArticleCell"
    static let CATEGORY_CELL = "CategoryCell"
}

//MARK: - Images
enum IMAGES {
    static let PLACEHOLDER = "Placeholder.png"
}

//MARK:- Alerts
enum ALERT {
    static let OK_BUTTON = "Ok"
    static let NO_INTERNET_TITLE = "No connection"
    static let NO_LOCATION_TITLE = "Bad location"
}

//MARK:- Errors
enum ERROR {
    static let NO_INTERNET = "No network connection detected."
    static let NO_DATA = "There was a problem requesting data. Please contact support or try again later"
    static let NO_LOCATION = "We could not detect your location, defaulting country to Canada"
    static let LOCATION_UNAVAILABLE = "Your country is unavailable, defaulting country to Canada"
}

//MARK:- Segues
enum SEGUE {
    static let TO_ARTICLE = "goToArticle"
    static let TO_FEED = "goToFeed"
    static let TO_SETTINGS = "goToSettings"
}

//MARK: - Colors

enum COLORS {
    static let PRIMARY = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1803921569, alpha: 1)
    static let SECONDARY = #colorLiteral(red: 0.4156862745, green: 0.4196078431, blue: 0.4156862745, alpha: 1)
    static let TERTIARY = #colorLiteral(red: 0.4549019608, green: 0.8039215686, blue: 1, alpha: 1)
}
