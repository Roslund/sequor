import SwiftUI

/// A swiftUI wrapper around UIActivityViewController.
/// Shows what commonly is refered to as the *ShareSheet*.
/// We can use this to open and save data on device for easy onDevice debugging of tracking.
///  - - -
///  **Usage:**
/// ```swift
/// .sheet(isPresented: $showActivitySheet) {
///   ActivityView(activityItems: [data],
///   applicationActivities: nil)
/// }
/// ```
struct ActivityView: UIViewControllerRepresentable {
  
  let activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
    return UIActivityViewController(activityItems: activityItems,
                                    applicationActivities: applicationActivities)
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController,
                              context: UIViewControllerRepresentableContext<ActivityView>) {
  }
}
