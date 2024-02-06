//
//  LoginVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.11.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import IQKeyboardManagerSwift

class LoginVC: UIViewController {
    
    let eMailTextField = PaddedTextField()
    let passwordTextField = PaddedTextField()
    let auth = Auth.auth()
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        
        view.backgroundColor = .white
        
        let mainImageView = UIImageView(image: UIImage(named: "Login"))
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().dividedBy(2).offset(20)
        }
        
        let loginLabel = UILabel()
        loginLabel.text = "Log In"
        loginLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let eMailLabel = UILabel()
        eMailLabel.text = "E mail"
        view.addSubview(eMailLabel)
        eMailLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        eMailTextField.placeholder = "@gmail.com"
        eMailTextField.layer.borderColor = UIColor.mainColor?.cgColor
        eMailTextField.layer.cornerRadius = 15
        eMailTextField.borderWidth = 2
        eMailTextField.autocorrectionType = .no
        eMailTextField.autocapitalizationType = .none
        view.addSubview(eMailTextField)
        eMailTextField.snp.makeConstraints { make in
            make.top.equalTo(eMailLabel.snp.bottom).offset(15)
            make.left.equalTo(eMailLabel)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(eMailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        passwordTextField.placeholder = "********"
        passwordTextField.layer.borderColor = UIColor.mainColor?.cgColor
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderWidth = 2
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.left.equalTo(eMailLabel)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        let showPasswordButton = UIButton()
        showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showPasswordButton.tintColor = UIColor.mainColor
        passwordTextField.addSubview(showPasswordButton)
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        showPasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        let forgotPasswordButton = UIButton()
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.systemGray3, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        let loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 2
        loginButton.backgroundColor = .mainColor
        loginButton.layer.borderColor = UIColor.mainColor?.cgColor
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    @objc private func showPasswordButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        let image = UIImage(systemName: imageName)
        (passwordTextField.subviews.first as? UIButton)?.setImage(image, for: .normal)
    }
    
    @objc private func forgotPasswordTapped() {
        let vc = ForgotPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func loginButtonTapped() {
        
        viewModel.email = eMailTextField.text
        viewModel.password = passwordTextField.text
        
        viewModel.loginUser { success, message in
            if success {
                print("SUCCCCCCCCCCC")

            } else {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let actionButton = UIAlertAction(title: "Okay", style: .default)
                alert.addAction(actionButton)
                self.present(alert, animated: true)
            }
        }
    }
}
