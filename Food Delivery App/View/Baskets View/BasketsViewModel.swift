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
    
    func sepetiGetir(kullaniciAdi: String, completion: @escaping () -> Void) {
        let params: Parameters = ["kullanici_adi": kullaniciAdi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(YemeklerDetayCevap.self, from: data)
                    if let list = response.sepet_yemekler {
                        DispatchQueue.main.async {
                            self.sepetYemekListesi = list
                            completion()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    completion()
                }
            }
        }
    }
}
