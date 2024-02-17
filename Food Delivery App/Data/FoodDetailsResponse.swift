//
//  FoodDetailsResponse.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 16.10.2023.
//

import Foundation

class FoodDetailsResponse: Codable {
    
    var sepet_yemekler: [FoodDetails]?
    var success : Int?
}
