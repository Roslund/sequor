import SwiftUI

struct CouponView: View {
  let coupon: Coupon
  let dateFormatter = DateFormatter()

  init(coupon: Coupon) {
    self.coupon = coupon
    dateFormatter.dateFormat = "DD MMM YYYY"
  }
  
  var body: some View {
    HStack {
      Text("\(coupon.discountPercentage)%")
        .fontWeight(.heavy)
        .font(.system(size: 40))
        .frame(width: 95, alignment: .center) // For fixing spacing
        .padding(.horizontal, -8)
        .rotationEffect(Angle(degrees: -90))
      
      VStack(alignment: .leading) {
        Text(coupon.title)
          .fontWeight(.bold)
          .font(.system(size: 24))
          .padding(.vertical)
        Text(coupon.text)
          .font(.caption)
          .foregroundColor(.white)
        
        Spacer()
        Text("VALID UNTIL: \(dateFormatter.string(from: coupon.expiration))")
          .font(.caption)
          .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
          .fontWeight(.bold)
          .padding(.bottom, 8)
      }
      .padding(.trailing, 16)
      Spacer()
    }
    .frame(height: 150, alignment: .center)
    .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
    .cornerRadius(20)
    .shadow(radius: 8)
    .padding(.top, 8)
    .padding(.horizontal, 12)
    
  }
}

struct CouponView_Previews: PreviewProvider {
  let date = Calendar.current.date(byAdding: DateComponents(day: 3), to: Date())!
  
  static var previews: some View {
    CouponView(coupon: Coupon(
      _id: "0",
      title: "First Logged Trip",
      text: "Congratulations, You just logged your first trip. "
        + "On your trip you saved 340g CO₂, compared to driving.",
      discountPercentage: 10,
      expiration: Date()
    ))
  }
}
