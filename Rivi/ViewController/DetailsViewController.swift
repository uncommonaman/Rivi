//
//  DetailsViewController.swift
//  Rivi
//
//  Created by amandeep saluja on 19/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

struct ExpandableSection {
    var isExpanded:Bool
    var row:Card
}

class DetailsViewController: UIViewController {
    var headerView:HeaderView?
    var model:ModelData?
    private var expandableSections:[ExpandableSection]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        if let bannerViewController = self.children.first as? BannerController {
//            self.bannerController = bannerViewController
//            self.bannerController?.bannerImageURLs = self.model?.card?.first?.details?.images
//        }
        setup()
      
    }
    
    private func setup() {
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        headerView = HeaderView(frame: .zero)
        headerView!.bannerImageURLs = self.model?.card?.first?.details?.images
        headerView!.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 300)
        
        if let title = self.model?.cardDetails?.title, let city = self.model?.cardDetails?.city {
            headerView!.titleLabel.text  = "\(title) \(city)"
            
        }
        
        self.tableView.tableHeaderView = headerView
        
        self.tableView.separatorColor = .clear
        guard let cards = self.model?.card else { return }
        self.expandableSections = cards.map{ ExpandableSection(isExpanded: false, row: $0) }
        self.tableView.register(UINib(nibName: "CardDetailCell", bundle: nil), forCellReuseIdentifier: CardDetailCell.IDENTIFIER)
        
        
        
    }
    
   
    
    
    
    //str.map
}

extension DetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.expandableSections?.count ?? 0
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.expandableSections![section].isExpanded {
            return 1
        } else {
            return 0
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailCell.IDENTIFIER, for: indexPath) as! CardDetailCell
        let card = self.expandableSections![indexPath.section].row
       
        cell.populate(card: card)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("CardCell", owner: self, options: nil)?.first as! CardCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandCollapseHeader))
        view.tag = section
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        guard  let card = self.expandableSections?[section].row else { return nil }
     let expanded = self.expandableSections![section].isExpanded
        view.bottomInset = expanded ? 0 : 10
        view.populate(card: card, type: .detail)
        return view
    }
    
    @objc func expandCollapseHeader(sender: UITapGestureRecognizer) {
        guard let tappedView  = sender.view else { return }
        let section = tappedView.tag
        let expanded = self.expandableSections![section].isExpanded
        let indexPath = IndexPath(item: 0, section: section)
        if expanded {
             self.expandableSections![section].isExpanded = !expanded
       
           
        } else {
             self.expandableSections![section].isExpanded = !expanded
       
        }
        
        if let openedIndex = findOpenedSection(section: section) {
             self.expandableSections![openedIndex].isExpanded = false
        }
      
        UIView.transition(with: tableView,
        duration: 0.35,
        options: .transitionCrossDissolve,
        animations: { self.tableView.reloadData() })
//        self.tableView.reloadData()
    
    }
    
    private func findOpenedSection(section:Int) -> Int? {
       let section = self.expandableSections?.enumerated().filter({ (offset,item) -> Bool in
            return item.isExpanded && offset != section
        })
        
        

        return section?.first?.offset
    }
    
   
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.expandableSections![indexPath.section].isExpanded {
             return 300
        } else {
            return 0
        }
        
    }
    
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  85
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//         return UITableView.automaticDimension
//    }
    
   
}

extension DetailsViewController: UITableViewDelegate {
    
}
