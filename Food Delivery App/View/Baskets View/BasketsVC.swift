//
//  BasketsVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import Kingfisher
import SnapKit

class BasketsVC: UIViewController {
    
    @IBOutlet weak var basketTableView: UITableView?
    
    @IBOutlet weak var productInfoLabel: UILabel!
    var viewModel = BasketsViewModel()
    let orderButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTableView?.dataSource = self
        basketTableView?.delegate = self
        basketTableView?.separatorColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        
        view.addSubview(orderButton)
        orderButton.setTitle("Sipariş Ver", for: .normal)
        orderButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        orderButton.layer.cornerRadius = 15
        orderButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        orderButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.sepetiGetir(kullaniciAdi: "AnilSezer") { [weak self] in
            self?.basketTableView?.reloadData()
            self?.isBasketEmpty()
        }
    }
    func isBasketEmpty() {
        if viewModel.sepetYemekListesi.isEmpty {
            viewModel.sepetYemekListesi.removeAll()
            basketTableView?.isHidden = true
            productInfoLabel?.isHidden = false
        } else {
            productInfoLabel?.isHidden = true
            basketTableView?.isHidden = false
        }
    }
    @objc private func orderButtonTapped() {
        let alert = UIAlertController(title: nil, message: "Siparişiniz başarıyla oluşturuldu", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Tamam", style: .default)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}

extension BasketsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sepetYemekListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        let yemekDetay = viewModel.sepetYemekListesi[indexPath.row]
        
        cell.foodNameLabel.text = yemekDetay.yemek_adi!
        cell.foodCountLabel.text = "\(yemekDetay.yemek_siparis_adet!) "
        cell.foodPriceLabel.text = "\(yemekDetay.yemek_fiyat!) ₺"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekDetay.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Sil") { (action, view, completion) in
            let food = self.viewModel.sepetYemekListesi[indexPath.row]
            let alert = UIAlertController(title: "Emin misin", message: "\(food.yemek_adi!) silinsin mi", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Evet", style: .destructive) { _ in
                self.viewModel.yemegiSil(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: "AnilSezer") {
                    self.viewModel.sepetiGetir(kullaniciAdi: "AnilSezer") {
                        self.basketTableView?.reloadData()
                    }
                }
                self.viewModel.sepetYemekListesi.remove(at: indexPath.row)
                self.basketTableView?.reloadData()
                self.isBasketEmpty()
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
