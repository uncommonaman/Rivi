//
//  HeaderView.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    lazy var collectionView:UICollectionView = {
       let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var userLabel:UILabel = {
        let label = UILabel()
        label.text = "CURATED FOR MAYANK"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =   ThemeManager.Default.montserratMediumFont(size: 10)
        label.textColor = ColorManager.Default.blueFontColor
        return label
    }()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = ThemeManager.Default.montserratExtraBoldFont(size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pageControl:UIPageControl = {
        
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = ColorManager.Default.blueFontColor
        
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    var bannerImageURLs:[String]? {
        didSet {
            if let count = self.bannerImageURLs?.count {
                pageControl.numberOfPages = count
                self.collectionView.reloadData()
            }
            self.pageControl.currentPage = 0
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.IDENTIFIER)
              self.pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        self.addSubview(titleLabel)
        self.addSubview(userLabel)
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        
        self.userLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.userLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.userLabel.bottomAnchor, constant: 10).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -63).isActive = true
        
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
         self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 14).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 157).isActive = true
        
        self.pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.pageControl.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 17).isActive = true
         
        
        
    }
    
    @objc func didChangePage() {
           self.collectionView.scrollToItem(at: IndexPath(row: self.pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
       }

}


extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImageURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.IDENTIFIER, for: indexPath) as! BannerCell
        let path = self.bannerImageURLs?[indexPath.row]
        cell.populate(path: path )
     
        return cell
    }
    
  
    
    
}



extension HeaderView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class BannerCell:UICollectionViewCell {
    static let IDENTIFIER = "BannerCell"
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         self.layer.cornerRadius = ThemeManager.Default.smallCornerRadius
    }
    
    private func setup() {
        self.addSubview(imageView)
        self.clipsToBounds = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func populate(path:String?) {
        
        guard let first = path?.split(separator: "&").first else { return }
        let str = "\(first)&auto=format&fit=crop&w=\(self.frame.width)&q=80"
        if let url = URL(string: str) {
           
           self.imageView.load(url: url)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
