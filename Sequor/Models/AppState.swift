import Foundation
import SwiftUI

/// Envirorment object that holds the globl state of the app
final class AppState: ObservableObject {
  private var tripSegmentator: TripSegmentator?
  private var ticketTimer: Timer?

  /// The userID of the user we want to mock
  var userID: String {
    get {
      return UserDefaults.standard.string(forKey: "userID") ?? UIDevice.current.name
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "userID")
      objectWillChange.send()
    }
  }

  /// If there is an active ticket is is held here
  @Published var activeTicket: Ticket?

  /// The total amount of CO2 the user has saved by taking public tansport
  @Published var totalCO2: Int = 0

  /// Valid coupons the user has erned.
  @Published var coupons: [Coupon] = []

  /// :nodoc:
  init(tripSegmentator: TripSegmentator? = nil) {
    self.tripSegmentator = tripSegmentator

    refreshWallet()
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

      self.tripSegmentator?.startMonitoring()

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
    if let trips = tripSegmentator?.stopMonitoring() {
      // Post all trips to the backend
      for trip in trips {
        HTTP.post(asJSON: trip,
                  to: Endpoint.postTrip(userID: userID, ticketID: activeTicket!.uuid).url!) { _ in
                  // Asume everything went fine
        }
      }
    }

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
    case 0:
      return 0
    case ..<200:
      return 1
    case ..<400:
      return 2
    case ..<500:
      return 3
    default:
      return 3
    }
  }
}

// Refresh Methods
extension AppState {
  /// Fetches the wallet from the backend and updates the local state.
  func refreshWallet() {
    HTTP.request(url: Endpoint.walletFor(userID: userID).url!) { data in
      if let wallet = try? JSONDecoder().decode(Wallet.self, from: data) {
        DispatchQueue.main.async {
          self.totalCO2 = wallet.totalCO2
        }
      }
    }
  }

  func refreshCoupons() {
    HTTP.request(url: Endpoint.allCouponsFor(userID: userID).url!) { data in
      if let coupons = try? JSONDecoder().decode([Coupon].self, from: data) {
        DispatchQueue.main.async {
          self.coupons = coupons
        }
      }
    }
  }
}
