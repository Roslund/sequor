import SwiftUI

struct PurchaseView: View {
    var body: some View {
        NavigationView {
            Text("PurchaseView")
                .navigationBarTitle("Purchase", displayMode: .inline)
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
