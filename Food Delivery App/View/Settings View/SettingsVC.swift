//
//  OrdersViewController.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 11.10.2023.
//

import UIKit
import SnapKit
import Firebase

class SettingsVC: UIViewController {
    
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = UIFont(name: "Arial Bold", size: 18)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let contactUsButton = UIButton()
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
        
        let rateUsButton = UIButton()
        rateUsButton.setTitle("Rate Us", for: .normal)
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
        
        let privacyButton = UIButton()
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
        
        let restorePurchase = UIButton()
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
        
        let termOfUse = UIButton()
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
        
        let signOutButton = UIButton()
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        signOutButton.titleLabel?.font = UIFont(name: "Arial Bold", size: 22)
        signOutButton.layer.cornerRadius = 25
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.top.equalTo(termOfUse.snp.bottom).offset(16)
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
    
    @objc private func signOutButtonTapped() {
        do {
            try auth.signOut()
            let vc = OnboardingVC()
            navigationController?.pushViewController(vc, animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
