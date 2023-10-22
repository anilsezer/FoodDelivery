//
//  ViewController.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import Kingfisher

class DiscoverVC: UIViewController {
    
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var yemekler = [Yemekler]() {
        didSet {
            yemeklerCollectionView.reloadData()
            viewModel.tamListe = yemekler
        }
        
    }
    var viewModel = DiscoverViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        
        let cellWidth = (yemeklerCollectionView.frame.width - 30) / 2
        layout.itemSize = CGSize(width: cellWidth, height: 200)
        
        yemeklerCollectionView.collectionViewLayout = layout
        searchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yemekleriGetir { yemekler in
            self.yemekler = yemekler!
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailPage" {
            if let yemek = sender as? Yemekler {
                let destinationVC = segue.destination as! DetailPageVC
                destinationVC.yemek = yemek
            }
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
        cell.foodImage.backgroundColor = .white
        cell.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        cell.layer.borderWidth = 2
//        cell.layer.cornerRadius = 15
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.foodImage.kf.setImage(with: url)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemekler[indexPath.row]
        
        performSegue(withIdentifier: "toDetailPage", sender: yemek)
    }
}

extension DiscoverVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText.count < 3 {
            viewModel.yemekleriGetir { yemekler in
                self.yemekler = yemekler!
            }
        }else {
            print(viewModel.ara(aramaKelimesi: searchText))
            self.yemekler = viewModel.ara(aramaKelimesi: searchText)
        }
    }
}
