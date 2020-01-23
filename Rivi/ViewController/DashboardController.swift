//
//  ViewController.swift
//  Rivi
//
//  Created by amandeep saluja on 18/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import UIKit

class DashboardController: UIViewController {
    
    @IBOutlet weak var seeMoreLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var tableView: UITableView!
    private var shadowLayer: CAShapeLayer!
         private var cornerRadius: CGFloat = 7
         private var fillColor: UIColor = .blue
    
    var model:ModelData? {
        didSet {
            if let title = self.model?.cardDetails?.title, let city = self.model?.cardDetails?.city {
                self.headerLabel.text = "\(title) \(city)"
                
            }
            
            if let cards = self.model?.card {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        load()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = Helper.shared.createShadowLayer(cornerRadius: cornerRadius, bounds: self.containerView.bounds)
            self.containerView.layer.masksToBounds = false
            self.containerView.layer.insertSublayer(shadowLayer, at: 0)
        }
        
        
    }
    
    func setup() {
        tableView.separatorColor = .clear
        self.seeMoreLabel.textColor = ColorManager.Default.grayFontColor
        self.seeMoreLabel.font = ThemeManager.Default.montserratMediumFont(size: 10)
        self.userLabel.font =   ThemeManager.Default.montserratMediumFont(size: 10)
        self.userLabel.textColor = ColorManager.Default.blueFontColor
        self.headerLabel.font = ThemeManager.Default.montserratExtraBoldFont(size: 20)
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
       
        tableView.rowHeight = 60
        self.tableView.bounces = false
        //tableView.estimatedRowHeight = 80
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCard))
        self.containerView.isUserInteractionEnabled = true
        self.containerView.addGestureRecognizer(tap)
       
    
    }
    
    @objc func didTapCard() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.model = self.model
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func load() {
        guard let url = URL(string: "https://my-json-server.typicode.com/guljar-rivi/server/db") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return}
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    self.model = model.data
                }
                
            } catch {
                print(error)
            }
            
        }.resume()
    }


}

extension DashboardController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = model?.card?.count ?? 0
        return min(count,2)
    }
    
    
    
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        
        let card = self.model!.card![indexPath.section]
        cell.populate(card: card, type: .list)
        return cell
    }
    
    
}


extension DashboardController: UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}


