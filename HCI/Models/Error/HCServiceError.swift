//
//  HCServiceError.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import HandyJSON
import Moya

enum HCResponseStatus: String {
    case success
    case failure
}

struct HCServiceError: HandyJSON {
    var responseString: String?
    var status: HCResponseStatus
    var error: MoyaError?

    init() {
        status = .failure
        error = nil
        responseString = nil
    }
}

extension HCServiceError: Equatable {
    public static func == (lhs: HCServiceError, rhs: HCServiceError) -> Bool {
        return lhs.responseString == rhs.responseString &&
            lhs.status == rhs.status
    }
}
