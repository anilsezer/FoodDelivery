//
//  SignUpVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.11.2023.
//

import UIKit
import SnapKit
import Firebase
import IQKeyboardManagerSwift

class SignUpVC: UIViewController {
    
    let viewModel = SignUpViewModel()
    let fullNameTextField = PaddedTextField()
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
        
        let mainImageView = UIImageView(image: UIImage(named: "SignUp"))
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
        
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.layer.borderWidth = 2
        fullNameTextField.layer.cornerRadius = 15
        fullNameTextField.layer.borderColor = UIColor.mainColor?.cgColor
        fullNameTextField.autocorrectionType = .no
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
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let showPasswordButton = UIButton()
        showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showPasswordButton.tintColor = UIColor.mainColor
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        passwordTextField.addSubview(showPasswordButton)
        showPasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.layer.borderWidth = 2
        confirmPasswordTextField.layer.cornerRadius = 15
        confirmPasswordTextField.layer.borderColor = UIColor.mainColor?.cgColor
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.autocorrectionType = .no
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let showConfirmPasswordButton = UIButton()
        showConfirmPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showConfirmPasswordButton.tintColor = UIColor.mainColor
        confirmPasswordTextField.addSubview(showConfirmPasswordButton)
        showConfirmPasswordButton.addTarget(self, action: #selector(showConfirmPasswordButtonTapped), for: .touchUpInside)
        showConfirmPasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
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
        let loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.mainColor, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 15
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(signUPButton.snp.bottom).offset(15)
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
    
    @objc private func showConfirmPasswordButtonTapped() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        let imageName = confirmPasswordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        let image = UIImage(systemName: imageName)
        (confirmPasswordTextField.subviews.first as? UIButton)?.setImage(image, for: .normal)
    }
    
    @objc private func signUpButtonTapped() {
        viewModel.fullName = fullNameTextField.text
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        viewModel.confirmPassword = confirmPasswordTextField.text
        
        viewModel.signUp { success, message in
            let alertTitle: String
            let alertMessage: String
            if success {
                alertTitle = "Success :)"
                alertMessage = "You Registered Successfully!"
            } else {
                alertTitle = "Error!"
                alertMessage = message ?? "Unknown Error!"
            }
            
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let actionButton = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(actionButton)
            self.present(alert, animated: true)
        }
    }
    @objc private func loginButtonTapped() {
        let loginVC = LoginVC()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
