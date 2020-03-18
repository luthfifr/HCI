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
        var articleTitle: String?
        var articleImage: String?
        var productName: String?
        var productImage: String?
        var link: String?

        mutating func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.articleTitle <-- "article_title"
            mapper <<<
                self.articleImage <-- "article_image"
            mapper <<<
                self.productName <-- "product_name"
            mapper <<<
                self.productImage <-- "product_image"
        }
    }
}
