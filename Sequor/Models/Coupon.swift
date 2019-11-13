import Foundation

/// Represents a discount that can be redeemed by the user.
struct Coupon {
  /// Unique id
  let id: Int

  /// Presented at the top of the coupon in large font.
  let title: String

  /// Descriptive text what the coupon is offereing.
  let text: String

  /// The discount the coupons offers (1-100)%.
  let discountPersentage: Int

  /// The date when the coupon expires.
  let experation: Date
}
