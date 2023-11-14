//
//  Network.swift
//  MyWidget
//
//  Created by Cedric Fourneau on 14/11/2023.
//


//http://jahia-private-1.spw.wallonie.be/healthcheck?token=OGKLMRSDAipviaipIEiieYvuL

import SwiftUI


class Network: ObservableObject {

    @Published var healthchecks: JahiaHealthCheck = JahiaHealthCheck.init(duration: "0ms", registeredProbes: 0, status: "DEFAULT")

    
    func getHealthCheck() {
        guard let url = URL(string: "https://geoportail.wallonie.be/healthcheck?token=OGKLMRSDAipviaipIEiieYvuL", encodingInvalidCharacters: true ) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedChecks = try JSONDecoder().decode(JahiaHealthCheck.self, from: data)
                        self.healthchecks = decodedChecks
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
