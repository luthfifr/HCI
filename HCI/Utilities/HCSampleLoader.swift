//
//  HCSampleLoader.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation

struct HCSampleLoader {
    static func loadResponse(file: String) -> Data {
        return loadResponse(file: file, bundle: Bundle.main)
    }

    private static func loadResponse(file: String, bundle: Bundle) -> Data {
        guard let url = bundle.url(forResource: file, withExtension: "json"),
            let data = try? Data(contentsOf: url) else { return Data() }

        return data
    }
}
