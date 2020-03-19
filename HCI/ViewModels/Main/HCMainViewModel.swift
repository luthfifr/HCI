//
//  HCMainViewModel.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import RxSwift

enum HCMainViewModelEvent: Equatable {
    case getData
    case getDataSuccess
    case getDataFailure(_ error: HCServiceError?)

    static func == (lhs: HCMainViewModelEvent, rhs: HCMainViewModelEvent) -> Bool {
        switch (lhs, rhs) {
        case (getData, getData),
             (getDataSuccess, getDataSuccess),
             (getDataFailure, getDataFailure):
            return true
        default: return false
        }
    }
}

protocol HCMainViewModelType {
    var uiEvents: PublishSubject<HCMainViewModelEvent> { get }
    var viewModelEvents: PublishSubject<HCMainViewModelEvent> { get }
    var responseModel: HCMainDataModel? { get }
    var isOnline: Bool { get }
}

final class HCMainViewModel: HCMainViewModelType {
    private let disposeBag = DisposeBag()
    private let service: HCMainService!

    let uiEvents = PublishSubject<HCMainViewModelEvent>()
    let viewModelEvents = PublishSubject<HCMainViewModelEvent>()
    var responseModel: HCMainDataModel? {
        didSet {
            self.uiEvents.onNext(.getDataSuccess)
        }
    }
    var isOnline = false

    init() {
        self.service = HCMainService()
        setupEvents()
    }

    init(service: HCMainService) {
        self.service = service
        setupEvents()
    }
}

// MARK: - Private methods
extension HCMainViewModel {
    private func setupEvents() {
        viewModelEvents.subscribe(onNext: { [weak self] event in
            guard let `self` = self else { return }
            switch event {
            case .getData:
                self.getData()
            default: break
            }
        }).disposed(by: disposeBag)
    }

    private func getData() {
        isOnline = HCReachability.shared.isNetworkAvailable
        if isOnline {
            service
                .getData()
                .asObservable()
                .subscribe(onNext: { [weak self] event in
                    guard let `self` = self else { return }
                    switch event {
                    case .succeeded(let model):
                        self.responseModel = model
                    case .failed(let error):
                        self.uiEvents.onNext(.getDataFailure(error))
                    case .waiting: break
                    }
                }).disposed(by: disposeBag)
        } else {
            let responseData = HCSampleLoader.loadResponse(file: HCConstants.Service.responseMockFileName)
            if let responseStr = String(data: responseData, encoding: .utf8),
                let model = HCMainDataModel.deserialize(from: responseStr) {
                self.responseModel = model
            }
        }
    }
}
