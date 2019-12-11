import SwiftUI

struct DashboardView: View {
  @State var showingSheet = false
  @EnvironmentObject var appState: AppState
  let gameScene = GameScene(size: CGSize(width: 3375, height: 7308))

  var body: some View {
    NavigationView {
        ZStack {
          SceneView(scene: gameScene)
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
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView().environmentObject({ () -> AppState in
      let appState = AppState()
      appState.treeLevel = 4
      appState.coupons.append(Coupon(
        id: 1,
        title: "200g of CO₂ Saved",
        text: "You have saved the envirorment 200g of CO₂. "
          + "For this we want to revard you. Here, have a coupon!",
        discountPersentage: 12,
        experation: Date())
      )
      return appState
      }())
  }
}
