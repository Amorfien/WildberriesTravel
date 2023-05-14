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
//    let endDate: EndDate
    let startLocationCode: StartLocationCode
    let endLocationCode: String
    let startCity: String//StartCity
    let endCity: String
    let serviceClass: String//ServiceClass
    let seats: [Seat]
    let price: Int
//    let searchToken: String
}

//enum EndDate: String, Codable {
//    case the000101010000000000UTC = "0001-01-01 00:00:00 +0000 UTC"
//}

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

//enum ServiceClass: String, Codable {
//    case economy = "ECONOMY"
//}

enum StartLocationCode: String, Codable {
    case led = "LED"
    case aer = "AER"
    case mow = "MOW"
    case msq = "MSQ"
}
