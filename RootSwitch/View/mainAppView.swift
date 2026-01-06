import SwiftUI


struct mainAppContainer: View {
    var onLogout: () -> Void
    var onReset: () -> Void
    
    var body: some View {
        VStack{
            Text("You are in the app")
                .padding()
            Button("Logout", role: .destructive){onLogout()}
                .buttonStyle(.borderedProminent)
            Button("Reset"){onReset()}
                .buttonStyle(.borderedProminent)
        }
    }
}


#Preview {
    mainAppContainer(
        onLogout: {
            print("Logout pressed")
        },
        onReset: {
            print("Reset pressed")
        }
    )
}
