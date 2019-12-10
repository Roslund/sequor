import SwiftUI

struct PurchaseView: View {
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var tripSegmentator: TripSegmentator
  @State private var showActivitySheet = false

  var body: some View {
    NavigationView {
      VStack {
        Text("Ticket Mocking").font(.system(size: 34))
          .padding(.top, 24)
          .padding(.bottom, 4)

        Text("This tab is used to mock tickets. When pressing the button to create and "
          + "activate a ticket, a request is sent to the backend to create a ticked "
          + "for your current user ID. If successfull, you'll see the details of the "
          + "ticket below. The ticket will be valid for 90 minutes.")
          .font(.caption)
          .padding(.horizontal, 24)

        Spacer()
        if appState.activeTicket != nil {
          VStack(alignment: .leading) {
            Text("Ticket.ID: \(appState.activeTicket!.uuid)")
            Text("Ticket.experation: \(ISO8601DateFormatter().string(from: appState.activeTicket!.expiration))")
            RelativeTimeText(to: appState.activeTicket!.expiration, textBefore: "Time Remaining: ")
            Text("Activity: \(tripSegmentator.activity.rawValue)")
          }
        }
        Spacer()
        Button(action: {
          if self.appState.activeTicket == nil {
            self.appState.activateTicket()
            self.tripSegmentator.startMonitoring()
          } else {
            self.appState.invalidateTicket()
            self.tripSegmentator.stopMonitoring()
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
        ActivityView(activityItems: [
          // swiftlint:disable:next force_try
          String(data: try! JSONEncoder().encode(self.tripSegmentator.trips), encoding: .utf8)!
            ], applicationActivities: nil)
      }

    }
  }
}

struct PurchaseView_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseView().environmentObject({ () -> AppState in
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
      }()).environmentObject(TripSegmentator())
  }
}
