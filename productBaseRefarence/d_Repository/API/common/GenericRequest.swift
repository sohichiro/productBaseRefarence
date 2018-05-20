//
//  GenericRequest.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/20.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

struct GenericRequest<EndPoint: EndpointDefinision> {
    fileprivate let endPoint: EndPoint
    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }
}

extension GenericRequest: Request {
    typealias Response = EndPoint.Response.Result
    
    var baseURL: URL {
        return endPoint.environment.url(forPath: "")
    }
    
    var method: HTTPMethod {
        return endPoint.method
    }
    
    var path: String {
        return endPoint.path
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> EndPoint.Response.Result {
        guard let jsonObj = object as? EndPoint.Response.JSON else {
            fatalError()
        }
        
        return try EndPoint.Response.init(json: jsonObj).result
    }
}

struct GenericAPIClient {
    fileprivate static func request<Endpoint: EndpointDefinision>(_ endpoint:Endpoint) -> Single<Endpoint.Response.Result> {
        return Single.create(subscribe: { (observer) -> Disposable in
            let request = GenericRequest.init(endPoint: endpoint)
            let task = Session.send(request,
                                    callbackQueue: nil,
                                    handler: { (result) in
                                        switch result {
                                        case .success(let response):
                                            observer(.success(response))
                                        case .failure(let error):
                                            observer(.error(error))
                                        }
                                        
                                        
            })
            
            return Disposables.create {
                task?.cancel()
            }
        })
    }
}

public final class GlobalStream<T> {
    fileprivate let subject = PublishSubject<T>.init()
    
    func publish(_ element: T) {
        subject.onNext(element)
    }
}

extension GlobalStream: ObservableType {
    public typealias E = T
    
    public func subscribe<O>(_ observer: O) -> Disposable where O : ObserverType, T == O.E {
        return subject.retry().subscribe(observer)
    }
}

public extension Observable {
    func branch(to globalStream: GlobalStream<E>) -> Observable<E> {
        return flatMap({ (element) -> Observable<E> in
            globalStream.publish(element)
            return Observable.just(element)
        })
    }
}
