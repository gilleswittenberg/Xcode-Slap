//
//  InitView.swift
//  Slap
//
//  Created by Gilles Wittenberg on 27/08/2023.
//

import SwiftUI

struct InitView: View {
    
    var numTaps = 0
    
    var body: some View {
        VStack {
            Text("🪘")
                .font(
                    .system(size: 96)
                )
                .foregroundColor(Color.accentColor)
            Text(numTaps > 0 ? "again" : "tap")
                .font(
                    .system(size: 18, design: .monospaced)
                    .weight(.bold)
                )
                .foregroundColor(Color.accentColor)
        }
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
        InitView(numTaps: 1)
    }
}
