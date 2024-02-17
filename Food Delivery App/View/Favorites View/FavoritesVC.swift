//
//  FavoritesViewController.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    
    let viewModel = FavoritesViewModel()
    
    @IBOutlet weak var anyFavoritesInfoLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(viewModel.fetchFavorites())
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesTableView.reloadData()
        isFavoritesEmty()
    }
    private func isFavoritesEmty() {
        anyFavoritesInfoLabel.isHidden = viewModel.fetchFavorites().isEmpty ? false : true
    }
}

extension FavoritesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchFavorites().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        let yemekDetay = viewModel.fetchFavorites()[indexPath.row]
        
        cell.foodName.text = yemekDetay.yemek_adi!
        cell.foodPrice.text = "\(yemekDetay.yemek_fiyat!) ₺"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekDetay.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let food = self.viewModel.fetchFavorites()[indexPath.row]
            let alert = UIAlertController(title: "Are You Sure!", message: "\(food.yemek_adi!) will delete?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                self.viewModel.deleteFavorite(food)
                self.favoritesTableView.reloadData()
                self.isFavoritesEmty()
            }
            alert.addAction(deleteAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
