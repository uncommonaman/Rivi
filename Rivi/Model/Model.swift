//
//  Model.swift
//  Rivi
//
//  Created by amandeep saluja on 18/01/20.
//  Copyright © 2020 amandeep saluja. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Model: Codable {
    let data: ModelData?
}

// MARK: - DataClass
struct ModelData: Codable {
    let cardDetails: CardDetails?
    let card: [Card]?

    enum CodingKeys: String, CodingKey {
        case cardDetails = "card_details"
        case card
    }
}

// MARK: - Card
struct Card: Codable {
    let title, desc: String?
    let img: String?
    let cardNo: Int?
    let details: Details?

    enum CodingKeys: String, CodingKey {
        case title, desc, img
        case cardNo = "card_no"
        case details
    }
}

// MARK: - Details
struct Details: Codable {
    let about: [String]?
    let detailsWhere: [Where]?
    let dishes: [String]?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case about
        case detailsWhere = "where"
        case dishes, images
    }
    
    
    

    
   
}

// MARK: - Where
struct Where: Codable {
    let name: String?
    let distance: Double?
    
     func generatePlacesText() -> String {
        let name = self.name ?? ""
        let distance = self.distance
        if nil == distance {
            return name
        } else {
            
        }
        return  name + " " + "(\(distance!))"
    }
}

// MARK: - CardDetails
struct CardDetails: Codable {
    let title, type, city: String?
}
