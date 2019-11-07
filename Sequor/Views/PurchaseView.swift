//
//  PushaseView.swift
//  Sequor
//
//  Created by Anton Roslund on 2019-11-07.
//  Copyright © 2019 Anton Roslund. All rights reserved.
//

import SwiftUI

struct PurchaseView: View {
    var body: some View {
        NavigationView {
            Text("PurchaseView")
                .navigationBarTitle("Purchase", displayMode: .inline)
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
