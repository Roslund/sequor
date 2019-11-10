import SwiftUI

struct DashboardView: View {
    var totalCO2 = 200
    var goal = 100
    var current = 30

    var body: some View {
        NavigationView {
            VStack {
                Text("In total, you have saved").font(.headline).padding(.top)
                Text("\(totalCO2)KG CO₂").font(.largeTitle).fontWeight(.heavy)
                Text("By taking public transpot").font(.headline)
                Spacer()
                Text("Goal: \(goal)KG")
                RectangleGraph(percentage: CGFloat(current)/CGFloat(goal), width: 180)
                Text("Currently: \(current)KG")
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Start Tracking")
                            Text("Ticket time remaining: 38min").font(.caption)
                        }
                        Spacer()
                    }
                })
                .padding(.vertical)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .navigationBarTitle("Seqour CO₂", displayMode: .inline)
            .navigationBarItems(trailing:
                VStack {
                    Image(systemName: "calendar")
                    Text("History").font(.caption)
                }
            )
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
