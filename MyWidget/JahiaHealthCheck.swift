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

struct JahiaHealthCheck: Hashable, Codable {
    
    var duration: String
    var registeredProbes: Int
    var probes: ProbesType
    var status: String
    
    struct ProbesType: Codable {
        var Datastore: DatastoreType
        var DBConnectivity: DBConnectivityType
        
        struct DatastoreType: Codable {
            var severity: String
            var status: String
            init() {
                self.severity = "SEVERE"
                self.status = "TEST"
            }
        }
        struct DBConnectivityType: Codable {
            var severity: String
            var status: String
            init() {
                self.severity = "SEVERE"
                self.status = "TEST"
            }
        }
        
        init() {
            self.Datastore = DatastoreType.init()
            self.DBConnectivity = DBConnectivityType.init()
        }
    }
    
    init() {
        self.duration = "xxxms"
        self.registeredProbes = 0
        self.probes = ProbesType.init()
        self.status = "DEFAULT"

    }
    
    func hash(into hasher: inout Hasher) {
        return
    }
    
    static func == (lhs: JahiaHealthCheck, rhs: JahiaHealthCheck) -> Bool {
        return false
    }
}

