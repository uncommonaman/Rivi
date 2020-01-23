////
////  BannerController.swift
////  Rivi
////
////  Created by amandeep saluja on 19/01/20.
////  Copyright © 2020 amandeep saluja. All rights reserved.
////
//
//import UIKit
//
//class BannerController: UIViewController {
//    
//    var bannerImageURLs:[String]? {
//        didSet {
//            if let count = self.bannerImageURLs?.count {
//                 pageControl.numberOfPages = count
//                //self.collectionView.reloadData()
//            }
//            self.pageControl.currentPage = 0
//        }
//    }
//
//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    
//    private func setup() {
//        self.collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.IDENTIFIER)
//        self.pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
//       
//    }
//    
//    @objc func didChangePage() {
//        self.collectionView.scrollToItem(at: IndexPath(row: self.pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
//    }
//    
//
//    
//}
//
//extension BannerController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return bannerImageURLs?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.IDENTIFIER, for: indexPath) as! BannerCell
//        let path = self.bannerImageURLs?[indexPath.row]
//        cell.populate(path: path )
//     
//        return cell
//    }
//    
//  
//    
//    
//}
//
//
//
//extension BannerController: UICollectionViewDelegate {
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//
//        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//    }
//}
//
//extension BannerController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
//class BannerCell:UICollectionViewCell {
//    static let IDENTIFIER = "BannerCell"
//    
//    lazy var imageView: UIImageView = {
//       let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setup()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//         self.layer.cornerRadius = ThemeManager.Default.smallCornerRadius
//    }
//    
//    private func setup() {
//        self.addSubview(imageView)
//        self.clipsToBounds = true
//        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
//        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        
//    }
//    
//    func populate(path:String?) {
//        
//        guard let first = path?.split(separator: "&").first else { return }
//        let str = "\(first)&auto=format&fit=crop&w=\(self.frame.width)&q=80"
//        if let url = URL(string: str) {
//           
//           self.imageView.load(url: url)
//        }
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
