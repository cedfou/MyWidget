//
//  ContentView.swift
//  MyWidget
//
//  Created by Cedric Fourneau on 14/11/2023.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct Refresher: View {
    @Environment(\.refresh) private var refresh // 1
    
    var body: some View {
        VStack {
            if let refresh = refresh { // 2
                Button("Refresh") {
                    Task {
                        await refresh() // 1
                    }
                }
                .buttonStyle(GrowingButton())
            }
        }
    }
}

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
        return color
    }
    
    var body: some View {
        
        let healthcheck = network.healthchecks
        
        let status : String = healthcheck.status
        let duration : String = healthcheck.duration
        //let registeredProbes : Int = healthcheck.registeredProbes
        let statusEnum : Status = Status(rawValue: status) ?? Status.GREEN
        //let _ = print("statusEnum \(statusEnum)")
        let color : Color = getColor(statusEnum)
        
        let dBConnectivity = healthcheck.probes.DBConnectivity
        let dBConnectivitySeverity = dBConnectivity.severity
        let dBConnectivityStatus = dBConnectivity.status
        //let dBConnectivityStatusEnum : Status = Status(rawValue: dBConnectivityStatus) ?? Status.GREEN

        let datastore = healthcheck.probes.Datastore
        let datastoreSeverity = datastore.severity
        let datastoreStatus = datastore.status
        //let datastoreStatusEnum : Status = Status(rawValue: datastoreStatus) ?? Status.GREEN
        
        ScrollView {
            Text("Jahia HealthCheck")
                .font(.title)
                .bold()
        
            VStack(alignment:.leading) {
                Text("Jahia PROD (\(duration))")
                    .font(.title2)
                    .bold()
                    .padding()
                
                HStack(alignment: .bottom){
                    Text("dBConnectivity : ")
                        .font(.title3)
                        .bold()
                        //Text("[probes="+registeredProbes.formatted()+"]")
                    Text("\(dBConnectivitySeverity) (\(dBConnectivityStatus))")
                }.background(getColor(statusEnum).colorInvert())
                HStack(){
                    Text("datastore : ")
                        .font(.title3)
                        .bold()
                    Text("\(datastoreSeverity) (\(datastoreStatus))")
                }.background(getColor(statusEnum).colorInvert())
                
            }.foregroundStyle(color).colorInvert()
            .frame(maxWidth: .infinity, alignment: .center)
            .safeAreaPadding(10)
            .background(color)
            .cornerRadius(20)
            Refresher() // 1
               .refreshable {
                   print("Refresh Button clicked")
                   network.getHealthCheck() // 1
               }
            Refresher() // 2
        }
        .padding(.vertical)
        .onAppear {
            network.getHealthCheck()
        }
        .refreshable {
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
