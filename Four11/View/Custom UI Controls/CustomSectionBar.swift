//
//  CustomSectionBar.swift
//  Four11
//
//  Created by Omar Padierna on 2019-03-26.
//  Copyright © 2019 Omar Padierna. All rights reserved.
//

import UIKit

class CustomSectionBar: UIView {
    
    //Collection view instantiation (Section icons are a collection view)
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = COLORS.PRIMARY
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var sections = ["Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
    var articleFeedController:ArticleFeedViewController?
    var horizontalBarLeftAnchorConstraint:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = COLORS.PRIMARY
        //Register custom cell
        collectionView.register(UINib(nibName: CUSTOM_CELLS.CATEGORY_CELL, bundle: nil), forCellWithReuseIdentifier: CUSTOM_CELLS.CATEGORY_CELL)
        //Add collection view to UIView containing it.
        addSubview(collectionView)
        addConstraintsWithFormat("H:|-46-[v0]-46-|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        setupHorizontalBar()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Horizontal bar
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = COLORS.TERTIARY
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: collectionView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1/CGFloat(sections.count)).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
}

//MARK:- Collection view
extension CustomSectionBar: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    // Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CUSTOM_CELLS.CATEGORY_CELL, for: indexPath) as! CategoryCell
        cell.setupCell(section: sections[indexPath.row])
        return cell
    }
    // Cell sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/CGFloat(sections.count), height: 44)
    }
    // Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // Selecting item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        articleFeedController?.scrollToSectionIndex(sectionIndex: indexPath.item)
        articleFeedController?.currentSection = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
