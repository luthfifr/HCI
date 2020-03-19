//
//  HCReachability.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import Reachability
import RxSwift
import RxOptional

final class HCReachability {
    private let reachability = Reachability()
    private var reachabilityStatus: Reachability.Connection = .cellular
    private let disposeBag = DisposeBag()

    static let shared = HCReachability()

    var isNetworkAvailable: Bool {
        return reachabilityStatus != .none
    }

    func startMonitoring() {
        guard let reachability = reachability else { return }

        NotificationCenter
            .default
            .rx
            .notification(Notification.Name.reachabilityChanged,
                          object: reachability)
            .asObservable()
            .subscribe(onNext: { [weak self] notif in
                guard let `self` = self else { return }
                self.reachabilityChanged(notification: notif)
            }).disposed(by: disposeBag)

        do {
            try reachability.startNotifier()
        } catch { }
    }

    func stopMonitoring() {
        guard let reachability = reachability else { return }

        reachability.stopNotifier()

        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }

    @objc private func reachabilityChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }

        reachabilityStatus = reachability.connection
    }
}
