//
//  TextView.swift
//  Slap
//
//  Created by Gilles Wittenberg on 21/09/2023.
//

import SwiftUI

struct TextView: View {
    var header: String
    var text: String
    var body: some View {
        VStack {
            Text(header)
                .font(
                    .system(size: 96, design: .monospaced)
                    .weight(.bold)
                )
                .foregroundColor(Color.accentColor)
            Text(text)
                .font(
                    .system(size: 24, design: .monospaced)
                    .weight(.bold)
                )
                .foregroundColor(Color.accentColor)
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(header: "140", text: "BPM")
        TextView(header: "🪘", text: "tap")
    }
}
