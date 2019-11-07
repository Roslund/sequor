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
            CouponsView().tabItem {
                Image(systemName: "tray.full.fill")
                Text("Copouns")
            }.tag(4)
            AccountView().tabItem {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
