//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Core
import Combine
import Foundation

public struct FavoriteRepository<FavoriteLocalDataSource: LocaleDataSource, Transformer: Mapper>: Repository
where
    FavoriteLocalDataSource.Request == Int,
    FavoriteLocalDataSource.Response == MovieEntity,
    Transformer.Domain == [Movie],
    Transformer.Entity == [MovieEntity],
    Transformer.Request == Any,
    Transformer.Response == Any {
    
    
    public typealias Request = Any
    public typealias Response = [Movie]
    
    private let _localeDataSource: FavoriteLocalDataSource
    private let _mapper: Transformer
    
    public init(localDataSource: FavoriteLocalDataSource, mapper: Transformer) {
        _mapper = mapper
        _localeDataSource = localDataSource
    }
    
    public func execute(request: Any?) -> AnyPublisher<[Movie], Error> {
        return _localeDataSource.list()
            .map{ _mapper.transformEntitiesToDomains(entity: $0) }
            .eraseToAnyPublisher()
            
    }
}
