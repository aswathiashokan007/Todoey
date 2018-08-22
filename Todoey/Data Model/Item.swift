//
//  Item.swift
//  Todoey
//
//  Created by IOS Developer on 22/08/18.
//  Copyright © 2018 Softland India Limited. All rights reserved.
//

import Foundation

class Item: Codable{ //Encodable ,Decodable = Codable
    
    var title : String = ""
    
    var done  : Bool   = false
}
