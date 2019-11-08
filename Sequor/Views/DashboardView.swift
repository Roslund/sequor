import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            CapsuleGraph(value: 29.34, maxValue: 50.0, textLabel: "CO2 Saved")
            .navigationBarTitle("Seqour CO₂", displayMode: .inline)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
