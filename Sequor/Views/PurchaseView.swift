import SwiftUI

struct PurchaseView: View {
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var tripSegmentator: TripSegmentator
  @State private var showActivitySheet = false

  var body: some View {
    NavigationView {
      VStack {
        Image("Ticket").resizable().scaledToFit().padding().padding(.top, 60)
        Spacer()
        Spacer()
        if appState.activeTicket != nil {
          RelativeTimeText(to: appState.activeTicket!.expiration, textBefore: "Time Remaining: ")
            .font(.system(size: 26)).padding()
        }
        Spacer()
        Button(action: {
          if self.appState.activeTicket == nil {
            self.appState.activateTicket()
          } else {
            self.appState.invalidateTicket()
          }

          // Haptic feedback
          let generator = UIImpactFeedbackGenerator(style: .heavy)
          generator.impactOccurred()

        }, label: {
          HStack {
            Spacer()
            if appState.activeTicket == nil {
              Text("Create and activate Ticket")
            } else {
              Text("Invalidate Ticket")
            }
            Spacer()
          }
        })
          .padding(.vertical)
          .foregroundColor(.white)
          .background(appState.activeTicket != nil ? Color.red : Color.green)
          .cornerRadius(10)
          .padding(.horizontal, 20)
          .padding(.bottom, 24)
      }
      .navigationBarTitle("Purchase", displayMode: .inline)
    }
  }
}

struct PurchaseView_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseView()
      .environmentObject(AppState())
      .environmentObject(TripSegmentator())
  }
}
