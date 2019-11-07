import SwiftUI

struct AccountView: View {
    
    @State private var name: String = "Mattia"
    @State private var surname: String = "Righetti"
    @State private var titles: [String] = ["Kilometers", "Coupons"]
    @State private var values: [Double] = [3.34, 0.47]
    
    var body: some View {
        
        VStack {
                
            Header().frame(height: 100.0, alignment: .center)
            
            VStack {
                Text(name + " " + surname)
                    .font(.system(size: 40.0))
                    .padding(.top, 60.0)
                Spacer()
                HStack(spacing: 30.0) {
                    InfoCard(title: self.$titles[0], value: self.$values[0])
                    InfoCard(title: self.$titles[1], value: self.$values[1])
                }.padding(.horizontal)
                Spacer()
            }.padding(.horizontal, 10.0)
            Spacer()
        }
    }
}

struct Header: View {
    
    private let strokeColor = Color.init(#colorLiteral(red: 0.1118095294, green: 0.1454085112, blue: 0.286516428, alpha: 1))
    
    var body: some View {
        VStack {
            
            Image(systemName: "person.fill")
                .font(.system(size: 60))
                .padding(.all, 30)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(strokeColor, lineWidth: 2.0))
                .offset(CGSize(width: 0, height: 70.0))
            
        }.background(
            
            Image("profile-background")
                .resizable()
                .frame(width: 700.0, height: 190.0, alignment: .topLeading)
                .offset(CGSize(width: 0.0, height: -20.0))
                .edgesIgnoringSafeArea(.top)
            
        )
    }
}

struct InfoCard: View {
    
    @Binding var title: String
    @Binding var value: Double
    
    var body: some View {
        VStack {
            Text(title).font(.title).padding()
            Text(String(value)).font(.title)
        }.padding(.vertical, 30).foregroundColor(Color.white)
            .background(
            Color.red
                .clipShape(RoundedRectangle(cornerRadius: 40.0))
        )
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
