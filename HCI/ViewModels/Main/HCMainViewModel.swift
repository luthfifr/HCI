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
    case getDataFailure

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
}

final class HCMainViewModel: HCMainViewModelType {
    private let disposeBag = DisposeBag()

    let uiEvents = PublishSubject<HCMainViewModelEvent>()
    let viewModelEvents = PublishSubject<HCMainViewModelEvent>()

    init() {
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
        //codes here
    }
}
