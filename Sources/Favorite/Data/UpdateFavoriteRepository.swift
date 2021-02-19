//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Core
import Combine
import Foundation

public struct UpdateFavoriteRepository<FavoriteLocalDataSource: LocaleDataSource>: Repository where
    FavoriteLocalDataSource.Request == Int, FavoriteLocalDataSource.Response == MovieEntity {
    
    public typealias Request = Int
    public typealias Response = Bool
    
    private let _localeDataSource: FavoriteLocalDataSource
    
    public init(localDataSource: FavoriteLocalDataSource) {
        _localeDataSource = localDataSource
    }
    
    public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.update(id: request ?? 0)
            .eraseToAnyPublisher()
    }
    
}
