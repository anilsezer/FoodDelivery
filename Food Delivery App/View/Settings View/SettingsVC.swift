//
//  OrdersViewController.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    let titleLabel = UILabel()
    let privacyButton = UIButton()
    let restorePurchase = UIButton()
    let termOfUse = UIButton()
    let rateUsButton = UIButton()
    let contactUsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        
        titleLabel.text = "Ayarlar"
        titleLabel.font = UIFont(name: "Arial Bold", size: 18)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        contactUsButton.setTitle("Contact Us", for: .normal)
        contactUsButton.layer.cornerRadius = 25
        contactUsButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        contactUsButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        contactUsButton.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        view.addSubview(contactUsButton)
        contactUsButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(55)
        }
        
        rateUsButton.setTitle("Privacy Policy", for: .normal)
        rateUsButton.layer.cornerRadius = 25
        rateUsButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        rateUsButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        rateUsButton.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        view.addSubview(rateUsButton)
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(contactUsButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(55)
        }
        
        privacyButton.setTitle("Privacy Policy", for: .normal)
        privacyButton.layer.cornerRadius = 25
        privacyButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        privacyButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        privacyButton.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(55)
        }
        
        restorePurchase.setTitle("Restore Purchases", for: .normal)
        restorePurchase.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        restorePurchase.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        restorePurchase.layer.cornerRadius = 25
        restorePurchase.addTarget(self, action: #selector(restorePurchasesTapped), for: .touchUpInside)
        view.addSubview(restorePurchase)
        restorePurchase.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(55)
        }
        
        termOfUse.setTitle("Terms of Use", for: .normal)
        termOfUse.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        termOfUse.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        termOfUse.layer.cornerRadius = 25
        termOfUse.addTarget(self, action: #selector(termsOfUseTapped), for: .touchUpInside)
        view.addSubview(termOfUse)
        termOfUse.snp.makeConstraints { make in
            make.top.equalTo(restorePurchase.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(55)
        }
    }
    
    @objc private func privacyPolicyTapped() {
        self.goURL(URL(string: "https://www.anilsezer.dev")!)
    }
    
    @objc private func termsOfUseTapped() {
        self.goURL(URL(string: "https://www.anilsezer.dev")!)
    }
    
    @objc private func restorePurchasesTapped() {
        self.goURL(URL(string: "https://www.anilsezer.dev")!)
    }
}
