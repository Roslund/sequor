import Foundation
import SwiftUI

/// Provides the relatime time, in minutes, to a given date.
/// And updates it every 30 secounds.
struct RelativeTimeText: View {
  @ObservedObject var relativeTime: RelativeTime
  let textAfter: String
  let textBefore: String
  
  var body: some View {
    Text("\(textBefore)\(relativeTime.text)\(textAfter)")
  }
  
  init(to date: Date, textBefore: String = "", textAfter: String = "") {
    self.relativeTime = RelativeTime(to: date)
    self.textBefore = textBefore
    self.textAfter = textAfter
  }
}

class RelativeTime: ObservableObject {
  var timer = Timer()
  @Published var text: String
  
  init(to date: Date) {
    text = String(Int(date.timeIntervalSinceNow / 60))
    
    timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
      self.text = String(Int(date.timeIntervalSinceNow / 60))
    }
  }
}
