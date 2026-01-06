import SwiftUI

struct splashView: View {
    var body: some View {
        VStack{
            ProgressView("Initializing App")
                .tint(.green)
        }
    }
}

#Preview {
    splashView()
}
