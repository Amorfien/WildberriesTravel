//
//  FlightsModel.swift
//  WildberriesTravel
//
//  Created by Pavel Grigorev on 13.05.2023.
//

import Foundation

// MARK: - FlightsModel
struct FlightsModel: Codable {
    let flights: [Flight]
}

// MARK: - Flight
struct Flight: Codable {
    let startDate: String
    let endDate: String
    let startLocationCode: StartLocationCode
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let seats: [Seat]
    let price: Int
    let searchToken: String
    var isLike: Bool

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.startLocationCode = try container.decode(StartLocationCode.self, forKey: .startLocationCode)
        self.endLocationCode = try container.decode(String.self, forKey: .endLocationCode)
        self.startCity = try container.decode(String.self, forKey: .startCity)
        self.endCity = try container.decode(String.self, forKey: .endCity)
        self.serviceClass = try container.decode(String.self, forKey: .serviceClass)
        self.seats = try container.decode([Seat].self, forKey: .seats)
        self.price = try container.decode(Int.self, forKey: .price)
        self.searchToken = try container.decode(String.self, forKey: .searchToken)
        self.isLike = false
    }
}

// MARK: - Seat
struct Seat: Codable {
    let passengerType: PassengerType
    let count: Int
}

enum PassengerType: String, Codable {
    case adt = "ADT"
    case chd = "CHD"
    case inf = "INF"
}

enum StartLocationCode: String, Codable {
    case led = "LED"
    case aer = "AER"
    case mow = "MOW"
    case kzn = "KZN"
}
