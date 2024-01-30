//
//  SingUpVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.11.2023.
//

import UIKit
import SnapKit
import Firebase

class SignUpVC: UIViewController {
    
    let passwordTextField = PaddedTextField()
    let emailTextField = PaddedTextField()
    let confirmPasswordTextField = PaddedTextField()
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    private func createUI() {
        
        view.backgroundColor = .white
        
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
        
        let fullNameTextField = PaddedTextField()
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.layer.borderWidth = 2
        fullNameTextField.layer.cornerRadius = 15
        fullNameTextField.layer.borderColor = UIColor.mainColor?.cgColor
        view.addSubview(fullNameTextField)
        fullNameTextField.snp.makeConstraints { make in
            make.top.equalTo(signUPLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        emailTextField.placeholder = "Email"
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderColor = UIColor.mainColor?.cgColor
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(fullNameTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderColor = UIColor.mainColor?.cgColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.layer.borderWidth = 2
        confirmPasswordTextField.layer.cornerRadius = 15
        confirmPasswordTextField.layer.borderColor = UIColor.mainColor?.cgColor
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.autocorrectionType = .no
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
        signUPButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUPButton)
        signUPButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func signUpButtonTapped() {
        print("Sign Up Button Tapped")
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            print("Missing field data")
            return
        }
        
        if password != confirmPassword {
            print("Passwords do not match")
            return
        }
        
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let actionButton = UIAlertAction(title: "Okay", style: .default)
                alert.addAction(actionButton)
                self.present(alert, animated: true)
            } else {
                print("User registered successfully")
            }
        }
    }
}
