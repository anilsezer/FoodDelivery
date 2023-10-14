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
        
        yemeklerCollectionView.backgroundColor = .red
        
        let layout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
           layout.minimumInteritemSpacing = 10
           layout.minimumLineSpacing = 10
           layout.scrollDirection = .vertical
           
           let cellWidth = (yemeklerCollectionView.frame.width - 30) / 2
           layout.itemSize = CGSize(width: cellWidth, height: 200)
           
           yemeklerCollectionView.collectionViewLayout = layout
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yemekleriGetir { yemekler in
            self.yemekler = yemekler!
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
        cell.foodPrice.text = "\(yemek.yemek_fiyat!) ₺"
        cell.foodImage.backgroundColor = .darkGray
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }
        }
        return cell
    }
}

