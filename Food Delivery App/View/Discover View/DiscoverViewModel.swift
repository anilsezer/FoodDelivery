//
//  DiscoverViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import Foundation
import Alamofire

class DiscoverViewModel {
    
    var fullList = [Foods]()
    
    func search(searchWords: String) -> [Foods] {
        var searchList = [Foods]()
        searchList = fullList.filter({
            $0.yemek_adi!.lowercased().contains(searchWords.lowercased())
        })
        return searchList
    }
    
    func fetchFoods(completion: @escaping([Foods]? )-> Void ) {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    var liste = [Foods]()
                    if let foodsLists = cevap.yemekler {
                        completion(foodsLists)
                        liste = foodsLists
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
