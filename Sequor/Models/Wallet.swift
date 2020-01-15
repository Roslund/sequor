/// A wallet stores the total co2 a user has saved.
struct Wallet: Codable {
  /// UserId of the owner of the wallet. (hex)
  let userId: String
  /// Total co2 in KG saved by the user.
  let totalCO2: Double
}
