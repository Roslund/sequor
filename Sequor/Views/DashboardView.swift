import SwiftUI

struct DashboardView: View {
  @State var showingSheet = false
  @EnvironmentObject var appState: AppState

  var body: some View {
    NavigationView {
        ZStack {
          GameSceneView(treeLevel: appState.treeLevel)
          VStack {
            Text("In total, you have saved")
              .font(.headline)
              .padding(.top)
            Text("\(appState.totalCO2) KG CO₂")
              .font(.largeTitle)
              .fontWeight(.heavy)
            Text("By taking public transpot")
              .font(.headline)
            Spacer()
          }
      }
      .navigationBarTitle("Seqour CO₂", displayMode: .inline)
    }.onAppear {
      self.appState.refreshWallet()
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView()
      .environmentObject(AppState())
  }
}
