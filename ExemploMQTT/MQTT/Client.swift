//
//  Client.swift
//  ExemploMQTT
//
//  Created by João Vitor Duarte Mariucio on 08/11/19.
//  Copyright © 2019 João Duarte. All rights reserved.
//

import Foundation

class Client {
    
    var id: String
    var host: String
    var port: UInt16
    var username: String
    var password: String
    
    init(id: String, host: String, port: UInt16, username: String, password: String){
        self.id = id
        self.host = host
        self.port = port
        self.username = username
        self.password = password
    }
}
