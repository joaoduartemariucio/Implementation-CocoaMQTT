//
//  MQTTConfig.swift
//  ExemploMQTT
//
//  Created by João Vitor Duarte Mariucio on 07/11/19.
//  Copyright © 2019 João Duarte. All rights reserved.
//

import Foundation

struct MQTTHostConfig {
    
    //I set my host this way, so that if I have more than one MQTT host to connect to, the framework will be ready.
    
    struct Host {
        static var host: String = "yourHostAdress"
        static var port: UInt16  = 8884
        static var username = "yourUserName"
        static var password: String = "yourPassaword"
    }
}
