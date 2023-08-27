//
//  BPMView.swift
//  Slap
//
//  Created by Gilles Wittenberg on 23/08/2023.
//

import SwiftUI

struct BPMView: View {
    var bpm: Int
    var body: some View {
        VStack {
            Text("\(bpm)")
                .font(
                    .system(size: 96, design: .monospaced)
                    .weight(.bold)
                )
                .foregroundColor(Color.accentColor)
            Text("BPM")
                .font(
                    .system(size: 24, design: .monospaced)
                    .weight(.bold)
                )
                .foregroundColor(Color.accentColor)
        }
    }
}

struct BPMView_Previews: PreviewProvider {
    static var previews: some View {
        BPMView(bpm: 140)
    }
}
