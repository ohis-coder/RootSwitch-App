RootSwitch App: A LIL DUMB PROJECT (SwiftUI)
Molweniiiii! I am not even South African but here is a disclaimer: “This post is as unprofessional as possible. I have never seen anything like this AND I wrote this, so don’t take it too serious neh.”

Overview
We’re managing 3 states (3 possible views) using a root-switching logic. No complex navigation stacks here—just clean swaps.

Splash: A loading screen.

Login: A login screen.

MainApp: The main screen.

The Enums

Swift is a statically typed language (type-safe). By annotating our variables with these Enums, we tell the compiler exactly what to expect. No "impossible states" allowed.

Swift
```
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
```
The View Model (The Brain)
Since I am not a 90-year-old dev, I use the @Observable macro targeting iOS 17+. I legit can’t be arsed tracking @StateObject, @Published, and the rest while I’m building for my startup.

I also use @MainActor. Why? Because we are altering UI states. That happens on the Main Thread. You want to see the changes? You stay on the main thread. Simple.

Swift
```
import Observation

@Observable 
@MainActor 
class AppViewModel {
    var currentRoute: AppRoute = .splash

    // Switch makes enums EXHAUSTIVE. The compiler forces you to handle every case.
    func handle(_ intent: AppIntent) {
        switch intent {
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
}
```

One-Way Ping No Pong 
Forget fancy architecture terms. Think of it like this:

[Bat 1] = View

[Ball] = State

[Bat 2] = Intent

The intent serves the state to the view. Every intent either selects a new state or resets the flow.

View (State)	Logic	Intent
LoginView(.login)	<---	appStarted
MainAppView(.mainApp)	<---	loginSuccess
LoginView(.login)	<---	logout
(.splash) > LoginView	<---	resetApp
The Views
The views are decoupled. They don't know each other exists. We pass closures (functions-in-a-box) to the buttons. The view doesn't even know it's talking to a ViewModel; it just fires the closure and the VM handles the intent.

Swift
```
// In the Main Router
Group {
    switch vm.currentRoute {
    case .splash:
        splashView()
    case .login:
        loginView(onSuccess: { vm.handle(.loginSuccess) })
    case .mainApp:
        mainAppContainer(onLogout: { vm.handle(.logout) }, onReset: { vm.handle(.resetApp) })
    }
}
```
Spoiler: NavigationStack is the next project. We’re moving from switching roots to pushing paths. Stay tuned.
