import XCTest

class IntegrationTests: XCTestCase {
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

  func testGetWallet() {
    let expectation = self.expectation(description: "Network Request")
    let endpoint = Endpoint.walletFor(userID: "000000000000000000000001")

    HTTP.request(url: endpoint.url!) { data in
      let wallet = try? JSONDecoder().decode(Wallet.self, from: data)
      XCTAssertNotNil(wallet)
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
  }

  func testTripEndpoint() {
    let expectation = self.expectation(description: "Network Request")

    // swiftlint:disable force_try
    let trip = try! JSONDecoder().decode(Trip.self, from: tripJSON.data(using: .utf8)!)

    HTTP.post(asJSON: trip, to: Endpoint.postTrip(userID: "1", ticketID: "2").url!) { data in
      XCTAssertEqual(String(data: data, encoding: .utf8)!, "")
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testTicketEndpoint() {
    let expectation = self.expectation(description: "Network Request")

    HTTP.request(url: Endpoint.ticket().url!) { data in
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .millisecondsSince1970
      let ticket = try? decoder.decode(Ticket.self, from: data)
      XCTAssertNotNil(ticket)
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
  }

  func testCouponEndpoint() {
    let expectation = self.expectation(description: "Network Request")
    let getEndpoint = Endpoint.allCouponsFor(userID: "000000000000000000000001")

    HTTP.request(url: getEndpoint.url!) { data in
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970

      let coupons = try? decoder.decode([Coupon].self, from: data)
      XCTAssertNotNil(coupons)
      expectation.fulfill()

//      if let id = coupons?.first?._id {
//        let useEndpoint = Endpoint.useCoupon(userID: "000000000000000000000001", couponID: id)
//        HTTP.request(method: .PUT, url: useEndpoint.url!) { data in
//          expectation.fulfill()
//        }
//      }
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

/// Be carefull json is encoded with the default json encode and Apples time format.
let tripJSON = """
{
"startDate": 595940155.43389,
"endDate": 595942509.0004162,
"speed": -1.0,
"course": -1.0,
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
"course": -1.0,
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
