import SwiftUI

struct DashboardView: View {
  @State var showingSheet = false
  @EnvironmentObject var appState: AppState

  var body: some View {
    NavigationView {
      VStack {
        Text("In total, you have saved")
          .font(.headline)
          .padding(.top)
        Text("\(appState.totalCO2) KG CO₂")
          .font(.largeTitle)
          .fontWeight(.heavy)
        Text("By taking public transpot")
          .font(.headline)
        Spacer()
        ZStack {
          Image("Apple_Stage_\(appState.treeLevel)").resizable()
          if !appState.coupons.isEmpty {
            Button(
              action: {
                self.showingSheet = true
            },
              label: {
                Image(systemName: "dollarsign.circle.fill").font(.system(size: 32))
            }
            ).popover(isPresented: $showingSheet) {
              CouponView(coupon: self.appState.coupons.first!)
            }
          }
        }
        Spacer()

      }
      .navigationBarTitle("Seqour CO₂", displayMode: .inline)
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView().environmentObject({ () -> AppState in
      let appState = AppState()
      appState.treeLevel = 4
      appState.coupons.append(Coupon(
        id: 1,
        title: "200g of CO₂ Saved",
        text: "You have saved the envirorment 200g of CO₂. "
          + "For this we want to revard you. Here, have a coupon!",
        discountPersentage: 12,
        experation: Date())
      )
      return appState
      }())
  }
}
