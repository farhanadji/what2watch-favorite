//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Foundation
import Combine
import Core

public class FavoritePresenter<FavoriteUseCase: UseCase, UpdateFavoriteUseCase: UseCase>: ObservableObject
where
    FavoriteUseCase.Request == Any, FavoriteUseCase.Response == [Movie],
    UpdateFavoriteUseCase.Request == Int, UpdateFavoriteUseCase.Response == Bool
{
    private var cancellables: Set<AnyCancellable> = []
    private let _favoriteUseCase: FavoriteUseCase
    private let _updateFavoriteUseCase: UpdateFavoriteUseCase
    
    @Published public var favoriteLists: [Movie] = []
    @Published public var state: State = .idle
    @Published public var errorMessage: String = ""
    
    public init(favoriteUseCase: FavoriteUseCase, updateFavoriteUseCase: UpdateFavoriteUseCase) {
        _favoriteUseCase = favoriteUseCase
        _updateFavoriteUseCase = updateFavoriteUseCase
    }
    
    public func getFavoriteMovies() {
        state = .loading
        _favoriteUseCase.execute(request: nil)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    print("GET favorite finished") //FOR LOG PURPOSES
                }
            } receiveValue: { favoriteMovies in
                if favoriteMovies.isEmpty {
                    self.state = .empty
                } else {
                    self.favoriteLists = favoriteMovies
                    self.state = .loaded
                }
            }
            .store(in: &cancellables)
    }
    
    public func removeMovie(movieId: Int) {
        _updateFavoriteUseCase.execute(request: movieId)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.errorMessage = ""
                }
            } receiveValue: { _ in
                self.getFavoriteMovies()
            }
            .store(in: &cancellables)
        
    }
}
