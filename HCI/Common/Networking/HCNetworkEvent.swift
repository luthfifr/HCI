//
//  HCNetworkEvent.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum HCNetworkEvent<ResponseType> {
    case waiting
    case succeeded(ResponseType)
    case failed(HCServiceError)
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    func parseResponse<T>(_ parse: @escaping (String) throws -> T) -> Observable<HCNetworkEvent<T>> {
        return parseResponse({ (response: Response) in
            let responseString = String(data: response.data, encoding: String.Encoding.utf8)!

            return try parse(responseString)
        })
    }

    func parseDataResponse<T>(_ parse: @escaping (Data) throws -> T) -> Observable<HCNetworkEvent<T>> {
        return parseResponse({ (response: Response) in
            return try parse(response.data)
        })
    }

    func parseResponse<T>(_ parse: @escaping (Response) throws -> T) -> Observable<HCNetworkEvent<T>> {
        return self
            .map { response -> HCNetworkEvent<T> in
                if response.is2xx() {
                    do {
                        return try .succeeded(parse(response))
                    } catch let error {
                        var serviceError = HCServiceError()
                        serviceError.responseString = error.localizedDescription

                        return .failed(serviceError)
                    }
                } else {
                    guard let responseString = String(data: response.data, encoding: String.Encoding.utf8) else {
                        return .failed(HCServiceError())
                    }

                    var serviceError = HCServiceError()
                    serviceError.status = .failure
                    serviceError.responseString = responseString

                    return .failed(serviceError)
                }
            }
            .asObservable()
            .startWith(.waiting)
    }
}

extension Observable where Element == HCNetworkEvent<Any> {
    func mapFailures<T>(_ failure: @escaping (HCServiceError) -> HCNetworkEvent<T>) -> Observable<HCNetworkEvent<T>> {
        return self
            .map { event -> HCNetworkEvent<T> in
                switch event {
                case .succeeded(let val):
                    guard let tval = val as? T else {
                        let serviceError = HCServiceError()
                        return .failed(serviceError)
                    }

                    return .succeeded(tval)

                case .waiting:
                    return .waiting

                case .failed(let error):
                    return failure(error)
                }
            }
    }
}

extension HCNetworkEvent: Equatable {
    public static func == (lhs: HCNetworkEvent, rhs: HCNetworkEvent) -> Bool {
        switch (lhs, rhs) {
        case (.waiting, .waiting):
            return true

        case (.succeeded, .succeeded):
            return true

        case (.failed(let errorLHS), .failed(let errorRHS)):
            return errorLHS == errorRHS

        default:
            return false
        }
    }
}
