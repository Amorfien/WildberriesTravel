//
//  NetworkService.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 13.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFlights(_ startLocationCode: StartLocationCode, completion: @escaping (FlightsModel) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    private func fetchDataFromCurl(_ startLocationCode: StartLocationCode, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: "https://vmeste.wildberries.ru/api/avia-service/twirp/aviaapijsonrpcv1.WebAviaService/GetCheap"),
              let payload = "{\"startLocationCode\": \"\(startLocationCode.rawValue)\"}".data(using: .utf8) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = payload

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data else { print("Empty data"); return }
            completion(.success(data))


//            if let str = String(data: data, encoding: .utf8) {
//                print(str)
//            }

        }.resume()
    }
    func getFlights(_ startLocationCode: StartLocationCode, completion: @escaping (FlightsModel) -> ()) {
        fetchDataFromCurl(startLocationCode) { result in
            switch result {
            case .success(let data):
                do {
                    let flights = try JSONDecoder().decode(FlightsModel.self, from: data)
                    completion(flights)
                } catch {
                    print("decode error")
                }
            case .failure(let error): print(error)
            }
        }
    }
}
