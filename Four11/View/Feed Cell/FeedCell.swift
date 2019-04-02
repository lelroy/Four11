//
//  FeedCell.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-27.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

protocol FeedCellDelegate {
    func reloadData(feedView:FeedCell,section:String,refreshControl:UIRefreshControl)
    func loadNextPage(feedView:FeedCell, section:String)
    func populateCollection(feedView:FeedCell,section:String)
    func goToArticle(articleURL:String)
    
}

class FeedCell: UICollectionViewCell{
    //TODO: Set up collection view here.
    
    lazy var articlesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = COLORS.TERTIARY
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    var section = ""
    
    var articles = [NewsArticle]()
    
    var delegate:FeedCellDelegate?
    
    let refreshControl = UIRefreshControl()
    
    var total = 0
    var page = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        articlesCollectionView.register(UINib(nibName: CUSTOM_CELLS.ARTICLE_CELL, bundle: nil), forCellWithReuseIdentifier: CUSTOM_CELLS.ARTICLE_CELL)
        addSubview(articlesCollectionView)
        addConstraintsWithFormat("H:|[v0]|", views: articlesCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views: articlesCollectionView)
        addRefreshControl()
    }

    
    func checkContent() {
        if articles.count == 0 {
            delegate?.populateCollection(feedView: self, section: section)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- Collection View
extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    //Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CUSTOM_CELLS.ARTICLE_CELL, for: indexPath) as! ArticleCell
        let article = articles[indexPath.item]
        cell.configure(with: article)
        return cell
    }
    //Cell sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 477)
    }
    //Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //For pagination: When reaching the last row, reload more data.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == articles.count - 1 {
            delegate?.loadNextPage(feedView: self, section: section)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.item]
        let url = article.articleURL
        delegate?.goToArticle(articleURL: url)
    }
    
    //Refresh control
    func addRefreshControl(){
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        articlesCollectionView.addSubview(refreshControl)
    }
    
    @objc func refreshFeed(){
        delegate?.reloadData(feedView: self,section:section ,refreshControl: refreshControl)
    }
    
}
