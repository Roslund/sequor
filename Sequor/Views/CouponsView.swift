import SwiftUI

struct CouponsView: View {
    var body: some View {
        NavigationView {
            Text("Coupons View")
            .navigationBarTitle("Coupons", displayMode: .inline)
        }
    }
}

struct CouponsView_Previews: PreviewProvider {
    static var previews: some View {
        CouponsView()
    }
}
