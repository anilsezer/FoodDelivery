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
    var tamListe = [Yemekler]()

    func yemekleriGetir(completion: @escaping([Yemekler]? )-> Void ) {
        yemeklerRepo.yemekleriGetir{ yemekler in
            completion(yemekler)
        }
    }
    func ara(aramaKelimesi: String) -> [Yemekler] {
        var aramaListesi = [Yemekler]()
        aramaListesi = tamListe.filter({
            $0.yemek_adi!.lowercased().contains(aramaKelimesi.lowercased())
           
        })
        return aramaListesi
    }
}
