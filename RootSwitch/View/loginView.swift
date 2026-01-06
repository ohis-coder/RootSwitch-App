import SwiftUI

struct loginView: View {
    var onSuccess: () -> Void
    
    var body: some View {
        VStack(spacing:20){
            Text("Welcome Back User")
            Button("login") {onSuccess()}
                .buttonStyle(.borderedProminent)
        }
    }
}


#Preview {
    loginView{}
}
