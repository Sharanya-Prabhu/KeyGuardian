import SwiftUI
import CoreData

struct PasswordRow: View {
    var password: Password
    
    var body: some View {
        HStack {
            Text(password.service!)
                .font(.title)
        }
    }
}

struct PasswordRow_Previews: PreviewProvider {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Password.service, ascending: true)],
        animation: .default)
    static var passwords: FetchedResults<Password>
    
    static var previews: some View {
        PasswordRow(password: passwords[0])
    }
}
