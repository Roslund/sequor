import XCTest

class IntegrationTests: XCTestCase {

  struct Wallet: Codable {
    let userId: String
    let totalCO2: Int
  }

  func testGetWalletsCURD() {
    let expectation = self.expectation(description: "Network Request")
    let url = URL(string: "https://polimi-demo.partners.mia-platform.eu/v2/wallets/")!

    HTTP.request(url: url) { data in
      // swiftlint:disable:next force_try
      let wallets = try! JSONDecoder().decode([Wallet].self, from: data)
      XCTAssertGreaterThan(wallets.count, 0, "There should be some wallets on the CRUD")
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testTripEndpoint() {
    let expectation = self.expectation(description: "Network Request")

    // swiftlint:disable:next force_try
    let trip = try! JSONDecoder().decode(Trip.self, from: tripJsonOptionalSpeedCourse.data(using: .utf8)!)

    HTTP.post(asJSON: trip, to: Endpoint.postTrip(userID: "test", ticketID: "test").url!) { data in
      XCTAssertEqual(String(data: data, encoding: .utf8)!, "")
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testTicketEndpoint() {
    let expectation = self.expectation(description: "Network Request")

    HTTP.request(url: Endpoint.ticket().url!) { data in
      let ticket = try? JSONDecoder().decode(Ticket.self, from: data)
      
      XCTAssertNotNil(ticket)
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

//  func testAddWalletCURD() {
//    let expectation = self.expectation(description: "Network Request")
//    let url = URL(string: "https://polimi-demo.partners.mia-platform.eu/v2/wallets/")!
//
//    let wallet = Wallet(userId: "000000000000000000000001", totalCO2: 100)
//    HTTP.post(asJSON: wallet, to: url) { data in
//      print(String(data: data, encoding: .utf8)!)
//      expectation.fulfill()
//    }
//
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func testDeleteWalletCURD() {
//    let expectation = self.expectation(description: "Network Request")
//    let url = URL(string: "https://polimi-demo.partners.mia-platform.eu/v2/wallets/5dea76282bfabf001199edd6")!
//
//    HTTP.request(method: .DELETE, url: url) { _ in
//      expectation.fulfill()
//    }
//
//    waitForExpectations(timeout: 5, handler: nil)
//  }
}

// MARK: - TEST DATA
let tripJsonOptionalSpeedCourse = """
{
"startDate": 595940155.43389,
"endDate": 595942509.0004162,
"locations": [
{
"timestamp": 595940289.415538,
"coordinate": {
"longitude": 16.544660933187075,
"latitude": 59.61169594671437
}
},
{
"speed": 0.6348273158073425,
"timestamp": 595940294.1770178,
"coordinate": {
"longitude": 16.54428380572857,
"latitude": 59.61165998611862
}
},
{
"speed": 0.9951707124710083,
"timestamp": 595940319.600208,
"course": 251.13288717664932,
"coordinate": {
"longitude": 16.54488012521895,
"latitude": 59.61192848738081
}
}
]
}
"""
