//
//  ViewController.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import Kingfisher
import RxSwift
    class DiscoverVC: UIViewController {

        @IBOutlet weak var yemeklerCollectionView: UICollectionView!
        
        var yemekler = [Yemekler]() {
            didSet {
                yemeklerCollectionView.reloadData()
            }
            
        }
        var viewModel = DiscoverViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
         
            yemeklerCollectionView.dataSource = self
            yemeklerCollectionView.delegate = self
            
            yemeklerCollectionView.backgroundColor = .red
            
        }
        override func viewWillAppear(_ animated: Bool) {
            viewModel.yemekleriGetir { yemekler in
                self.yemekler = yemekler!
                print(yemekler)
            }

        }
    }

    extension DiscoverVC: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return yemekler.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let yemek = yemekler[indexPath.row]
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "YemeklerCollectionViewCell", for: indexPath) as! YemeklerCollectionViewCell
            cell.foodName.text = yemek.yemek_adi
            print(yemek.yemek_adi)
            cell.foodPrice.text = "\(yemek.yemek_fiyat!) ₺"
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php") {
                DispatchQueue.main.async {
                    cell.foodImage.kf.setImage(with: url)
                }
            }
        return cell
        }
    }
