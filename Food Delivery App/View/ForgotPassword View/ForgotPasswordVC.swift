//
//  ForgotPasswordVC.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 30.01.2024.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import SnapKit

class ForgotPasswordVC: UIViewController {
    
    let emailTextField = PaddedTextField()
    let viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        setupBindings()
    }
    
    private func createUI() {
        view.backgroundColor = .white
        
        let mainImageView = UIImageView(image: UIImage(named: "Password"))
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerY.equalToSuperview().dividedBy(2)
            make.left.right.equalToSuperview().inset(20)
        }
        
        let resetPasswordLabel = UILabel()
        resetPasswordLabel.text = "Reset Password"
        resetPasswordLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.addSubview(resetPasswordLabel)
        resetPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        emailTextField.placeholder = "Enter Your Email"
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderColor = UIColor.mainColor?.cgColor
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let resetPasswordButton = UIButton(type: .system)
        resetPasswordButton.setTitle("Send Reset Email", for: .normal)
        resetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        resetPasswordButton.backgroundColor = UIColor.mainColor
        resetPasswordButton.setTitleColor(.white, for: .normal)
        resetPasswordButton.layer.cornerRadius = 15
        resetPasswordButton.addTarget(self, action: #selector(sendResetEmailButtonTapped), for: .touchUpInside)
        view.addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        let loginButton = UIButton()
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.setTitleColor(UIColor.mainColor, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.7803921569, blue: 0.1921568627, alpha: 1)
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 15
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupBindings() {
        viewModel.onSuccess = { [weak self] in
            let alertController = UIAlertController(
                title: "Success",
                message: "Password reset email has been sent successfully.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self?.redirectToOnboardingVC()
                
            }
            alertController.addAction(okAction)
            self?.present(alertController, animated: true, completion: nil)
        }
        
        viewModel.onFailure = { [weak self] errorMessage in
            print("Error sending reset email: \(errorMessage)")
        }
    }
    private func redirectToOnboardingVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewControllerID") as! UIViewController
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
    @objc private func sendResetEmailButtonTapped() {
        viewModel.email = emailTextField.text
        viewModel.sendResetEmail()
    }
    
    @objc private func loginButtonTapped() {
        let loginVC = LoginVC()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
