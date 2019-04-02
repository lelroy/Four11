//
//  ArticleFeedCollectionView.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-26.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

extension ArticleFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FeedCellDelegate {

    
    
    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsControl.sections.count
    }
    
    // Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sectionsControl.sections[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "someID", for: indexPath) as! FeedCell
        cell.delegate = self
        cell.section = section
        
        if let articlesInSection = articles[section] {
            cell.articles = articlesInSection
        } else {
            cell.articles = []
        }
        cell.articlesCollectionView.reloadData()
        return cell
    }
    
    // Cell sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height )
    }
    
    //Scroll events to move bar in section control
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        sectionsControl.horizontalBarLeftAnchorConstraint?.constant = (scrollView.contentOffset.x/view.frame.width) * sectionsControl.collectionView.frame.width / CGFloat(sectionsControl.sections.count)
    }
    //Scroll event to turn on icon in section control
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let sectionIndex = Int(targetContentOffset.pointee.x/view.frame.width)
        let indexPath = IndexPath(item: sectionIndex, section: 0)
        sectionsControl.collectionView.selectItem(at: indexPath, animated: true, scrollPosition:.left)
        currentSection = sectionIndex
        self.title = sectionsControl.sections[indexPath.item]
    }
    
    
    //Will display (used to check if cell has data)
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellAboutToBeDisplayed = cell as! FeedCell
        cellAboutToBeDisplayed.checkContent()
    }
    //MARK:- Feed cell delegate methods.
    //Reload data
    func reloadData(feedView: FeedCell, section: String, refreshControl: UIRefreshControl) {
        fetchArticles(country:currentCountry,category: section) { (articles) in
            feedView.articles = articles
            feedView.refreshControl.endRefreshing()
            feedView.articlesCollectionView.reloadData()
        }
    }
    //Pagination
    func loadNextPage(feedView: FeedCell, section: String) {
        
        guard let currentArticleArray = articles[section] else {
            fatalError("Articles for section: \(section) are missing!")
        }
        
        guard let totalArticles = articlesTotals[section] else {
            fatalError("article total for section : \(section) is missing!")
        }
        
        guard let currentPage = page[section] else {
            fatalError("page value missing from section: \(section)")
        }
        
        let nextPage = currentPage + 1
        
        if loadingFlags[section] == false && totalArticles != currentArticleArray.count   {
            fetchMoreArticles(country:currentCountry,currentArticles: currentArticleArray, category: section, page: nextPage) { (articles) in
                feedView.articles = articles
                feedView.articlesCollectionView.reloadData()
            }
        }
    }
    //Fill cell with data.
    func populateCollection(feedView: FeedCell, section: String) {
        fetchArticles(country:currentCountry,category: section) { (articles) in
            feedView.articles = articles
            feedView.articlesCollectionView.reloadData()
        }
    }
    //Go to article
    func goToArticle(articleURL: String) {
        self.articleURL = articleURL
        performSegue(withIdentifier: SEGUE.TO_ARTICLE, sender: self)
    }
    
}
