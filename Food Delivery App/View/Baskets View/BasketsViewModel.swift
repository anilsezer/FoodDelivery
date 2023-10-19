//
//  BasketsViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import Foundation
import Alamofire

class BasketsViewModel {
    
    var sepetYemekListesi = [YemeklerDetay]()
    
    func sepetiGetir(kullaniciAdi: String) {
        let params: Parameters = ["kullanici_adi": kullaniciAdi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(YemeklerDetayCevap.self, from: data)
                    if let list = response.sepet_yemekler {
                        DispatchQueue.main.async {
                            self.sepetYemekListesi = list
                            
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    func yemegiSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params : Parameters = ["sepet_yemek_id" : sepet_yemek_id, "kullanici_adi" : kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                    DispatchQueue.main.async {
                        self.sepetiGetir(kullaniciAdi: kullanici_adi)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
