//
//  BasketsVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import Kingfisher
import SnapKit

class CartVC: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView?
    @IBOutlet weak var productInfoLabel: UILabel!
    
    var viewModel = CartViewModel()
    let orderButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView?.dataSource = self
        cartTableView?.delegate = self
        cartTableView?.separatorColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        
        view.addSubview(orderButton)
        orderButton.setTitle("Order Now", for: .normal)
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
        viewModel.showInCards(kullaniciAdi: "AnilSezer") { [weak self] in
            self?.cartTableView?.reloadData()
            self?.isBasketEmpty()
        }
    }
    func isBasketEmpty() {
        if viewModel.foodsInCards.isEmpty {
            viewModel.foodsInCards.removeAll()
            cartTableView?.isHidden = true
            productInfoLabel?.isHidden = false
        } else {
            productInfoLabel?.isHidden = true
            cartTableView?.isHidden = false
        }
    }
    @objc private func orderButtonTapped() {
        let alert = UIAlertController(title: nil, message: "Your order has been created successfully", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}

extension CartVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.foodsInCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! CartTableViewCell
        let yemekDetay = viewModel.foodsInCards[indexPath.row]
        
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
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let food = self.viewModel.foodsInCards[indexPath.row]
            let alert = UIAlertController(title: "Are You Sure!", message: " \(food.yemek_adi!) will delete?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                self.viewModel.deleteFoods(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: "AnilSezer") {
                    self.viewModel.showInCards(kullaniciAdi: "AnilSezer") {
                        self.cartTableView?.reloadData()
                    }
                }
                self.viewModel.foodsInCards.remove(at: indexPath.row)
                self.cartTableView?.reloadData()
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
