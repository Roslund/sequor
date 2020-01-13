import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var appState: AppState

  var body: some View {
    NavigationView {
      VStack {
        Text("User Mocking")
          .font(.system(size: 34))
          .padding(.bottom)

        HStack {
          Text("Enter desired userID")
          Spacer()
        }

        TextField("", text: $appState.userID).accessibility(label: Text("UserID Text Field"))
          .textFieldStyle(RoundedBorderTextFieldStyle())

        Text("The default userID is your device name. You are free to choose whatever ID you like. Your saved CO2 is associated with your user ID, If you change your ID you will lose your saved CO2. This tab is used for testing purposes only.")
          .font(.caption)

        Spacer()
        
      }
      .padding()
      .navigationBarTitle("Purchase", displayMode: .inline)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  
  static var previews: some View {
    ProfileView().environmentObject(AppState())
  }
}
