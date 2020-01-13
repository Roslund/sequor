import SwiftUI

struct DashboardView: View {
  @State var showingSheet = false
  @EnvironmentObject var appState: AppState

  var body: some View {
    NavigationView {
        ZStack {
          GeometryReader { geometry in
            // I have no idea why we need to multiply the size by 10, but it works...
            GameSceneView(size: CGSize(width: geometry.size.width*10, height: geometry.size.height*10),
                          treeLevel: self.appState.treeLevel,
                          fruit: !self.appState.coupons.isEmpty,
                          fruitTapCallback: {
                            self.showingSheet.toggle()
            })
          }
          VStack {
            Text("In total, you have saved")
              .font(.headline)
              .padding(.top)
            Text("\(appState.totalCO2) KG CO₂")
              .font(.largeTitle)
              .fontWeight(.heavy)
            Text("By taking public transport")
              .font(.headline)
            Spacer()
            }.popover(isPresented: $showingSheet) {
              VStack {
                CouponView(coupon: self.appState.coupons.first!)
                Button(action: {
                  if let id = self.appState.coupons.first?._id {
                    let useEndpoint = Endpoint.useCoupon(userID: self.appState.userID, couponID: id)
                    HTTP.request(method: .PUT, url: useEndpoint.url!) { _ in
                      self.appState.refreshCoupons()
                    }
                  }
                  self.showingSheet = false

                  // Haptic feedback
                  let generator = UIImpactFeedbackGenerator(style: .heavy)
                  generator.impactOccurred()
                }, label: {
                  HStack {
                    Spacer()
                    Text("Use Coupon")
                    Spacer()
                  }
                })
                  .padding(.vertical)
                  .foregroundColor(.white)
                  .background(Color.blue)
                  .cornerRadius(10)
                  .padding(.horizontal, 20)
                  .padding(.top, 24)
                Button(action: {
                  self.showingSheet = false
                  // Haptic feedback
                  let generator = UIImpactFeedbackGenerator(style: .light)
                  generator.impactOccurred()
                }, label: {
                  HStack {
                    Spacer()
                    Text("Cancel")
                    Spacer()
                  }
                })
                  .padding(.vertical)
                  .foregroundColor(.white)
                  .background(Color.gray)
                  .cornerRadius(10)
                  .padding(.horizontal, 20)
                .padding(.top, 8)
              }
          }
      }
      .navigationBarTitle("Seqour CO₂", displayMode: .inline)
    }.onAppear {
      self.appState.refreshWallet()
      self.appState.refreshCoupons()
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView()
      .environmentObject(AppState())
  }
}
