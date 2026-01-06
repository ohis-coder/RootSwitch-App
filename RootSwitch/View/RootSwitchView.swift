import SwiftUI

struct RootSwitchView: View {
    @State var vm = AppViewModel()
    
    var body: some View {
        ZStack{
            Group{
                switch vm.currentRoute {
                case .splash:
                    splashView()
                case .login:
                    loginView(onSuccess: {vm.handle(.loginSuccess)})
                case .mainApp:
                    mainAppContainer(onLogout: {vm.handle(.logout)}, onReset: {vm.handle(.resetApp)})
                }
            }
            .animation(.default, value: vm.currentRoute)
            .task {
                vm.handle(.appStarted)
            }
        }
    }
}


#Preview {
    RootSwitchView()
}
