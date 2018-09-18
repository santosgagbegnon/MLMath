//
//  WolframAlphaStructs.swift
//  MLMath
//
//  Created by Santos on 2018-09-15.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
struct Pod : Decodable {
    let title : String?
    let scanner : String?
    let id : String?
    let position : Int?
    let error : Bool?
    let numsubpods : Int?
    let subpods : [Subpod]?
}

struct Subpod : Decodable {
    let title : String?
    let plaintext : String?
    let minput : String?
}
