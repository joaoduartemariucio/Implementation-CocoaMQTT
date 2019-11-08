//
//  MQTTManager.swift
//  ExemploMQTT
//
//  Created by João Vitor Duarte Mariucio on 07/11/19.
//  Copyright © 2019 João Duarte. All rights reserved.
//

import Foundation
import CocoaMQTT

class MQTTClient {
    
    private var mqtt: CocoaMQTT?
    private var client: Client!
    private weak var abstract: MQTTAbstract!
    
    private static let _shared = MQTTClient()
    
    class func shared(abstract: MQTTAbstract, client: Client) -> MQTTClient {
        _shared.client = client
        _shared.abstract = abstract
        _shared.setupMqtt()
        return _shared
    }
    
    func setupMqtt(){
        mqtt = CocoaMQTT(clientID: client.id, host: client.host, port: client.port)
        mqtt?.username  = client.username
        mqtt?.password  = client.password
        mqtt?.keepAlive = 60
        mqtt?.delegate = self
    }
    
    func connect() {
        if mqtt?.connState != .connected && mqtt?.connState != .connecting {
            mqtt?.connect()
        }
    }
    
    func subscribe(topic: String){
        mqtt?.subscribe(topic, qos: .qos2)
    }
    
    func unsubscribe(topic: String){
        mqtt?.unsubscribe(topic)
    }
    
    func publish(topic: String ,with message: String){
        mqtt?.publish(topic, withString: message, qos: .qos2)
    }
    
    class func randomClient(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension MQTTClient: CocoaMQTTDelegate {

    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        abstract.connectionState(status: MQTTStatus.CONECTADO)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("MQTT ~ Publish Message ~ MQTT")
        if let playloadString = message.string {
            abstract.onMessagePublish(playloadString, topic: message.topic)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("MQTT ~ Publish Ack ~ MQTT")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print("MQTT ~ Receive Message ~ MQTT")
        if let playloadString = message.string {
            print("MQTT ~ Message: \(playloadString) ~ MQTT")
            abstract.onMessageReceive(playloadString, topic: message.topic)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
        print("MQTT ~ Subscribe Topic ~ MQTT")
        print("MQTT ~ \(topics)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("MQTT ~ Unsubscribe Topic ~ MQTT")
        print("MQTT ~ \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("MQTT ~ Poing ~ MQTT")
        print("MQTT ~ \(mqtt)")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("MQTT ~ Receive Poing ~ MQTT")
        print("MQTT ~ \(mqtt)")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("MQTT ~ Desconectado ~ MQTT")
        abstract.connectionState(status: MQTTStatus.DESCONECTADO)
    }
}


protocol MQTTAbstract: class {
    
    func connectionState(status: Int)
    func onMessageReceive(_ playloadString: String, topic: String)
    func onMessagePublish(_ playloadString: String, topic: String)
}

struct MQTTStatus {
    
    static let CONECTADO: Int = 1
    static let DESCONECTADO: Int = 2
}
