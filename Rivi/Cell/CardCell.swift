//
//  CardCell.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var bottomPosition: NSLayoutConstraint!
    @IBOutlet weak var topPosition: NSLayoutConstraint!
    @IBOutlet weak var leftPosition: NSLayoutConstraint!
    @IBOutlet weak var rightPosition: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardDescription: UILabel!
    @IBOutlet weak var border: UIView!
    
    @IBOutlet weak var chevronImageView: UIImageView!
    
    private var shadowLayer: CAShapeLayer!
            private var cornerRadius: CGFloat = 3
    var bottomInset:CGFloat = 10
    
    enum CardCellType {
        case list
        case detail
    }
    private var cellType:CardCellType = .list
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        
       
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func layoutSubviews() {
        super.layoutSubviews()
        // self.containerView.backgroundColor = .red
        
       // self.contentView.backgroundColor = .purple
        let inserBound = self.contentView.bounds.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: self.bottomInset, right: 20))
        if  self.cellType == .detail && nil == shadowLayer {
            shadowLayer = Helper.shared.createShadowLayer(cornerRadius: cornerRadius, bounds: inserBound)
            self.contentView.layer.masksToBounds = false
          //  self.containerView.layer.borderColor = UIColor.black.cgColor
          //   self.containerView.layer.borderWidth = 1
            self.contentView.layer.insertSublayer(shadowLayer, at: 0)
        }

        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
         self.contentView.frame =  self.bounds

    }
    
    private func setup() {
        self.cardTitle.textColor = .black
        self.cardImageView.contentMode = .scaleAspectFill
        self.cardImageView.layer.cornerRadius = ThemeManager.Default.largeCornerRadius
        self.cardDescription.textColor = ColorManager.Default.grayFontColor
        self.cardDescription.font = ThemeManager.Default.montserratMediumFont(size: 10)
        self.cardTitle.font = ThemeManager.Default.montserratSemiBoldFont(size: 17)
        self.border.backgroundColor = ColorManager.Default.borderColor
        
    }
    
    
   

    
    func populate(card:Card,type:CardCellType) {
        self.cellType = type
        self.cardTitle.text = card.title
        self.cardDescription.text = card.desc
        if let url = URL(string: card.img ?? "") {
            self.cardImageView.load(url: url)
        }
        
        if type == .list {
            self.leftPosition.constant = 0
            self.rightPosition.constant = 0
            self.topPosition.constant = 0
            self.bottomPosition.constant = 0
            self.chevronImageView.isHidden = true
            self.border.isHidden = false
        } else {
            self.chevronImageView.isHidden = false
            self.border.isHidden =  bottomInset == 10 ? true : false
            
            
        }
        
        
        
    }

}
