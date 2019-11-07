//
//  CoupunsView.swift
//  Sequor
//
//  Created by Anton Roslund on 2019-11-07.
//  Copyright © 2019 Anton Roslund. All rights reserved.
//

import SwiftUI

struct CouponsView: View {
    var body: some View {
        NavigationView {
            Text("Coupons View")
            .navigationBarTitle("Coupons", displayMode: .inline)
        }
    }
}

struct CouponsView_Previews: PreviewProvider {
    static var previews: some View {
        CouponsView()
    }
}
