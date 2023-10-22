//
//  DiscoverViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import Foundation
import Alamofire

class DiscoverViewModel {
    
    var tamListe = [Yemekler]()
    
    func ara(aramaKelimesi: String) -> [Yemekler] {
        var aramaListesi = [Yemekler]()
        aramaListesi = tamListe.filter({
            $0.yemek_adi!.lowercased().contains(aramaKelimesi.lowercased())
            
        })
        return aramaListesi
    }
    func yemekleriGetir(completion: @escaping([Yemekler]? )-> Void ) {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    var liste = [Yemekler]()
                    if let yemekListesi = cevap.yemekler {
                        completion(yemekListesi)
                        liste = yemekListesi
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
