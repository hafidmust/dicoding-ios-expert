//
//  GameDetail.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 28/03/25.
//

struct GameDetail : Identifiable, Decodable {
    let id : Int
    let name : String
    let released : String
    let backgroundImage : String
    let rating : Double
    let description : String
}
