//
//  BasketsVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import Kingfisher
class BasketsVC: UIViewController {

    @IBOutlet weak var basketTableView: UITableView?
    
    var viewModel = BasketsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTableView?.dataSource = self
        basketTableView?.delegate = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        basketTableView?.reloadData()
        viewModel.sepetiGetir(kullaniciAdi: "kullaniciAdi")
    }

}
extension BasketsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sepetYemekListesi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        let yemekDetay = viewModel.sepetYemekListesi[indexPath.row]
        
        cell.foodNameLabel.text = yemekDetay.yemek_adi
        cell.foodCountLabel.text = "\(yemekDetay.yemek_siparis_adet) "
        cell.foodPriceLabel.text = "\(yemekDetay.yemek_fiyat) ₺"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekDetay.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        
        return cell
    }



}
