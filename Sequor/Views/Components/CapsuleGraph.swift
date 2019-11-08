import SwiftUI

struct CapsuleGraph: View {
    
    var value: Double = 0
    var maxvalue: Double = 50
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
                    .frame(width: 140, height: CGFloat(value) / CGFloat(maxvalue) * 400)
                
            }
            
            Text(textLabel)
                .font(.title)
        }
    }
    
    func lineSize(recWidth: CGFloat, recHeight: CGFloat) -> CGFloat {
        let recPerimeter = (2 * recWidth) + (2 * recHeight)
        return recWidth / recPerimeter
    }
    
}

struct CapsuleGraph_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleGraph(value: 23.4, maxvalue: 50.0, textLabel: "CO2 saved")
    }
}
