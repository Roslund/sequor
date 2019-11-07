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
