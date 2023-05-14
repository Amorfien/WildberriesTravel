//
//  MainViewModel.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 14.05.2023.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var onStateDidChange: ((MainViewModel.State) -> Void)? { get set }
    func updateState(viewInput: MainViewModel.ViewInput, startCity: StartLocationCode)
}

final class MainViewModel: MainViewModelProtocol {
    enum State {
        case initial
        case loading(startCity: StartLocationCode)
        case loaded(flights: [Flight])
        case error(Error)
    }

    enum ViewInput {
        case changeStartCity
        case flightDidSelect(Flight)
    }

    var onStateDidChange: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func updateState(viewInput: ViewInput, startCity: StartLocationCode) {
        switch viewInput {
        case .changeStartCity:
//            state = .loading(startCity: startCity)
            print("Loading... 🗿")
            networkService.getFlights(startCity) { flightModel in
                print(flightModel.flights)
                self.state = .loaded(flights: flightModel.flights)
            }

            
        case let .flightDidSelect(flight):
            print(flight)
//            print("test2")
//            coordinator?.pushBookViewController(forBook: book)
//            print(coordinator)
        }
    }


}
