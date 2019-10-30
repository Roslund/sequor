import SwiftUI

struct HomeView: View {
    @State private var selection = 1
    @State private var isUserLoggedIn: Bool = false
    @State private var showLoginView: Bool = true

    var body: some View {
        TabView(selection: $selection) {
            
            Text("Dashboard View").tabItem {
                Image(systemName: "cloud")
                Text("Dashboard")
            }.tag(1)
            
            Text("Coupuns View").tabItem {
                Image(systemName: "tray.full.fill")
                Text("Copouns")
            }.tag(2)
            
            AccountView().tabItem {
                Image(systemName: "person.circle")
                Text("Account")
            }.tag(3)
            
        }.edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showLoginView) {
                LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
