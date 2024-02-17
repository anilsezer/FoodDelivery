//
//  LoginViewModel.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.11.2023.
//

import Foundation
import Firebase

class LoginViewModel {
    var email: String?
    var password: String?
    
    func loginUser(completion: @escaping (Bool, String?) -> Void) {
        guard let email = email, !email.isEmpty,
              let password  = password, !password.isEmpty else {
            completion(false, "Email or Password Cannot be Empty.")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
}
