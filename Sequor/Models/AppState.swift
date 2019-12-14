import Foundation
import SwiftUI

/// Envirorment object that holds the globl state of the app
final class AppState: ObservableObject {
  private var tripSegmentator: TripSegmentator
  private var ticketTimer: Timer?

  /// The userID of the user we want to mock
  @Published var userID: Int = 1

  /// If there is an active ticket is is held here
  @Published var activeTicket: Ticket?

  /// The total amount of CO2 the user has saved by taking public tansport
  @Published var totalCO2: Int = 0

  /// For udpating totalCO2 with a bindable Double
  var doubbleCO2 = 0.0 {
    willSet {
      totalCO2 = Int(newValue)
      //objectWillChange.send()
    }
  }

  /// Valid coupons the user has erned.
  @Published var coupons: [Coupon] = []

  /// :nodoc:
  init(tripSegmentator: TripSegmentator = TripSegmentator()) {
    self.tripSegmentator = tripSegmentator
    // We probably want to request the state from the backend when we instanciate the object
  }

  /// Sends a request for ticket mocking to server
  func activateTicket() {

    HTTP.request(url: Endpoint.ticket().url!) { data in
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .millisecondsSince1970

      guard let ticket = try? decoder.decode(Ticket.self, from: data) else {
        print("Failed to get ticket from ticket service")
        return
      }

      self.tripSegmentator.startMonitoring()

      // Changes to the UI and Timers need to happen on the main thread
      DispatchQueue.main.async {
        self.activeTicket = ticket

        // Set time to invalidate the ticket.
        let timeInterval = ticket.expiration.timeIntervalSinceNow
        self.ticketTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { timer in
          self.invalidateTicket()
          timer.invalidate()
        }
      }

    }
  }

  /// Invalidates the ticket client side.
  func invalidateTicket() {
    tripSegmentator.stopMonitoring()

    // All changes to the UI need to happen on the main thread
    DispatchQueue.main.async {
      self.activeTicket = nil
    }
  }

}

extension AppState {
  /// Represents the visual state the tree should be in
  var treeLevel: Int {
    switch totalCO2 {
    case ...200:
      return 1
    case ...400:
      return 2
    case ...800:
      return 3
    default:
      return 3
    }
  }
}
