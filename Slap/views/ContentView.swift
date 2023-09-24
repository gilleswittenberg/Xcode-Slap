//
//  ContentView.swift
//  Slap
//
//  Created by Gilles Wittenberg on 22/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    var displaySettings: Bool
    var averagingAlgorithm: AverageAlgorithm
    
    @StateObject var clock = Clock()
    
    var body: some View {
        VStack(spacing: 0) {
            if let BPM = clock.BPM {
                BPMView(bpm: Int(BPM))
                    .padding(.top, 164)
                    .transition(
                        .asymmetric(
                            insertion: .identity,
                            removal: AnyTransition.opacity.animation(.easeOut(duration: 0.2))
                        )
                    )
            } else {
                InitView(numTaps: clock.numTaps)
                    .padding(.top, 164)
                    .transition(
                        .asymmetric(
                            insertion: AnyTransition.opacity.animation(.easeOut(duration: 0.4)),
                            removal: .identity
                        )
                    )
            }
            if displaySettings {
                
                Text(getUserSelectedAlgorithm().display())
                    .font(
                        .system(size: 10, design: .monospaced)
                    )
                    .foregroundColor(Color.accentColor)
                    .opacity(0.3)
                    .padding(.top, 13)
            }
            Spacer()
            if displaySettings {
                Image(systemName: "gear")
                    .padding(.bottom, 48)
                    .foregroundColor(Color.accentColor)
                    .opacity(0.3)
                    .onTapGesture {
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                        guard UIApplication.shared.canOpenURL(settingsUrl) else { return }
                        UIApplication.shared.open(settingsUrl)
                    }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 240 / 255, green: 235 / 255, blue: 221 / 255))
        .onTapGesture {
            clock.appendTap(algorithm: averagingAlgorithm)
        }
        .onLongPressGesture {
            clock.clear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(displaySettings: true, averagingAlgorithm: AverageAlgorithm.instant)
    }
}
