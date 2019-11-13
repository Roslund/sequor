import Foundation
import CoreMotion

/// Provides the user activity (e.g. Walking, Running, Stationary)
final class ActivityManager: ObservableObject {
  let manager = CMMotionActivityManager()

  /// The activity the user is performing, represented by emoji.
  @Published var activityString: String = ""

  /// The confidence in the classification (low, medium, high)
  @Published var confidenceString: String = ""

  init() {
    // We probably do not want to start monitoring directly
    // It probaraly enough to only use it when the user has and avtive ticket.
    startMonitoring()
  }

  func startMonitoring() {
    manager.startActivityUpdates(to: .main) { (activity) in
      guard let activity = activity else {
        return
      }

      self.setConfidenceString(activity.confidence)
      self.setActivityString(activity)
    }
  }

  func stopMonitoring() {
    manager.stopActivityUpdates()
  }

  private func setConfidenceString(_ confidence: CMMotionActivityConfidence) {
    switch confidence {
    case .low:
      self.confidenceString = "Low"
    case .medium:
      self.confidenceString = "Medium"
    case .high:
      self.confidenceString = "High"
    @unknown default:
      self.confidenceString = "Unknown"
    }
  }

  private func setActivityString(_ activity: CMMotionActivity) {
    // There is a possiblity that there can be different modes at the same time.
    // I have not seen such a case, but that's the reason why it's a set of modes.
    var modes: Set<String> = []
    if activity.walking {
      modes.insert("🚶‍")
    }
    if activity.running {
      modes.insert("🏃‍")
    }
    if activity.cycling {
      modes.insert("🚴‍")
    }
    if activity.automotive {
      modes.insert("🚗")
    }
    if activity.stationary {
      modes.insert("👨‍💻")
    }
    if activity.unknown {
      modes.insert("🤷‍♂️")
    }

    self.activityString = modes.joined(separator: ", ")
  }
}
