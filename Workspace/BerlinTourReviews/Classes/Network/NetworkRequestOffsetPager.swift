//
//  NetworkRequestPager.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 25/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

typealias NetworkRequestOffsetPagerBatch<T> = (entities: [T], allLoaded: Bool)

struct NetworkRequestOffsetPagerConfiguration<T> {
    let requestParameters : [String: Any]
    let pagingParamName: String?
    let countParamName: String?
    
    let batchSize: Int
    
    let mappingHandler: (Any) -> T
    let mappingQueue: DispatchQueue
    let mappingObjectListRootPath: String
    
    let requestURL: URL
}

class NetworkRequestOffsetPager<T> {
    enum DefaultParamNames: String {
        case count
        case page
    }
    
    let loadedEntities = BehaviorSubject<[T]>(value: [T]())
    let allLoaded = BehaviorSubject<Bool>(value: false)
    let isLoading = BehaviorSubject<Bool>(value: false)
    
    private let configuration: NetworkRequestOffsetPagerConfiguration<T>
    
    init(configuration: NetworkRequestOffsetPagerConfiguration<T>) {
        self.configuration = configuration
    }
    
    func loadNext() -> Observable<NetworkRequestOffsetPagerBatch<T>> {
        return Observable.create { [weak self] observer -> Disposable in
            let strongSelf = self!
            let path = strongSelf.configuration.requestURL
            let params = strongSelf.loadNextRequestParams()
            
            strongSelf.isLoading.onNext(true)
            let task = Alamofire.request(path, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
                .responseJSON(queue: strongSelf.configuration.mappingQueue) { response in
                    switch(response.result) {
                    case .success(_):
                        let batch = strongSelf.generateBatch(fromJSON:(response.value!))
                        observer.onNext(batch)
                        
                        var loadedEntities = try! strongSelf.loadedEntities.value()
                        loadedEntities.append(contentsOf: batch.entities)
                        strongSelf.loadedEntities.onNext(loadedEntities)
                        strongSelf.allLoaded.onNext(batch.allLoaded)
                        
                        observer.onCompleted()
                        break
                        
                    case .failure(_):
                        observer.onError(response.result.error!)
                        break
                    }
                    
                    strongSelf.isLoading.onNext(false)
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func reset() {
        loadedEntities.onNext([T]())
        allLoaded.onNext(false)
    }
        
    private func loadNextRequestParams() -> [String: Any] {
        let staticParams = configuration.requestParameters
        let countParamName = configuration.countParamName ?? DefaultParamNames.count.rawValue
        let count = configuration.batchSize
        
        let pageParamName = configuration.countParamName ?? DefaultParamNames.page.rawValue
        let currentPage = try! loadedEntities.value().count / count
        
        var result = staticParams
        result[countParamName] = count
        result[pageParamName] = currentPage
        return result
    }
    
    private func generateBatch(fromJSON: Any) -> NetworkRequestOffsetPagerBatch<T> {
        let jsonDict = fromJSON as! [String: Any]
        let jsonMappingList = jsonDict.valueFor(keyPath: configuration.mappingObjectListRootPath) as! [Any]
        
        var objects = [T]()
        for item in jsonMappingList {
            objects.append(configuration.mappingHandler(item))
        }
        
        let allLoaded = objects.count < configuration.batchSize
        
        return (entities: objects, allLoaded: allLoaded)
    }
}
