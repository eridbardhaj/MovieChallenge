//
//  NetworkService.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Alamofire
import RxCocoa
import RxSwift
import ObjectMapper

class NetworkService {
    static let sharedInstance = NetworkService()
    static let baseURLString = "https://api.trakt.tv/"
}

extension NetworkService {
    class func rx_response<T: RESTTargetType>(request: T) -> Observable<T.Response> {
        return sharedInstance.rx_response(request)
    }
    
    func rx_response<T: RESTTargetType>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = Alamofire.request(request)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        guard let object = response.result.value, let httpResponse = response.response else {
                            observer.onError(Error.Custom("Request is not successful"))
                            
                            return
                        }
                        do {
                            let paginationResponse = try request.responseFromObject(object, URLResponse: httpResponse)
                            observer.onNext(paginationResponse)
                            observer.onCompleted()
                        } catch {
                            observer.onError(Error.Custom("Could not map the object"))
                        }
                    } else {
                        guard let error = response.result.error else {
                            observer.onError(Error.Custom("Request is failing"))
                            
                            return
                        }
                        
                        observer.onError(error)
                    }
                })
            return AnonymousDisposable {
                task.cancel()
            }
        }
    }
}
