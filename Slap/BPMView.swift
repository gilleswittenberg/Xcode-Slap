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
        TextView(header: "\(bpm)", text: "BPM")
    }
}

struct BPMView_Previews: PreviewProvider {
    static var previews: some View {
        BPMView(bpm: 140)
    }
}
