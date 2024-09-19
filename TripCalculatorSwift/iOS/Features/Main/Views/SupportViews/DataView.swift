//
//  DataView.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import SwiftUI

struct DataView: View {
    
    // MARK: - Variables
    @Environment(MainViewModel.self) var mainViewModel

    let imageName: String
    @Binding var data: String
    
    // MARK:- Views
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 24, weight: .medium))
                .frame(width: 31, height: 31)
                .symbolEffect(.wiggle, options: .speed(0.85), value: mainViewModel.isLoading)

            Text(data)
                .font(Montserrat.medium.font(size: 16))
                .padding(.top, 4)
        }
        .opacity(0.65)
    }
}


#Preview {
    DataView(imageName: "stopwatch", data: .constant("45 hours 45 minutes"))
        .environment(MainViewModel())
}
