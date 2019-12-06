import XCTest
@testable import Sequor

class NetworkTests: XCTestCase {
  /// Validates that all endpoints can be constructed.
  /// Does **NOT** validate that they are reachable.
  func testEndpoints() {
    XCTAssertNotNil(Endpoint.allCouponsFor(userID: "test").url)
    XCTAssertNotNil(Endpoint.postTrip(userID: "test", ticketID: "test").url)
    XCTAssertNotNil(Endpoint.ticket().url)
    XCTAssertNotNil(Endpoint.useCoupon(userID: "test", couponID: "test"))
  }

  func testGET() {
    let expectation = self.expectation(description: "Network Request")

    HTTP.get(url: URL(string: "https://postman-echo.com/get")!, headers: nil, completionHandler: { data in
      if String(data: data, encoding: .utf8) != nil {
        expectation.fulfill()
      }
    })
    waitForExpectations(timeout: 2, handler: nil)
  }

  func testPOST() {
    let expectation = self.expectation(description: "Network Request")

    HTTP.post(asJSON: "test", to: URL(string: "https://postman-echo.com/post")!, completionHandler: { data in
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if responseJSON as? [String: Any] != nil {
        expectation.fulfill()
      }
    })

    waitForExpectations(timeout: 2, handler: nil)
  }

}
