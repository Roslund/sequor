import XCTest

class SequorTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testTreeFactory() {
    for i in 0...5 {
      _ = TreeFactory.createTree(level: i)
    }
  }

  func testAppState() {
    let appState = AppState()
    appState.activateTicket()
    let expectation = self.expectation(description: "Network Request")

    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(appState.activeTicket)

    let expectation2 = self.expectation(description: "Async Work")
    appState.invalidateTicket()

    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
      expectation2.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNil(appState.activeTicket)

    let expectation3 = self.expectation(description: "Network Request")
    appState.refreshWallet()
    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
      expectation3.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)

  }
}
