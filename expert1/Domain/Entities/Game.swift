//
//  Game.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 27/03/25.
//

import Foundation


struct Game : Identifiable, Decodable{
    let id : Int
    var name : String
    var backgroundImage : String
    let release : String
    let rating : Double
    let description : String?
}
