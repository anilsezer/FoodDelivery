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
    
    func sepeteEkleTapped(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, yemek_siparis_adet: Int, kullanici_adi: String) {
        let params: Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                  
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
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
