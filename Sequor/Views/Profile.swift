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
          Text("User 1").tag("000000000000000000000001")
          Text("User 2").tag("000000000000000000000002")
          Text("User 3").tag("000000000000000000000003")
          Text("User 4").tag("000000000000000000000004")
        }.pickerStyle(SegmentedPickerStyle())
        Spacer()
        
      }.navigationBarTitle("Purchase", displayMode: .inline)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileView().environmentObject(AppState())
  }
}
