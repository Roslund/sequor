//

import SwiftUI

struct CapsuleGraph: View {
    
    // Not the cleanest method but that's the fastest way I've found
    // (Needed for the animation)
    @State private var stateValue: Double = 0
    @State private var stateMaxvalue: Double = 50
    
    var value: Double
    var maxValue: Double
    var textLabel: String
    
    var body: some View {
        VStack {
            
            Text("\(value.twoDecimalPrecision) Kg")
                .font(.title)
            
            ZStack(alignment: .bottom) {
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 140, height: 400)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green)
                    .frame(width: 140, height: CGFloat(stateValue) / CGFloat(stateMaxvalue) * 400)
                
            }
            
            Text(textLabel)
                .font(.title)
        }.onAppear {
            withAnimation {
                self.stateMaxvalue = self.maxValue
                self.stateValue = self.value
            }
        }
    }
    
    func lineSize(recWidth: CGFloat, recHeight: CGFloat) -> CGFloat {
        let recPerimeter = (2 * recWidth) + (2 * recHeight)
        return recWidth / recPerimeter
    }
    
}

struct CapsuleGraph_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleGraph(value: 23.4, maxValue: 50.0, textLabel: "CO2 saved")
    }
}
