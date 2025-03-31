//
//  AboutView.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 30/03/25.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.blue, lineWidth: 2))

                Text("Hafid Ali Mustaqim")
                    .font(.title)
                    .padding(.top, 10)

                Text("hafidalimustaqim13@gmail.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
                
                Text("Mobile Engineer")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 2)

                Spacer()
            }
        }
        .navigationTitle("About Me")
        .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
