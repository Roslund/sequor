import Foundation
import SwiftUI

/// Envirorment object that holds the globl state of the app
final class AppState: ObservableObject {

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
  init() {
    // We probably want to request the state from the backend when we instanciate the object
  }

  /// Sends a request for ticket mocking to server
  func activateTicket() {
    // Temp for testing. Should make request to server.
    activeTicket = Ticket(uuid: "1", expiration: Date(timeInterval: 90*60, since: Date()))
  }

  // Should send a request to the server to invalidate the ticket.
  /// Currently invalidates the ticket client side and send the trip to the server.
  func invalidateTicket() {
    // Temp for testing. Should make request to server.
    activeTicket = nil
//    if let trip = locationLogger?.end() {
//      HTTP.post(asJSON: trip, to: Endpoint.postTrip(userID: "test", ticketID: "test").url!) { _ in }
//    }
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
