//
//  SpotAnnotationView.swift
//  iParkApp
//
//  Created by Peter Deyi on 5/4/23.
//

import SwiftUI

struct SpotAnnotationView: View {
    let fee: String
    var selected: Bool = false
    var body: some View {
        ZStack {
            Image(selected ? "parking_marker" : "cost_marker")
                .resizable()
                .frame(width: 44, height: 44)
            
            Text("$\(fee)")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .opacity(selected ? 0.0 : 1.0)
        }
    }
}

