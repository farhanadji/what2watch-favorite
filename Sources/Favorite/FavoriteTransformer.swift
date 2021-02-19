//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Core

public struct FavoriteTransformer: Mapper {
 
    public typealias Response = Any

    public typealias Request = Any

    public typealias Entity = [MovieEntity]

    public typealias Domain = [Movie]
    
    public init() {}
    
    public func transformResponsesToDomains(response: Any) -> [Movie] {
        fatalError()
    }
    
    public func transformEntitiesToDomains(entity: [MovieEntity]) -> [Movie] {
        return entity.map { result in
            return Movie(
                id: result.id,
                backdropPath: result.backdropPath,
                title: result.title,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate)        }
    }
    
    public func transformDomainToEntity(domain: [Movie]) -> [MovieEntity] {
        fatalError()
    }

}
