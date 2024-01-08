//
//  OnboardingVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 27.12.2023.
//

import UIKit
import SnapKit

class OnboardingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    private func createUI() {
        let mainImage = UIImageView(image: UIImage(named: "Onboarding"))
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerY.equalToSuperview().dividedBy(2).offset(30)
            make.left.right.equalToSuperview()
        }
        
        let mainTitleLabel = UILabel()
        mainTitleLabel.text = "Get ready for your\n order"
        mainTitleLabel.numberOfLines = 0
        mainTitleLabel.textAlignment = .center
        mainTitleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.addSubview(mainTitleLabel)
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        
        let attributedText = NSMutableAttributedString(string: mainTitleLabel.text!)
        attributedText.addAttribute(.foregroundColor, value: UIColor.mainColor!, range: NSRange(location: 4, length: 5))
        mainTitleLabel.attributedText = attributedText
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = "Let us help you discover the best\nfood of the week"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        
        let loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        loginButton.layer.cornerRadius = 20
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sing Up", for: .normal)
        signUpButton.setTitleColor(UIColor.mainColor, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        signUpButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.cornerRadius = 15
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        signUpButton.addTarget(self, action: #selector(signUPButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func loginButtonTapped() {
        
    }
    
    @objc private func signUPButtonTapped() {
        
    }
}
