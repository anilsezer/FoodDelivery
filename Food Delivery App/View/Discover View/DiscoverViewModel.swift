//
//  DiscoverViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import Foundation
import RxSwift

class DiscoverViewModel {
    
    var yemeklerRepo = YemeklerDaoRepository()

    func yemekleriGetir(completion: @escaping([Yemekler]? )-> Void ) {
        yemeklerRepo.yemekleriGetir{ yemekler in
            completion(yemekler)
            
        }
    }
    func searchFood() {
        
    }
    
}
