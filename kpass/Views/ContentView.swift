import SwiftUI
import CoreData
import LocalAuthentication

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isUnlocked = false

    var body: some View {
        
        ZStack {
            if isUnlocked {
                TabView {
                    PasswordList()
                        .tabItem {
                            Text("All Passwords")
                            Image(systemName: "tray.full.fill")
                        }
                        .tag(1)
                    AddPasswordForm()
                        .tabItem {
                            Text("New Password")
                            Image(systemName: "square.and.pencil")
                        }
                        .tag(2)

                }
            } else {
                Button("Unlock Passwords") {
                    self.authenticate()
                }
                .buttonStyle(GradientButtonStyle())
            }
            
        }.onReceive(NotificationCenter.default.publisher(for:
            UIApplication.willResignActiveNotification)) {
                _ in
                self.isUnlocked = false
            }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to see your passwords."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate :(")
                    }
                }
            }
        } else {
            // no biometrics
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
