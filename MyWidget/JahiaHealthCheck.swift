//
//  JahiaHealthCheck.swift
//  MyWidget
//
//  Created by Cedric Fourneau on 14/11/2023.
//
/*
 {
     "duration":"1ms",
     "registeredProbes":5,
     "probes":
     {
         "Datastore":
         {
             "severity":"CRITICAL",
             "status":"GREEN"
         },
         "DBConnectivity":
         {
             "severity":"CRITICAL",
             "status":"GREEN"
         }
     },
     "status":"GREEN"
 }

 */

import Foundation

enum Status : String {
    case GREEN = "GREEN"
    case YELLOW = "YELLOW"
    case RED = "RED"
}

struct JahiaHealthCheck: Decodable {
    var duration: String
    var registeredProbes: Int
    
    struct probes: Decodable {
        struct Datastore: Decodable {
            var severity: String
            var status: String
        }
        struct DBConnectivity: Decodable {
            var severity: String
            var status: String
        }
    }
    var status: String
}
