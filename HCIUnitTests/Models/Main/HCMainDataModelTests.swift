//
//  HCMainDataModelSpec.swift
//  HCIUnitTests
//
//  Created by Luthfi Fathur Rahman on 19/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import XCTest

@testable import HCI

final class HCMainDataModelTests: XCTestCase {
    private lazy var responseData: HCMainDataModel = { [unowned self] in
        let response = HCSampleLoader.loadResponse(file: HCConstants.Service.responseMockFileName)
        if let responseStr = String(data: response, encoding: .utf8),
            var model = HCMainDataModel.deserialize(from: responseStr) {
            model.status = .success
            model.responseString = responseStr
            return model
        }
        return HCMainDataModel()
    }()

    func testResponseString() {
        XCTAssertNotNil(responseData.responseString)
    }

    func testStatus() {
        XCTAssertTrue(responseData.status == .success)
    }

    func testSectionTitleNotNil() {
        let sectionTitle = responseData.data?.first?.sectionTitle ?? String()
        XCTAssertNotEqual(sectionTitle, String())
    }

    func testSectionTitleValue() {
        let sectionTitle = responseData.data?.first?.sectionTitle ?? String()
        XCTAssertEqual(sectionTitle, "Our Blog")
    }

    func testArticleTitleNotNil() {
        let articleSection = responseData
            .data?.filter({ ($0.section ?? String()) == "articles"})
        let item = articleSection?.first?.items?.first
        XCTAssertNotNil(item?.articleTitle)
    }

    func testArticleTitleValue() {
        let articleSection = responseData
            .data?.filter({ ($0.section ?? String()) == "articles"})
        let item = articleSection?.first?.items?.first
        XCTAssertEqual(item?.articleTitle ?? String(), "6 Fakta Seru Home Credit Indonesia")
    }

    func testLinkValidity() {
        let articleSection = responseData
            .data?.filter({ ($0.section ?? String()) == "articles"})
        let item = articleSection?.first?.items?.first
        let canOpenURL = UIApplication.shared.canOpenURL(URL(string: item?.link ?? String())!)
        XCTAssertTrue(canOpenURL)
    }

    func testProductImageNotNil() {
        let productSection = responseData
            .data?.filter({ ($0.section ?? String()) == "products"})
        let item = productSection?.first?.items?.first
        XCTAssertNotNil(item?.productImage)
    }

    func testProductImageValue() {
        let productSection = responseData
            .data?.filter({ ($0.section ?? String()) == "products"})
        let item = productSection?.first?.items?.first
        XCTAssertEqual(item?.productImage ?? String(), "https://www.homecredit.co.id/HCID/media/images/Commodity/mobile-phone-hover-grey.png?ext=.png") //swiftlint:disable:this line_length
    }

    func testProductImageValidity() {
        let productSection = responseData
            .data?.filter({ ($0.section ?? String()) == "products"})
        let item = productSection?.first?.items?.first
        let canOpenURL = UIApplication.shared.canOpenURL(URL(string: item?.productImage ?? String())!)
        XCTAssertTrue(canOpenURL)
    }
}
