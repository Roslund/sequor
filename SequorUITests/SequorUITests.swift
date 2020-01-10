import XCTest

class SequorUITests: XCTestCase {

  override func setUp() {
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
  }

  func testTabs() {
    let app = XCUIApplication()
    app.launch()

    // Just cycle though all tabs
    let tabBarsQuery = app.tabBars
    tabBarsQuery.buttons["Home"].tap()
    tabBarsQuery.buttons["Purchase"].tap()
    tabBarsQuery.buttons["Dashboard"].tap()
    tabBarsQuery.buttons["Discovery"].tap()
    tabBarsQuery.buttons["Profile"].tap()
    tabBarsQuery.buttons["Dashboard"].tap()
  }

  func testStartTracking() {
    let app = XCUIApplication()
    app.launch()

    app.tabBars.buttons["Purchase"].tap()
    app.buttons["Create and activate Ticket"].tap()
    app.buttons["Invalidate Ticket"].tap()
  }

  func testShareSheet() {
    let app = XCUIApplication()
    app.launch()

    app.tabBars.buttons["Purchase"].tap()
    app.navigationBars["Purchase"].buttons["square.and.arrow.up"].tap()
  }

  func testClickFruit() {
    let app = XCUIApplication()
    app.launch()

    app.tabBars.buttons["Profile"].tap()
    
    let textField = app.textFields["UserID Text Field"]
    textField.press(forDuration: 1.5)
    textField.typeText(String(XCUIKeyboardKey.delete.rawValue))
    textField.typeText("Test1")
    textField.typeText(String(XCUIKeyboardKey.return.rawValue))
    
    app.tabBars.buttons["Dashboard"].tap()

    // It is impossible to actually tap the fruit thorught the accessability API...
    // So I'm just going to ignore it  \_(x.x)_/
  }

  func testLaunchPerformance() {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
