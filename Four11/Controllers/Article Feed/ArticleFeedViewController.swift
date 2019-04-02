//
//  ArticleFeedViewController.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-26.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit
import CoreLocation
class ArticleFeedViewController: UIViewController {
    //UI variables and outlets
    @IBOutlet weak var feedCollectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    let sectionsControl: CustomSectionBar = {
        let sC = CustomSectionBar()
        return sC
    }()
    
    //Variables
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var articles = [String:[NewsArticle]]()
    var articlesTotals = [String:Int]()
    var loadingFlags = [String:Bool]()
    var page = [String:Int]()
    var totalArticles = 0
    var articleURL = ""
    var currentSection = 0
    var currentCountry = "ca"
    var countriesDictionary = ["argentina":API_COUNTRY.ARGENTINA,
                               "australia": API_COUNTRY.AUSTRALIA,
                               "austria":API_COUNTRY.AUSTRIA,
                               "belgium":API_COUNTRY.BELGIUM,
                               "brazil":API_COUNTRY.BRAZIL,
                               "bulgaria":API_COUNTRY.BULGARIA,
                               "canada":API_COUNTRY.CANADA,
                               "china": API_COUNTRY.CHINA,
                               "colombia":API_COUNTRY.COLOMBIA,
                               "cuba":API_COUNTRY.CUBA,
                               "czech republic":API_COUNTRY.CZECH_REPUBLIC,
                               "egypt":API_COUNTRY.EGYPT,
                               "france":API_COUNTRY.FRANCE,
                               "germany":API_COUNTRY.GERMANY,
                               "greece":API_COUNTRY.GREECE,
                               "hong kong":API_COUNTRY.HONG_KONG,
                               "hungary":API_COUNTRY.HUNGARY,
                               "india":API_COUNTRY.INDIA,
                               "indonesia":API_COUNTRY.INDONESIA,
                               "ireland":API_COUNTRY.IRELAND,
                               "israel":API_COUNTRY.ISRAEL,
                               "italy":API_COUNTRY.ITALY,
                               "japan":API_COUNTRY.JAPAN,
                               "latvia":API_COUNTRY.LATVIA,
                               "lithuania":API_COUNTRY.LITHUANIA,
                               "malaysia":API_COUNTRY.MALAYSIA,
                               "mexico":API_COUNTRY.MEXICO,
                               "morocco":API_COUNTRY.MOROCCO,
                               "netherlands":API_COUNTRY.NETHERLANDS,
                               "new zealand":API_COUNTRY.NEW_ZEALAND,
                               "nigeria":API_COUNTRY.NIGERIA,
                               "norway":API_COUNTRY.NORWAY,
                               "philippines":API_COUNTRY.PHILIPPINES,
                               "poland":API_COUNTRY.POLAND,
                               "portugal":API_COUNTRY.PORTUGAL,
                               "romania":API_COUNTRY.ROMANIA,
                               "russia":API_COUNTRY.RUSSIA,
                               "saudi arabia":API_COUNTRY.SAUDI_ARABIA,
                               "serbia":API_COUNTRY.SERBIA,
                               "singapore":API_COUNTRY.SINGAPORE,
                               "slovakia":API_COUNTRY.SLOVAKIA,
                               "slovenia":API_COUNTRY.SLOVENIA,
                               "south africa":API_COUNTRY.SOUTH_AFRICA,
                               "south korea":API_COUNTRY.SOUTH_KOREA,
                               "sweden":API_COUNTRY.SWEDEN,
                               "switzerland":API_COUNTRY.SWITZERLAND,
                               "taiwan":API_COUNTRY.TAIWAN,
                               "thailand":API_COUNTRY.THAILAND,
                               "turkey":API_COUNTRY.TURKEY,
                               "uae":API_COUNTRY.UAE,
                               "ukraine":API_COUNTRY.UKRAINE,
                               "united states":API_COUNTRY.UNITED_STATES,
                               "united kingdom":API_COUNTRY.UNITED_KINGDOM,
                               "venezuela":API_COUNTRY.VENEZUELA]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup collection view and section bar
        self.view.backgroundColor = COLORS.PRIMARY
        setupCollectionView()
        sectionsControl.articleFeedController = self
        
        //Setup location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Add custom section bar to view
        view.addSubview(sectionsControl)
        view.addConstraintsWithFormat("H:|[v0]|", views: sectionsControl)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: sectionsControl,feedCollectionView)
        
        // Select first element in section bar
        self.title = sectionsControl.sections.first
        if NetworkingManager.isConnectedToInternet() {
            fetchArticles(country: currentCountry, category: sectionsControl.sections.first!) { (articles) in
                OperationQueue.main.addOperation {
                    self.feedCollectionView.reloadData()
                }
            }
        } else {
            AlertUtil.showAlert(in: self, msg: ERROR.NO_INTERNET, title: ERROR.NO_INTERNET)
        }
        styleNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let indexPath = IndexPath(item: currentSection, section: 0)
        sectionsControl.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        
    }
    
    //MARK:- Navigation bar styling
    private func styleNavigationBar(){
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = COLORS.PRIMARY
        navigationBar?.tintColor = COLORS.TERTIARY
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),NSAttributedString.Key.foregroundColor:COLORS.TERTIARY]
        // Get rid of bottom line in navigation bar
        navigationBar?.shadowImage = UIImage()
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
    }
    
    //MARK:- Collection view setup
    fileprivate func setupCollectionView() {
        // Delegates and cells
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: "someID")
        // Layout
        let layout = feedCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        feedCollectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        feedCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        feedCollectionView.backgroundColor = COLORS.PRIMARY
        // Scrolling and paging
        feedCollectionView.isPagingEnabled = true
        feedCollectionView.showsVerticalScrollIndicator = false
        feedCollectionView.showsHorizontalScrollIndicator = false

    }
    
    // Scroll control for sections bar
    func scrollToSectionIndex(sectionIndex:Int) {
        let indexPath = IndexPath(item: sectionIndex, section: 0)
        self.title = sectionsControl.sections[sectionIndex]
        feedCollectionView.scrollToItem(at: indexPath, at:.left, animated: true)
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SEGUE.TO_SETTINGS, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE.TO_ARTICLE {
            let destinationVC = segue.destination as! ArticleViewController
            destinationVC.urlString = articleURL
        }
        
        if segue.identifier == SEGUE.TO_SETTINGS {
            let destinationVC = segue.destination as! SettingsViewController
            destinationVC.delegate = self
            destinationVC.country = currentCountry
        }
    }
    
    
    func fetchArticlesWith(country:String) {
        articlesTotals.removeAll()
        articles.removeAll()
        loadingFlags.removeAll()
        let countryLowercased = country.lowercased()
        
        if let countryCode = countriesDictionary[countryLowercased] {
            currentCountry = countryCode
            fetchArticles(country: countryCode, category: sectionsControl.sections.first!) { (articles) in
                OperationQueue.main.addOperation {
                    self.feedCollectionView.reloadData()
                }
            }
        } else {
            currentCountry = "ca"
            AlertUtil.showAlert(in: self, msg: ERROR.LOCATION_UNAVAILABLE, title: ALERT.NO_LOCATION_TITLE)
            fetchArticles(country: currentCountry, category: sectionsControl.sections.first!) { (articles) in
                OperationQueue.main.addOperation {
                    self.feedCollectionView.reloadData()
                }
            }
        }
        
       
        
        
    }

}
//MARK:- Country control
extension ArticleFeedViewController:ChangeCountryDelegate {
    func newCountry(country: String) {
        if country != currentCountry {
            fetchArticlesWith(country: country)
        }
    }
}

