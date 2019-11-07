import SwiftUI

struct CouponsView: View {
    var coupons: [Coupon] = [
        Coupon(
            id: 0,
            title: "First Logged Trip",
            text: "Congratulations, You just logged your first trip. "
                + "On your trip you saved 34g CO₂, compared to driving.",
            discountPersentage: 10,
            experation: Date()),
        Coupon(
            id: 1,
            title: "200g of CO₂ Saved",
            text: "You have saved the envirorment 200g of CO₂. "
                + "For this we want to revard you. Here, have a coupon!",
            discountPersentage: 12,
            experation: Date()),
        Coupon(
            id: 2,
            title: "Weekend Traveler",
            text: "Busy week? You have made 10 trips this week using public transport.",
            discountPersentage: 15,
            experation: Date())
    ]

    var body: some View {
        NavigationView {
            if coupons.isEmpty {
                VStack {
                    Text("You have no copuons :(")
                        .font(.system(size: 26))
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .fontWeight(.heavy)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    Text("Save CO₂ by taking public transpot and earn coupons. "
                        + "Using your devices GPS, it is possible to estimate how "
                        + "much CO₂ you save by taking public transport compared to driving.")
                        .font(.caption)
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .padding(.horizontal, 32)
                    Spacer()
                }
                .navigationBarTitle("Coupons", displayMode: .inline)
            }
            List(coupons, id: \.id) { coupon in
                CouponView(coupon: coupon)
            }
            // Ugly hack to get reid of list row seperators
            .onAppear { UITableView.appearance().separatorStyle = .none }
            .navigationBarTitle("Coupons", displayMode: .inline)
        }
    }
}

struct CouponsView_Previews: PreviewProvider {
    static var previews: some View {
        CouponsView(coupons:
            [
                Coupon(
                    id: 0,
                    title: "First Logged Trip",
                    text: "Congratulations, You just logged your first trip. "
                    + "On your trip you saved 34g CO₂, compared to driving.",
                    discountPersentage: 10,
                    experation: Date()),
                Coupon(
                    id: 1,
                    title: "200g of CO₂ Saved",
                    text: "You have saved the envirorment 200g of CO₂. "
                    + "For this we want to revard you. Here, have a coupon!",
                    discountPersentage: 12,
                    experation: Date()),
                Coupon(
                    id: 2,
                    title: "Weekend Traveler",
                    text: "Busy week? You have made 10 trips this week using public transport.",
                    discountPersentage: 15,
                    experation: Date())
            ]
        )
    }
}
