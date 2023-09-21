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
        TextView(header: "🪘", text: numTaps > 0 ? "again" : "tap")
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
        InitView(numTaps: 1)
    }
}
