//
//  ContentView.swift
//  iParkApp
//
//  Created by Peter Deyi on 5/3/23.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @StateObject var parkingFinder = ParkingFinder()
    var body: some View {
        ZStack(alignment: .top) {
            // background
            Color.black.ignoresSafeArea()
            // map view
            Map(
                coordinateRegion: $parkingFinder.region,
                annotationItems: parkingFinder.spots) { spot in
                MapAnnotation(
                    coordinate: spot.location,
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    Button(action: {
                        parkingFinder.selectedPlace = spot
                    }, label: {
                        SpotAnnotationView(
                            fee: "\(Int(spot.fee))",
                            selected: spot.id == parkingFinder.selectedPlace?.id)
                    })
                }
            }
            .cornerRadius(55)
            .edgesIgnoringSafeArea(.vertical)
            .offset(y: 0)
            // Use (y: -70) if you add address bar
            VStack {
                // top navigation
                TopNavigationView()
                Spacer()
                // parking card view
                ParkingCardView(parkingPlace: parkingFinder.selectedPlace ?? parkingFinder.spots[0])
                    .offset(y: -30)
                    .onTapGesture {
                        parkingFinder.showDetail = true
                    }
                // search view
               // SearchView()
            }
            .padding(.horizontal)
            
            if parkingFinder.showDetail {
                // parking detail view when click on card
                ParkingDetailView(
                    parkingFinder: parkingFinder,
                    region: MKCoordinateRegion(
                        center: parkingFinder.selectedPlace?.location ?? parkingFinder.spots[0].location,
                        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)))
            }
        }
        .onAppear {
            parkingFinder.selectedPlace = parkingFinder.spots[0]
        }
    }
}
// color
extension Color {
    static let darkColor = Color.init(red: 46/255, green: 45/255, blue: 45/255)
    static let lightColor = Color.init(red: 254/255, green: 254/255, blue: 254/255)
    static let yellowColor = Color.init(red: 245/255, green: 210/255, blue: 49/255)
}

extension UIScreen {
   static let screenWidth   = UIScreen.main.bounds.size.width
   static let screenHeight  = UIScreen.main.bounds.size.height
   static let screenSize    = UIScreen.main.bounds.size
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
