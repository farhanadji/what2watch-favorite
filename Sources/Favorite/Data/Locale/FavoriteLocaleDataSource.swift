//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Core
import Combine
import RealmSwift

public struct FavoriteLocaleDataSource: LocaleDataSource {
    public typealias Request = Int
    public typealias Response = MovieEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list() -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            let movies: Results<MovieEntity> = {
                _realm.objects(MovieEntity.self)
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movies.toArray(ofType: MovieEntity.self)))
        }
        .eraseToAnyPublisher()
    }
    
    public func add(entities: MovieEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func find(id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func update(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.delete(_realm.objects(MovieEntity.self).filter("id=%@", id))
                }
                completion(.success(true))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }
        .eraseToAnyPublisher()
    }
}
