//
//  FoodsResponse.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 12.10.2023.
//

import Foundation

class FoodsResponse : Codable  {
    var yemekler: [Foods]?
    var success: Int?
}
