import CoreMotion

/// :nodoc:
/// Convenice method for returning an enum instead of having to query all functions.
extension CMMotionActivity {
    /// CMActityManager
    enum Classification: String {
        case walking
        case running
        case cycling
        case automotive
        case stationary
        case unknown
    }

    var classification: Classification {
        if self.walking {
            return .walking
        } else if self.running {
            return .running
        } else if self.cycling {
            return .cycling
        } else if self.automotive {
            return .automotive
        } else if self.stationary {
            return .stationary
        } else {
            return .unknown
        }
    }
}
