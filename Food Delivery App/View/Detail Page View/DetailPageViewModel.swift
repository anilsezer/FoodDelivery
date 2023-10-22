//
//  DetailPageViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 16.10.2023.
//

import Foundation
import Alamofire
import CoreData
import UIKit

class DetailPageViewModel {
    
    var sepetYemekListesi = [YemeklerDetay]()
    
    func addToFavorites(_ yemek: Yemekler) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchrequest.predicate = NSPredicate(format: "id == %@", yemek.yemek_id!)
        fetchrequest.returnsObjectsAsFaults = false
        
        do {
            let existingFood = try context.fetch(fetchrequest)
            if let _ = existingFood.first {
                print("food exist")
                return
            } else {
                let savingYemek = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
                savingYemek.setValue(yemek.yemek_adi, forKey: "name")
                savingYemek.setValue(yemek.yemek_fiyat, forKey: "price")
                savingYemek.setValue(yemek.yemek_id, forKey: "id")
                savingYemek.setValue(yemek.yemek_resim_adi, forKey: "image")
                try context.save()
                print("saved")
                
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
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
    func yemegiSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params : Parameters = ["sepet_yemek_id" : sepet_yemek_id, "kullanici_adi" : kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print(result)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
