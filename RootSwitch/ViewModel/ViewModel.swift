import SwiftUI
import Observation


enum AppRoute {
    case splash
    case login
    case mainApp
}

enum AppIntent {
    case appStarted
    case loginSuccess
    case logout
    case resetApp
}

@Observable @MainActor class AppViewModel {
    var currentRoute: AppRoute = .splash
    
    func handle(_ intent: AppIntent) {
        switch intent{
        case .appStarted:
            checkSession()
        case .loginSuccess:
            currentRoute = .mainApp
        case .logout:
            currentRoute = .login
        case .resetApp:
            currentRoute = .splash
            checkSession()
        }
    }
    
    func checkSession(){
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            currentRoute = .login
        }
    }
}



