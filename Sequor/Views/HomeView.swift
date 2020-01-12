import SwiftUI

struct HomeView: View {
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var tripSegmentator: TripSegmentator
  @State private var showActivitySheet = false

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        if appState.activeTicket != nil {
            Text("Ticket.ID: \(appState.activeTicket!.uuid)")
            Text("Ticket.experation: \(ISO8601DateFormatter().string(from: appState.activeTicket!.expiration))")
        }
        Text("Activity: \(tripSegmentator.activity.rawValue)")
      }
      .navigationBarTitle("Home", displayMode: .inline)
      .navigationBarItems(trailing:
        Button(action: {
          // Haptic feedback
          let generator = UIImpactFeedbackGenerator(style: .heavy)
          generator.impactOccurred()
          self.showActivitySheet = true
        },
               label: {
                Image(systemName: "square.and.arrow.up").resizable().font(.system(size: 25)).padding(.trailing, 12)
        }))
        .sheet(isPresented: $showActivitySheet) {
          ActivityView(activityItems: [self.tripSegmentator.trips.asJSONString()], applicationActivities: nil)
      }

    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseView()
      .environmentObject(AppState())
      .environmentObject(TripSegmentator())
  }
}
