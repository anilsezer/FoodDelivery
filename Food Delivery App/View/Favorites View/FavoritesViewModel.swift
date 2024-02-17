//
//  FavoritesViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import Foundation
import CoreData
import UIKit

class FavoritesViewModel {
    func fetchFavorites() -> [Foods] {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        var yemekArr = [Foods]()
        fetchrequest.returnsObjectsAsFaults = false
        do {
            let results =  try context.fetch(fetchrequest)
            
            for result in results  as! [NSManagedObject] {
                let name = result.value(forKey: "name") as! String
                let price = result.value(forKey: "price") as! String
                let id = result.value(forKey: "id") as! String
                let image = result.value(forKey: "image") as! String
                
                let newYemek = Foods(yemek_id: id, yemek_adi: name, yemek_resim_adi: image, yemek_fiyat: price)
                yemekArr.append(newYemek)
            }
        } catch  {
            print(error.localizedDescription)
        }
        return yemekArr
    }
    
    func deleteFavorite(_ yemek: Foods) -> [Foods] {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        fetchrequest.predicate = NSPredicate(format: "id == %@", yemek.yemek_id!)
        fetchrequest.returnsObjectsAsFaults = false
        var yemekArr = [Foods]()
        
        do {
            let results = try context.fetch(fetchrequest)
            for result in results {
                if let objectToDelete = result as? NSManagedObject {
                    context.delete(objectToDelete)
                }
            }
            try context.save()
        } catch  {
        }
        return fetchFavorites()
    }
}
