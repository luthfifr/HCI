//
//  HCMainService.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 18/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import RxSwift
import Moya

protocol HCMainServiceType {
    func getData() -> Observable<HCNetworkEvent<HCMainDataModel>>
}

struct HCMainService: HCMainServiceType {
    private let provider: HCMoyaProvider<HCMainTarget>

    init() {
        provider = HCMoyaProvider<HCMainTarget>()
    }

    init(provider: HCMoyaProvider<HCMainTarget>) {
        self.provider = provider
    }

    func getData() -> Observable<HCNetworkEvent<HCMainDataModel>> {
        return provider.rx.request(.getData)
            .parseResponse({ (responseString: String) in
                guard var response = HCMainDataModel.deserialize(from: responseString) else {
                    var model = HCMainDataModel()
                    model.responseString = responseString
                    return model
                }

                response.status = .success
                response.responseString = responseString

                return response
            })
            .mapFailures { error in
                return .failed(error)
            }
    }
}
