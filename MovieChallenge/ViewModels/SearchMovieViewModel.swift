//
//  SearchMovieViewModel.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/26/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift

class SearchMovieViewModel<PaginationRequest: PaginationRequestType> {
    let refreshTrigger = PublishSubject<String>()
    let loadNextPageTrigger = PublishSubject<Void>()
    
    let hasNextPage = Variable<Bool>(false)
    let loading = Variable<Bool>(false)
    let elements = Variable<[MovieRequest.Search.Response.Element]>([])
    let lastLoadedPage = Variable<Int?>(nil)
    let query = Variable<String>("")
    
    let error = PublishSubject<ErrorType>()
    
    private let disposeBag = DisposeBag()
    
    init(baseRequest: MovieRequest.Search) {
        let refreshRequest = query.asObservable()
            .flatMap { query -> Observable<MovieRequest.Search> in
                return Observable.of(baseRequest.request(query, page: 1))
        }
        
        let observ = query.asObservable()
        let nextPageRequest = Observable
            .combineLatest(observ, loading.asObservable(), hasNextPage.asObservable(), lastLoadedPage.asObservable()) { $0 }
            .sample(loadNextPageTrigger)
            .flatMap { query, loading, hasNextPage, lastLoadedPage -> Observable<MovieRequest.Search> in
                if let page = lastLoadedPage where !loading && hasNextPage {
                    return Observable.of(baseRequest.request(query, page: page + 1))
                } else {
                    return Observable.empty()
                }
        }
        
        let request = Observable
            .of(refreshRequest, nextPageRequest)
            .merge()
            .shareReplay(1)
        
        let response = request
            .flatMap { [weak self] request in
                return NetworkService.rx_response(request)
                    .doOnError { [weak self] error in
                        self?.error.onNext(error)
                    }
                    .catchError { _ in Observable.empty() }
            }
            .shareReplay(1)
        
        Observable
            .of(
                request.map { _ in true },
                response.map { _ in false },
                error.map { _ in false }
            )
            .merge()
            .bindTo(loading)
            .addDisposableTo(disposeBag)
        
        Observable
            .combineLatest(request, response, elements.asObservable()) { request, response, elements in
                return request.page == 1 ? response.elements : elements + response.elements
            }
            .sample(response)
            .bindTo(elements)
            .addDisposableTo(disposeBag)
        
        response
            .withLatestFrom(request) { $1.page }
            .bindTo(lastLoadedPage)
            .addDisposableTo(disposeBag)
        
        response
            .map { $0.hasNextPage }
            .bindTo(hasNextPage)
            .addDisposableTo(disposeBag)
    }
}
