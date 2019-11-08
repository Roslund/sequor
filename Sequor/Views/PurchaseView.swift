import SwiftUI

struct PurchaseView: View {
    @State var hasTicket = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Ticket Mocking").font(.system(size: 34))
                .padding(.top, 24)
                .padding(.bottom, 4)

                Text("This tab is used to mock tickets. When pressing the button to create and "
                    + "activate a ticket, a request is sent to the backend to create a ticked "
                    + "for your current user ID. If successfull, you'll see the details of the "
                    + "ticket below. The ticket will be valid for 90 minutes.")
                .font(.caption)
                .padding(.horizontal, 24)

                Spacer()
                if hasTicket {
                    VStack(alignment: .leading) {
                        Text("Ticket.ID: 0")
                        Text("Ticket.experation: never!")
                        Text("Time remaining: 90min")
                    }
                }
                Spacer()
                Button(action: { self.hasTicket.toggle() }, label: {
                    HStack {
                        Spacer()
                        if !hasTicket {
                            Text("Create and activate Ticket")
                        } else {
                            Text("Invalidate Ticket")
                        }
                        Spacer()
                    }
                })
                .padding(.vertical)
                .foregroundColor(.white)
                .background(hasTicket ? Color.red : Color.green)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)

            }.navigationBarTitle("Purchase", displayMode: .inline)
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
