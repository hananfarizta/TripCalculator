//
//  DialView.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import SwiftUI

struct DialView: View {
    
    // MARK: - Variables
    @Environment(MainViewModel.self) var mainViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var rotationDegree: Angle = .degrees(-45)
    @State var newRotationDegree: Angle = .degrees(-45)
    
    var size: CGFloat = 375
    var animationDuration: TimeInterval = 1.25
    
    // MARK: - Views
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: mainViewModel.isLoading ? 1.25 : 2, lineCap: .round, lineJoin: .round))
                    .opacity(mainViewModel.isLoading ? 0.5 : 1)
                    .animation(.smooth, value: mainViewModel.isLoading)
                    .padding(19)
                
                
                Circle()
                    .frame(width: 10, height: 10)
                
                Circle()
                    .trim(from: mainViewModel.loaderStart, to: 0.45)
                    .stroke(lineWidth: 2.5)
                    .foregroundColor(.gray)
                    .scaleEffect(0.71)
                    .rotationEffect(.degrees(-90))
                    .rotationEffect(mainViewModel.loaderRotation)
                    .opacity(mainViewModel.loaderOpacity)
                
                Circle()
                    .foregroundColor(.green.opacity(0.8))
                    .offset(x: -size / 2.5 + 40)
                    .frame(width: 28, height: 28)
                    .opacity(mainViewModel.isLoading ? 0.5 : 1)
                    .animation(.smooth, value: mainViewModel.isLoading)
                
                
                ForEach(1 ..< 25) { index in
                    Text("\(index)")
                        .font(Montserrat.medium.font(size: 17))
                        .offset(x: -size / 2.5)
                        .rotationEffect(.degrees(-30))
                        .rotationEffect(.degrees(Double(index * 15)))
                }
                .rotationEffect(rotationDegree)
                .gesture(getRotationGesture())
            }
            .frame(width: size, height: size)
            Spacer()
        }
        .onAppear() {
            withAnimation(.smooth(duration: 1)) {
                rotationDegree = .degrees(-15)
                newRotationDegree = .degrees(-15)
            }
        }
    }
    
    
    // MARK: - Functions
    func getRotationGesture() -> some Gesture {
        return DragGesture(minimumDistance: 3, coordinateSpace: .global)
            .onChanged { val in
                let rotationValue: Double = -Double(val.translation.width / 3)
                withAnimation(.spring()) {
                    if (Angle(degrees: rotationValue) + newRotationDegree > .degrees(360)) {
                        self.rotationDegree = .zero
                    }
                    
                    withAnimation(.spring()) {
                        self.rotationDegree = Angle(degrees: rotationValue) + newRotationDegree
                    }
                    
                    
                    let days: Int!
                    if (rotationDegree.degrees < 0) {
                        days = 1 + Int(ceil(abs(rotationDegree.degrees / 15)))
                        self.mainViewModel.days = days
                    } else {
                        days = 26 - Int(ceil(abs(rotationDegree.degrees / 15))) // you can customise the logic and define limits for days
                        self.mainViewModel.days = days
                    }
                }
            }
            .onEnded { val in
                self.newRotationDegree = self.rotationDegree
                
                withAnimation(.easeInOut(duration: 0.25)) {
                    self.mainViewModel.isLoading = true
                }
                
                withAnimation(.default) {
                    mainViewModel.loaderOpacity = 1
                }
                
                withAnimation(.easeInOut(duration: animationDuration)) {
                    mainViewModel.loaderRotation = .degrees(555)
                }
                
                Timer.scheduledTimer(withTimeInterval: animationDuration / 1.25, repeats: false) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        mainViewModel.loaderStart = 0.45
                    }
                }
                
                resetWhenNeeded()
            }
    }
    
    func resetWhenNeeded() {
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.1, repeats: false) { _ in
            mainViewModel.loaderOpacity = 0
            mainViewModel.loaderRotation = .zero
            mainViewModel.loaderStart = 0
            
            withAnimation(.smooth) {
                mainViewModel.isLoading = false
            }
            
            withAnimation(.smooth) {
                mainViewModel.compute()
            }
        }
    }
}
#Preview {
    DialView()
        .environment(MainViewModel())
}
