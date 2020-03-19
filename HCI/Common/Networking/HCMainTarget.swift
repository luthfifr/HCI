//
//  HCMainTarget.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import Moya

enum HCMainTarget {
    case getData
}

extension HCMainTarget: TargetType {
    typealias Constants = HCConstants.Service
    var baseURL: URL {
        switch self {
        case .getData:
            return URL(string: Constants.domain) ?? URL(string: "")!
        }
    }

    var path: String {
        switch self {
        case .getData:
            return Constants.path
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getData:
            return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .getData:
            return HCSampleLoader.loadResponse(file: Constants.responseMockFileName)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
