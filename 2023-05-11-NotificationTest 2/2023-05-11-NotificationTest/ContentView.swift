//
//  ContentView.swift
//  2023-05-11-NotificationTest
//
//  Created by Leigh Jin on 5/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("authorize notification") {
                //add code here
                NotificationManager.instance.requestAuthorization()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            Button("schedule notification") {
                //add code here
                NotificationManager.instance.scheduleNotification()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
