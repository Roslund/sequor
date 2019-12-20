import SwiftUI

struct DashboardView: View {
  @State var showingSheet = false
  @EnvironmentObject var appState: AppState

  var body: some View {
    NavigationView {
        ZStack {
          GeometryReader { geometry in
            // I have no idea why we need to multiply the size by 10, but it works...
            GameSceneView(size: CGSize(width: geometry.size.width*10, height: geometry.size.height*10),
                          treeLevel: self.appState.treeLevel)
          }
          VStack {
            Text("In total, you have saved")
              .font(.headline)
              .padding(.top)
            Text("\(appState.totalCO2) KG CO₂")
              .font(.largeTitle)
              .fontWeight(.heavy)
            Text("By taking public transprot")
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
