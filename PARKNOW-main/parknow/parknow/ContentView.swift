//
//  ContentView.swift
//  parknow
//
//  Created by 周雨橙 on 5/4/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var parkingFinder = ParkingFinder()
    var body: some View {
        ZStack{
            // background
            Color.white.ignoresSafeArea()
            
            //map view
            Map(coordinateRegion: $parkingFinder.region,
                annotationItems: parkingFinder.spots){ spot in
                MapAnnotation(coordinate: spot.location,
                              anchorPoint:  CGPoint(x: 0.5, y: 0.5)){
                    Button(action: {
                        parkingFinder.selectedPlace = spot
                    }, label: {
                        
                    })
                    
                }
                
            }
            VStack{
                //top navigation
                TopNavigationView()
                //parking card view
                ParkingCardView(parkingPlace: parkingFinder.selectedPlace ??
                                parkingFinder.spots[0])
                //search view
                
                
            }
            if parkingFinder.showDetail{
                //parking detail view when click on card
            }
        }
        .ignoresSafeArea()
    }
}
struct TopNavigationView: View{
    var body: some View{
        HStack{
            VStack{
                Image(systemName: "minus")
                
                Image(systemName: "minus")
            }
            
        }
    }
}

struct ParkingCardView: View {
    let parkingPlace: ParkingItem
    var body: some View {
        ZStack{
            
        }
    }
}

struct SearchView: View{
    var body: some View{
        ZStack{
            
        }
    }
}

struct ParkingDetailView: View{
    @ObservedObject var parkingFinder: ParkingFinder
    @State var region: MKCoordinateRegion
    var body: some View{
        ZStack{
            
        }
    }
}

//view model
class ParkingFinder: ObservableObject {
    @Published var spots = Data.spots
    @Published var selectedPlace: ParkingItem?
    @Published var showDetail = false
    
    @Published var region = MKCoordinateRegion(
        center:CLLocationCoordinate2D(
            latitude: Data.spots[0].location.latitude,
            longitude: Data.spots[0].location.longitude),
        span:  MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
            
            }





//mode class
struct ParkingItem: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let photoName: String
    let place: String
    let carLimit: Int
    let location: CLLocationCoordinate2D
    let fee: CGFloat
    var hour: String
}

//data
struct Data {
    static let spots = [
        ParkingItem(name: "Califoenia Parking", address: "2361 Mission St, San Francisco", photoName: "1", place: "B1", carLimit: 45, location: CLLocationCoordinate2D(latitude: 37.798599, longitude: -122.4100056), fee: 5.0, hour: "0.0"),
        ParkingItem(name: "Green St Parking", address: "654 Green St, San Francisco", photoName: "2", place: "A6", carLimit: 15, location: CLLocationCoordinate2D(latitude: 37.798599, longitude: -122.4100056), fee: 3.0, hour: "0.0"),
        ParkingItem(name: "Califoenia Parking", address: "440 Pine St, San Francisco", photoName: "3", place: "B4", carLimit: 20, location: CLLocationCoordinate2D(latitude: 37.798599, longitude: -122.4100056), fee: 5.0, hour: "0.0"),
    ]
    
}

// color
extension Color {
    static let darkColor = Color.init(red: 46/255, green: 45/255, blue: 45/255)
    static let lightColor = Color.init(red: 254/255, green: 254/255, blue: 254/255)
    static let yellowColor = Color.init(red: 245/255, green: 210/255, blue: 49/255)
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screensize = UIScreen.main.bounds.size
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
