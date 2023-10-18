//
//  DetailPageViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 16.10.2023.
//

import Foundation
import Alamofire

class DetailPageViewModel {
    
    var sepetYemekListesi = [YemeklerDetay]()
    
    func sepeteEkleTapped(yemek: Yemekler, adet: Int, kullaniciAdi: String) {
        let params: Parameters = ["yemek_adi": yemek.yemek_adi, "yemek_resim_adi" : yemek.yemek_resim_adi, "yemek_fiyat" : yemek.yemek_fiyat, "yemek_siparis_adet" : adet, "kullanici_adi": kullaniciAdi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONSerialization.jsonObject(with: data)
                    print(response)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
}
