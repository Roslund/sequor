import SwiftUI

struct LoginView: View {
    
    @State private var userTelephoneNumber = ""
    @Binding var showLoginView: Bool
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 50.0))
            
            HStack {
                Text("Geo-Localization")
                    .font(.largeTitle)
            }
            
            Spacer()
            
            VStack {
                TextField("Type your phone number...", text: $userTelephoneNumber)
                    .padding(EdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1.0)
                    )
            }
            
            Spacer()
            
            VStack {
                Button(action: {
                    self.showLoginView.toggle()
                }, label: {
                    Text("Login")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal, 140)
                        .padding([.top, .bottom], 20)
                        .background(Color.red)
                        .cornerRadius(15)
                })
            }
        }.padding(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    @State private static var showLoginView: Bool = true
    
    static var previews: some View {
        LoginView(showLoginView: $showLoginView)
    }
}
