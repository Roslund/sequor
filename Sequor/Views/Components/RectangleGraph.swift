import SwiftUI

/// A rectangular graph, like a single bar in a bar graph.
struct RectangleGraph: View {
    // Needed for animation
    @State private var statePercentage: CGFloat = 0

    /// Should be between 0 and 1.
    var percentage: CGFloat
    var width: CGFloat = 140
    var height: CGFloat = 400
    var corenerRadius: CGFloat = 25
    var color: Color = .green

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(color.opacity(0.3))
                .frame(width: width, height: height)

            Rectangle()
                .fill(color)
                .frame(width: width, height: percentage * height)
        }
        .cornerRadius(corenerRadius)
        .onAppear {
            withAnimation {
                self.statePercentage = self.percentage
            }
        }
    }

}

struct RectangleGraph_Previews: PreviewProvider {
    static var previews: some View {
        RectangleGraph(percentage: 0.7, width: 300)
    }
}
