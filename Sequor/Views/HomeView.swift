import SwiftUI

struct HomeView: View {
  @State private var selection = 3
  
  var body: some View {
    TabView(selection: $selection) {
      Text("Home View").tabItem {
        Image(systemName: "house")
        Text("Home")
      }.tag(1)
      PurchaseView().tabItem {
        Image(systemName: "cart")
        Text("Purchase")
      }.tag(2)
      DashboardView().tabItem {
        Image(systemName: "cloud")
        Text("Dashboard")
      }.tag(3)
      Text("Discovery View").tabItem {
        Image(systemName: "arrowtriangle.up")
        Text("Discovery")
      }.tag(4)
      ProfileView().tabItem {
        Image(systemName: "person")
        Text("Profile")
      }.tag(5)
    }
    .accentColor(.green)
    .edgesIgnoringSafeArea(.top)
  }
  
  init() {
    // Probably not the best way to do this, but it works and sets it for all views
    UINavigationBar.appearance().backgroundColor = .green
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environmentObject({ () -> AppState in
      let appState = AppState()
      appState.totalCO2 = 200
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
