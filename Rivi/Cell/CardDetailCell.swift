//
//  CardDetailCell.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

class CardDetailCell: UITableViewCell {
    
    static let IDENTIFIER = "CardDetailCell"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var photosSectionLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var bestSectionLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var whereSectionLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var aboutSectionLabel: UILabel!
    @IBOutlet weak var bestStack: UIStackView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var whereStack: UIStackView!
    private var card:Card?
    private var shadowLayer: CAShapeLayer!
              private var cornerRadius: CGFloat = 3
     var bottomInset:CGFloat = 10
    override func awakeFromNib() {
        super.awakeFromNib()
      setup()
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        if nil == shadowLayer {
            let inserBound = self.contentView.bounds.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
                  
                      shadowLayer = Helper.shared.createShadowLayer(cornerRadius: cornerRadius, bounds: inserBound)
                      self.contentView
                        .layer.masksToBounds = false
                    //  self.containerView.layer.borderColor = UIColor.black.cgColor
                    //   self.containerView.layer.borderWidth = 1
            //shadowLayer.shadowOpacity = 0.25
                      self.contentView.layer.insertSublayer(shadowLayer, at: 0)

        }
              
    }
    
    override func prepareForReuse() {
        self.shadowLayer.removeFromSuperlayer()
        self.shadowLayer = nil
       
    }
    
    private func setup() {
        self.aboutSectionLabel.font = ThemeManager.Default.montserratBoldFont(size: 12)
        self.aboutLabel.font = ThemeManager.Default.montserratMediumFont(size: 12)
        self.aboutSectionLabel.textColor = .black
           // UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1)
        self.aboutLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        
        
        self.whereSectionLabel.font = ThemeManager.Default.montserratBoldFont(size: 12)
        self.whereLabel.font = ThemeManager.Default.montserratMediumFont(size: 12)
        self.whereSectionLabel.textColor = .black
            //UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1)
        self.whereLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        
        self.bestSectionLabel.font = ThemeManager.Default.montserratBoldFont(size: 12)
        self.bestLabel.font = ThemeManager.Default.montserratMediumFont(size: 12)
        self.bestSectionLabel.textColor = .black
            //UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1)
        self.bestLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        
        self.photosSectionLabel.font = ThemeManager.Default.montserratBoldFont(size: 12)
        
        self.photosSectionLabel.textColor = .black
            //UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1)
        
        
        self.readMoreButton.setTitleColor(ColorManager.Default.grayFontColor, for: .normal)
        
        self.collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.IDENTIFIER)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(card:Card) {
        self.card = card
        self.collectionView.reloadData()
        self.aboutLabel.text = card.details?.about?.first
        let places = card.details?.detailsWhere?.map{$0.generatePlacesText()}
        
        if let formattedPlaces = Helper.shared.formatMultiline(items: places) {
             self.whereStack.isHidden = false
            self.whereLabel.text = formattedPlaces
        } else {
            self.whereStack.isHidden = true
        }
        let dishes = card.details?.dishes
        if let formattedDishes = Helper.shared.formatMultiline(items: dishes) {
             self.bestStack.isHidden = false
            self.bestLabel.text = formattedDishes
        } else {
            self.bestStack.isHidden = true
           
        }
        
        
        
    }
    
    
    
}

extension CardDetailCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return card?.details?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.IDENTIFIER, for: indexPath) as! BannerCell
        let image = self.card?.details?.images?[indexPath.row]
        cell.populate(path: image)
        return cell
        
    }
}

extension CardDetailCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - (3*10)) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
