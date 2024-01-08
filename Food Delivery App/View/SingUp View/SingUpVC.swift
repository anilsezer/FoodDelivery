//
//  SingUpVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.11.2023.
//

import UIKit
import SnapKit

class SingUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    private func createUI() {
        
        let mainImageView = UIImageView(image: UIImage(named: "SingUp"))
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().dividedBy(2)
        }
        
        let signUPLabel = UILabel()
        signUPLabel.text = "Sign UP"
        signUPLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.addSubview(signUPLabel)
        signUPLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let fullNameTextField = UITextField()
        fullNameTextField.placeholder = " Full Name"
        fullNameTextField.layer.borderWidth = 2
        fullNameTextField.layer.cornerRadius = 15
        fullNameTextField.layer.borderColor = UIColor.mainColor?.cgColor
        view.addSubview(fullNameTextField)
        fullNameTextField.snp.makeConstraints { make in
            make.top.equalTo(signUPLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let emailTextField = UITextField()
        emailTextField.placeholder = " Email"
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderColor = UIColor.mainColor?.cgColor
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(fullNameTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = " Password"
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderColor = UIColor.mainColor?.cgColor
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = " Confirm Password"
        confirmPasswordTextField.layer.borderWidth = 2
        confirmPasswordTextField.layer.cornerRadius = 15
        confirmPasswordTextField.layer.borderColor = UIColor.mainColor?.cgColor
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let signUPButton = UIButton()
        signUPButton.setTitle("Sign Up", for: .normal)
        signUPButton.backgroundColor = UIColor.mainColor
        signUPButton.layer.cornerRadius = 15
        signUPButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.addSubview(signUPButton)
        signUPButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}
