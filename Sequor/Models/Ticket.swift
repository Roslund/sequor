import Foundation

/// Represent an active ticket recived from the backend.
/// Since we are mocking tickets, there is no need for security.
struct Ticket: Codable {
  /// Unique identifier for the specific ticket.
  let uuid: String

  /// The specific time when the ticket expires. Normaly 90 minutes after created.
  let expiration: Date
}
