//
//  MainView.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    @State var mainViewModel: MainViewModel = MainViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    @State var viewAppeared = false
    
    let animationDuration: TimeInterval = 1.5
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            Color.backgroundNeu
                .edgesIgnoringSafeArea(.all)
            
            GenerateMeshView()
                .opacity(mainViewModel.isLoading ? 0.1 : 1)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(mainViewModel.days)")
                        .font(Montserrat.semibold.font(size: 54))
                        .frame(minWidth: 55, alignment: .center)
                        .animation(.spring(), value: mainViewModel.days)
                        .foregroundColor(.green)
                        .brightness(-0.1)
                        .opacity(mainViewModel.isLoading ? 0.2 : 1)
                    
                    Text("days")
                        .font(Montserrat.semibold.font(size: 54))
                        .foregroundColor(.green)
                        .brightness(-0.1)
                        .contentTransition(.numericText())
                        .animation(.smooth, value: mainViewModel.days)
                        .opacity(mainViewModel.isLoading ? 0.2 : 1)
                    
                    Spacer()
                    Image(systemName: "figure.walk")
                        .font(.system(size: 28, weight: .bold))
                        .padding(14)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .foregroundColor(.green)
                        )
                        .symbolEffect(.pulse, value: mainViewModel.isLoading)
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal, 12)
                .offset(y: viewAppeared ? 0 : -44)
                .opacity(viewAppeared ? 1 : 0)
                .animation(.smooth, value: viewAppeared)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("On Average you need to walk")
                            .font(Degular.medium.font(size: 15))
                            .opacity(0.6)
                        
                        Text(mainViewModel.track.averageDuration)
                            .font(Montserrat.semibold.font(size: 25))
                            .tracking(1)
                            .opacity(0.8)
                            .animation(.smooth, value: mainViewModel.track.averageDuration)
                            .contentTransition(.numericText())
                    }
                    .padding(.top, 12)
                    .offset(y: viewAppeared ? 0 : -24)
                    .opacity(viewAppeared ? 1 : 0)
                    .animation(.smooth.delay(0.1), value: viewAppeared)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("On some days, you'll have to climb over")
                            .font(Degular.medium.font(size: 15))
                            .opacity(0.6)
                        
                        Text(mainViewModel.track.climbDistance)
                            .font(Montserrat.semibold.font(size: 25))
                            .tracking(1)
                            .opacity(0.8)
                            .animation(.smooth, value: mainViewModel.track.climbDistance)
                            .contentTransition(.numericText())
                        
                    }
                    .padding(.top, 12)
                    .offset(y: viewAppeared ? 0 : -24)
                    .opacity(viewAppeared ? 1 : 0)
                    .animation(.smooth.delay(0.125), value: viewAppeared)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("The overall difficulty level is")
                            .font(Degular.medium.font(size: 15))
                            .opacity(0.6)
                        
                        Text(mainViewModel.track.difficulty.rawValue)
                            .font(Montserrat.semibold.font(size: 25))
                            .tracking(1)
                            .opacity(0.8)
                            .animation(.smooth, value: mainViewModel.track.difficulty)
                            .contentTransition(.numericText())
                    }
                    .padding(.top, 12)
                    .offset(y: viewAppeared ? 0 : -24)
                    .opacity(viewAppeared ? 1 : 0)
                    .animation(.smooth.delay(0.15), value: viewAppeared)
                    
                }
                .padding(.horizontal, 12)
                .opacity(mainViewModel.isLoading ? 0.1 : 1)
                
                DialView(size: UIScreen.main.bounds.width * 0.874, animationDuration: animationDuration)
                    .opacity(viewAppeared ? 1 : 0)
                    .animation(.smooth.delay(0.15), value: viewAppeared)
                
                Spacer()
                
                HStack {
                    Spacer()
                    DataView(imageName: "stopwatch", data: $mainViewModel.track.totalDuration)
                    Spacer()
                    DataView(imageName: "arrow.left.and.right", data: $mainViewModel.track.totalDistance)
                    Spacer()
                    DataView(imageName: "arrow.up.right", data: $mainViewModel.track.upwardsDistance)
                    Spacer()
                    DataView(imageName: "arrow.down.right", data: $mainViewModel.track.downwardsDistance)
                    Spacer()
                }
                .opacity(mainViewModel.isLoading ? 0.1 : 1)
                .offset(y: viewAppeared ? 0 : -24)
                .opacity(viewAppeared ? 1 : 0)
                .animation(.smooth.delay(0.2), value: viewAppeared)
            }
            .padding(24)
        }
        .environment(mainViewModel)
        .onAppear() {
            viewAppeared.toggle()
        }
    }
    
    
    // MARK: - Functions
    @ViewBuilder
    func GenerateMeshView() -> some View {
        TimelineView(.animation()) { timeline in
            let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2
            
            MeshGradient(width: 3, height: 3,
                         points: [
                            [0, 0], [0.5, 0], [1, 0],
                            [0, 0.5], [Float(x), 0.5], [1, 0.5],
                            [0, 1], [0.5, 1], [1, 1]
                         ],
                         colors: [
                            .backgroundNeu.opacity(0.5), .green.opacity(0.105), .backgroundNeu.opacity(0.15),
                            .backgroundNeu.opacity(0.5), .backgroundNeu.opacity(0.1), .backgroundNeu.opacity(0.5),
                            .backgroundNeu, .backgroundNeu, .backgroundNeu.opacity(1)
                         ],
                         smoothsColors: true
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
