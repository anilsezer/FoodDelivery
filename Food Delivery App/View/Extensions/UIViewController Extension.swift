//
//  UIViewController Extension.swift
//  Food Delivery App
//
//  Created by Anıl Sezer on 22.10.2023.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    func goURL(_ url: URL) {
        let config = SFSafariViewController.Configuration()
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
}
