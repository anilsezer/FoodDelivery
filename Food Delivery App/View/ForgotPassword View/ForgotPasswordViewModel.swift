//
//  ForgotPasswordViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 30.01.2024.
//

import UIKit
import Firebase

class ForgotPasswordViewModel {
    
    var email: String?
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    func sendResetEmail() {
        guard let email = email, !email.isEmpty else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.onFailure?(error.localizedDescription)
            } else {
                self?.onSuccess?()
            }
        }
    }
}
