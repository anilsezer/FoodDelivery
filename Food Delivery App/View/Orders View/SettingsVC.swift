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
        
        titleLabel.text = "Settings"
        titleLabel.font = UIFont(name: "Arial", size: 32)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        contactUsButton.setTitle("Contact Us", for: .normal)
        contactUsButton.layer.cornerRadius = 25
        contactUsButton.backgroundColor = .darkGray
        contactUsButton.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        view.addSubview(contactUsButton)
        contactUsButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(60)
        }
        
        rateUsButton.setTitle("Privacy Policy", for: .normal)
        rateUsButton.layer.cornerRadius = 25
        rateUsButton.backgroundColor = .darkGray
        rateUsButton.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        view.addSubview(rateUsButton)
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(contactUsButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(60)
        }
        
        privacyButton.setTitle("Privacy Policy", for: .normal)
        privacyButton.layer.cornerRadius = 25
        privacyButton.backgroundColor = .darkGray
        privacyButton.addTarget(self, action: #selector(privacyPolicyTapped), for: .touchUpInside)
        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(60)
        }
        
        restorePurchase.setTitle("Restore Purchases", for: .normal)
        restorePurchase.backgroundColor = .darkGray
        restorePurchase.layer.cornerRadius = 25
        restorePurchase.addTarget(self, action: #selector(restorePurchasesTapped), for: .touchUpInside)
        view.addSubview(restorePurchase)
        restorePurchase.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(60)
        }
        
        termOfUse.setTitle("Terms of Use", for: .normal)
        termOfUse.backgroundColor = .darkGray
        termOfUse.layer.cornerRadius = 25
        termOfUse.addTarget(self, action: #selector(termsOfUseTapped), for: .touchUpInside)
        view.addSubview(termOfUse)
        termOfUse.snp.makeConstraints { make in
            make.top.equalTo(restorePurchase.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(60)
        }
    }
    
    @objc private func privacyPolicyTapped() {
        
    }
    
    @objc private func termsOfUseTapped() {
        
    }
    
    @objc private func restorePurchasesTapped() {
        
    }
}
