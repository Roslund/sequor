import SwiftUI

struct ContentView: View {
    @State var selection = 1

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Text("Dashboard View").tabItem {
                    Image(systemName: "cloud")
                    Text("Dashboard")
                }.tag(1)
                Text("Coupuns View").tabItem {
                    Image(systemName: "tray.full.fill")
                    Text("Copouns")
                }.tag(2)
                Text("Account View").tabItem {
                    Image(systemName: "person.circle")
                    Text("Account")
                }.tag(3)
            }
            .navigationBarTitle("Sequor", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
