//
//  HCConstants.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import UIKit

struct HCConstants {
    struct TabBar {
        static let barTintColor = UIColor(red: 83/255, green: 186/255, blue: 210/255, alpha: 1.0)
        static let titleColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    struct MainVC {
        static let backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        static let title = "Home Credit Indonesia"
        static let articleSectionRawValue = "articles"
        static let productSectionRawValue = "products"
        static let artileTitleDefaultValue = "Article title"
        static let productNameDefaultValue = "Product Name"
    }
}
