import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    NavigationView {
      VStack {
        Text("User Mocking").font(.system(size: 34))
          .padding(.top, 24)
          .padding(.bottom, 4)
        
        Text("This tab is used to mock user")
          .font(.caption)
          .padding(.horizontal, 24)
        
        Spacer()
        Text("Select user:")
        Picker("User ID", selection: $appState.userID) {
          Text("User 1").tag(1)
          Text("User 2").tag(2)
          Text("User 3").tag(3)
          Text("User 4").tag(4)
        }.pickerStyle(SegmentedPickerStyle())
        Text("Select Tree Level:")
        Picker("Level", selection: $appState.treeLevel) {
          Text("Level 1").tag(1)
          Text("Level 2").tag(2)
          Text("Level 3").tag(3)
          Text("Level 4").tag(4)
          Text("Level 4").tag(5)
        }.pickerStyle(SegmentedPickerStyle())
        Spacer()
        
      }.navigationBarTitle("Purchase", displayMode: .inline)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileView().environmentObject({ () -> AppState in
      let appState = AppState()
      appState.userID = 3
      return appState
      }())
  }
  
  init() {
  }
}
