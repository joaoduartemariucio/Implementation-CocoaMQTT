//
//  ViewController.swift
//  ExemploMQTT
//
//  Created by João Vitor Duarte Mariucio on 07/11/19.
//  Copyright © 2019 João Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mqttClient: MQTTClient?
    
    var label: UILabel = {
        var lbl = UILabel()
        lbl.text = "Pergunta?"
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var label1: UILabel = {
        var lbl = UILabel()
        lbl.text = "Resposta"
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(label1)
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 10),
            label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            label1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
        
        let client: Client = Client(
            id: MQTTClient.randomClient(length: 28),
            host: MQTTHostConfig.Host.host,
            port: MQTTHostConfig.Host.port,
            username: MQTTHostConfig.Host.username,
            password: MQTTHostConfig.Host.password
        )
        
        mqttClient = MQTTClient.shared(abstract: self, client: client)
        mqttClient?.connect()
    }
}

extension ViewController: MQTTAbstract {
    
    func connectionState(status: Int) {
        if status == MQTTStatus.CONECTADO {
            print("MQTT ~ Conectado ~ MQTT")
            mqttClient?.subscribe(topic: "teste/mqtt/1")
            mqttClient?.subscribe(topic: "teste/mqtt/2")
        }
    }
    
    func onMessageReceive(_ playloadString: String, topic: String) {
        if topic == "teste/mqtt/1" {
            label.text = playloadString
        }
        
        if topic == "teste/mqtt/2" {
            label1.text = playloadString
        }
    }
    
    func onMessagePublish(_ playloadString: String, topic: String) {
        if topic == "teste/mqtt/1" {
            label.text = playloadString
        }
        
        if topic == "teste/mqtt/2" {
            label1.text = playloadString
        }
    }
}

