//
//  HCMainViewModelTests.swift
//  HCIUnitTests
//
//  Created by Luthfi Fathur Rahman on 19/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import XCTest
import RxSwift

@testable import HCI

final class HCMainViewModelTests: XCTestCase {
    private var viewModel: HCMainViewModel!
    private var service: HCMainService!
    private var fakeProvider: HCMockRxMoyaProvider<HCMainTarget>!

    let disposeBag = DisposeBag()

    override func setUp() {
        fakeProvider = HCMockRxMoyaProvider<HCMainTarget>()
        service = HCMainService(provider: fakeProvider)
        viewModel = HCMainViewModel(service: service)
    }

    func testGetDataSuccess() {
        var events: [HCMainViewModelEvent] = []

        events = HCObservableUtilities.events(from: viewModel.uiEvents.asObservable(),
                                              disposeBag: disposeBag) { [weak self] in
                                                guard let `self` = self else { return }
                                                self.viewModel
                                                    .viewModelEvents
                                                    .onNext(.getData)
                                                self.fakeProvider.statusCode.onNext(200)
        }.compactMap { $0.value.element }

        XCTAssertTrue(events.contains(.getDataSuccess))
    }

    func testGetDataFailure() {
        var events: [HCMainViewModelEvent] = []

        events = HCObservableUtilities.events(from: viewModel.uiEvents.asObservable(),
                                              disposeBag: disposeBag) { [weak self] in
                                                guard let `self` = self else { return }
                                                self.viewModel
                                                    .viewModelEvents
                                                    .onNext(.getData)
                                                self.fakeProvider.statusCode.onNext(404)
        }.compactMap { $0.value.element }

        XCTAssertTrue(events.contains(.getDataFailure(nil)))
    }

    func testReachability() {
        viewModel.viewModelEvents.onNext(.getData)
        XCTAssertTrue(viewModel.isOnline)
    }

}
