import SwiftUI

struct TabView: View {
  @EnvironmentObject var tripSegmentator: TripSegmentator
  @State private var selection = 2
  
  var body: some View {
    SwiftUI.TabView(selection: $selection) {
      HomeView().tabItem {
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
      MapView(tripSegmentator: tripSegmentator).edgesIgnoringSafeArea(.vertical).tabItem {
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

struct TabView_Previews: PreviewProvider {
  static var previews: some View {
    TabView()
      .environmentObject(AppState())
      .environmentObject(TripSegmentator())
  }
}
