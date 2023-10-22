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
    let kullaniciAdi = "kullaniciAdi2"
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
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        viewModel.addToFavorites(yemek!)
        BasketsVC().isBasketEmpty()
    }
    @IBAction func plusButton(_ sender: Any) {
        plusButtonTapped()
    }
    
    @IBAction func decreaseButton(_ sender: Any) {
        decreaseButtonTapped()
    }
    
    @IBAction func addBasketButton(_ sender: Any) {
        // MARK: - İlk Hali
        //                if let yemek = yemek {
        //
        //                    let kullaniciAdi = "kullaniciAdi"
        //                    viewModel.sepeteEkleTapped(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: yemek.yemek_fiyat!, yemek_siparis_adet: count, kullanici_adi: kullaniciAdi)
        //                    viewModel.sepetiGetir(kullaniciAdi: kullaniciAdi) {
        //                        BasketsVC().viewModel.sepetYemekListesi = self.viewModel.sepetYemekListesi
        //                    }
        //                }
        // MARK: - İkinci Hali
        
        //        if let yemek = yemek {
        //            var toplam = count
        //            let kullaniciAdi = "kullaniciAdi"
        //            if let sonYemek = viewModel.sepetYemekListesi.first(where: {$0.yemek_adi! == yemek.yemek_adi!}) {
        //                viewModel.yemegiSil(sepet_yemek_id: Int(sonYemek.sepet_yemek_id!)!, kullanici_adi: kullaniciAdi)
        //                toplam = Int(sonYemek.yemek_siparis_adet!)! + count
        //                viewModel.sepetiGetir(kullaniciAdi: kullaniciAdi) {
        //                    BasketsVC().viewModel.sepetYemekListesi = self.viewModel.sepetYemekListesi
        //                }
        //            }
        //            viewModel.sepeteEkleTapped(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: yemek.yemek_fiyat!, yemek_siparis_adet: toplam, kullanici_adi: kullaniciAdi)
        //            viewModel.sepetiGetir(kullaniciAdi: kullaniciAdi) {
        //                BasketsVC().viewModel.sepetYemekListesi = self.viewModel.sepetYemekListesi
        //            }
        //        }
        if  let yemek = yemek {
            var toplam = count
            if let sonYemek = viewModel.sepetYemekListesi.firstIndex(where: {$0.yemek_adi! == yemek.yemek_adi! }) {
                let food = viewModel.sepetYemekListesi[sonYemek]
                toplam += Int(food.yemek_siparis_adet!)!
                viewModel.yemegiSil(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: kullaniciAdi)
                
            }
            viewModel.sepeteEkleTapped(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: yemek.yemek_fiyat!, yemek_siparis_adet: toplam, kullanici_adi: kullaniciAdi)
            viewModel.sepetiGetir(kullaniciAdi: kullaniciAdi) {
                BasketsVC().viewModel.sepetYemekListesi = self.viewModel.sepetYemekListesi
            }
        }
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
