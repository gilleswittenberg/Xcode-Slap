//
//  ContentView.swift
//  Slap
//
//  Created by Gilles Wittenberg on 22/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var clock = Clock()
    
    var body: some View {
        VStack {
            if let BPM = clock.BPM {
                BPMView(bpm: Int(BPM))
                    .padding(.top, 164)
                    .transition(
                        .asymmetric(
                            insertion: .identity,
                            removal: AnyTransition.opacity.animation(.easeOut(duration: 0.2))
                        )
                    )
                Spacer()
            } else {
                InitView(numTaps: clock.numTaps)
                    .padding()
                    .transition(
                        .asymmetric(
                            insertion: AnyTransition.opacity.animation(.easeOut(duration: 0.4)),
                            removal: .identity
                        )
                    )
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 240 / 255, green: 235 / 255, blue: 221 / 255))
        .onTapGesture {
            clock.appendTap()
        }
        .onLongPressGesture {
            clock.clear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
