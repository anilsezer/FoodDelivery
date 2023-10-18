//
//  DetailPageVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 14.10.2023.
//

import UIKit

class DetailPageVC: UIViewController {
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tutarLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var yemek: Yemekler?
    var count = 1
    
    var viewModel = DetailPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let yemek = yemek {
            foodNameLabel.text = yemek.yemek_adi
            foodPriceLabel.text = "\(yemek.yemek_fiyat!) ₺"
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.foodImage.kf.setImage(with: url)
                }
            }
        }
        updateCountLabel()
        updateTutarLabel()
    }
    
    @IBAction func plusButton(_ sender: Any) {
        plusButtonTapped()
    }
    
    @IBAction func decreaseButton(_ sender: Any) {
        decreaseButtonTapped()
    }
    
    @IBAction func addBasketButton(_ sender: Any) {
        guard let yemek = yemek else { return }
        var kullaniciAdi = "KullaniciAdi" 
        viewModel.sepeteEkleTapped(yemek: yemek, adet: count, kullaniciAdi: kullaniciAdi)
        
    }
    private func plusButtonTapped() {
        if count < 8 {
            count += 1
            updateCountLabel()
            updateTutarLabel()
        }
    }
    
    private func decreaseButtonTapped() {
        if count > 1 {
            count -= 1
            updateCountLabel()
            updateTutarLabel()
        }
    }
    private func updateCountLabel() {
        countLabel.text = "\(count)"
    }
    private func updateTutarLabel() {
        if let priceText = foodPriceLabel.text {
            let cleanedPriceText = priceText.replacingOccurrences(of: "₺", with: "").trimmingCharacters(in: .whitespaces)
            
            if let price = Int(cleanedPriceText) {
                let total = count * price
                totalPriceLabel.text = "\(total) ₺"
            } else {
                totalPriceLabel.text = ""
            }
        }
    }
}
