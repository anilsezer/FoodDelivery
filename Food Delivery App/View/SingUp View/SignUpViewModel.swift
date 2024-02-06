//
//  SingUpViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.11.2023.
//

import Foundation
import Firebase

class SignUpViewModel {
    
    var fullName: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    func signUp(completion: @escaping (Bool, String?) -> Void) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty,
              let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            completion(false, "Missing field data!")
            return
        }
        
        if password != confirmPassword {
            completion(false, "Passwords Do Not Match.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
}
