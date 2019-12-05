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

  /// Represents the visual state the tree should be in
  @Published var treeLevel: Int = 1

  /// Valid coupons the user has erned.
  @Published var coupons: [Coupon] = []

  var locationLogger: LocationLogger?

  init() {
    // We probably want to request the state from the backend when we instanciate the object
  }

  /// Sends a request for ticket mocking to server
  func activateTicket() {
    // Temp for testing. Should make request to server.
    activeTicket = Ticket(id: 1, experation: Date(timeInterval: 90*60, since: Date()))
    locationLogger = LocationLogger(trip: Trip())
  }

  // Should send a request to the server to invalidate the ticket.
  /// Currently invalidates the ticket client side and send the trip to the server.
  func invalidateTicket() {
    // Temp for testing. Should make request to server.
    activeTicket = nil
    if let trip = locationLogger?.end() {
      HTTP.post(asJSON: trip, to: URL(string: "http://10.3.10.102:8000/trip")!) { _ in
        
      }
    }
  }

}
