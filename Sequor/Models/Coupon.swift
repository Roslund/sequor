import Foundation

/// Represents a discount that can be redeemed by the user.
struct Coupon: Codable {
  /// Unique id
  let _id: String

  /// Presented at the top of the coupon in large font.
  let title: String

  /// Descriptive text what the coupon is offereing.
  let text: String

  /// The discount the coupons offers (1-100)%.
  let discountPercentage: Int

  /// The date when the coupon expires.
  let expiration: Date
}
