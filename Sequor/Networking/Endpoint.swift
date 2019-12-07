import Foundation

/// Endpoints to access the REST API of the backend
struct Endpoint {
  var components = URLComponents()
  private let host = "polimi-demo.partners.mia-platform.eu"
  let path: String
  
  // Private initializer to make it impossible to create endpoints manually.
  private init(path: String) {
    self.path = path
  }
  
  /// The URL of the endpoint
  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    
    return components.url
  }
}

extension Endpoint {
  /// Endpoint for posting trip data to the backend
  static func postTrip(userID: String, ticketID: String) -> Endpoint {
    Endpoint(path: "/geolocalization/trip/\(userID)/\(ticketID)/data")
  }
  
  /// Endpoint for getting an active ticket from the backend
  static func ticket() -> Endpoint {
    Endpoint(path: "/ticket/")
  }
  
  /// Endpoint for getting all coupons owned by a userId
  static func allCouponsFor(userID: String) -> Endpoint {
    Endpoint(path: "/coupon/user/\(userID)")
  }
  
  /// Endpoint to use a coupon identified by a id
  /// **Expects PUT request**
  static func useCoupon(userID: String, couponID: String) -> Endpoint {
    Endpoint(path: "/coupon/\(userID)/\(couponID)/use")
  }
}
