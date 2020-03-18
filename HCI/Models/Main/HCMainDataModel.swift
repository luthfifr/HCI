//
//  HCMainDataModel.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import HandyJSON

struct HCMainDataModel: HandyJSON {
    var data: [HCSectionDataModel]?

    struct HCSectionDataModel: HandyJSON {
        var section: String?
        var sectionTitle: String?
        var items: [HCItemsDataModel]?

        mutating func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.sectionTitle <-- "section_title"
        }
    }

    struct HCItemsDataModel: HandyJSON {
        var name: String?
        var image: String?
        var link: String?

        mutating func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.name <-- "article_title"
            mapper <<<
                self.name <-- "product_name"
            mapper <<<
                self.image <-- "article_image"
            mapper <<<
                self.image <-- "product_image"
        }
    }
}
