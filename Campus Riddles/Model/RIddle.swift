//
//  RIddle.swift
//  Campus Riddles
//
//  Created by Chris Carbajal on 7/27/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//

import Foundation

struct Riddle: Decodable{
    let id : Int
    let title: String
    let difficulty: Int
    let prize: String
    let levels: Int
    let description: String
    let riddlerName: String
}

struct RiddlesRepository{
    var riddles: [Riddle]
}
