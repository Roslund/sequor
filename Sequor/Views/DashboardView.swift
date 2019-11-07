//
//  DashboardView.swift
//  Sequor
//
//  Created by Anton Roslund on 2019-11-07.
//  Copyright © 2019 Anton Roslund. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            Text("Dashbard View")
            .navigationBarTitle("Seqour CO₂", displayMode: .inline)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
