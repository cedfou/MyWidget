//
//  ContentView.swift
//  MyWidget
//
//  Created by Cedric Fourneau on 14/11/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network

    /*
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    */
    
    func getColor(_ statusEnum: Status?) -> Color {
        var color: Color = Color.white
        
        switch statusEnum {
            case .GREEN:
            color = Color.green
            case .YELLOW:
                color = Color.yellow
            case .RED:
                color = Color.red
            default :
                color = Color.white
        }
        return color.opacity(0.5)
    }
    
    var body: some View {
        let status : String = network.healthchecks.status
        let duration  : String = network.healthchecks.duration
        let registeredProbes  : Int  = network.healthchecks.registeredProbes
                
        let statusEnum : Status = Status(rawValue: status) ?? Status.GREEN
        
        let _ = print("statusEnum \(statusEnum)")
        let color = getColor(statusEnum)
 
        
        ScrollView {
            Text("Jahia HealthCheck")
                .font(.title)
                .bold()

            VStack(alignment:.center) {
                Text("Jahia PROD")
                    .font(.title2)
                    .bold()

                VStack(alignment: .center) {
                    Text(duration)
                    Text("[probes="+registeredProbes.formatted()+"]")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .safeAreaPadding(10)
            .background(color)
            .cornerRadius(20)
        }
        .padding(.vertical)
        .onAppear {
            network.getHealthCheck()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}
