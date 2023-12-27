import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Delete all passwords")
                Text("Dark/light mode")
                Text("Reset master pwd")
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
