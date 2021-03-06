//
//  UIAlertModel.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import UIKit

struct UIAlertModel {
    var title: String?
    var message: String?
    var style: UIAlertController.Style
    var actions: [UIAlertActionModel]?

    init(style: UIAlertController.Style) {
        self.style = style
    }
}

struct UIAlertActionModel {
    var title: String
    var style: UIAlertAction.Style

    static func action(title: String, style: UIAlertAction.Style = .default) -> UIAlertActionModel {
        return UIAlertActionModel(title: title, style: style)
    }
}
