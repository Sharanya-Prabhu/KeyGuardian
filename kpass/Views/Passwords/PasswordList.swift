import SwiftUI
import CoreData

struct PasswordList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Password.service, ascending: true)],
    animation: .default)
    private var allPasswords: FetchedResults<Password>

    private var validPasswords: [Password] {
        return allPasswords.filter { $0.isValid }
    }

    private var expiredPasswords: [Password] {
        return allPasswords.filter { !$0.isValid }
    }


    var body: some View {
        NavigationView {
            List {
                if !validPasswords.isEmpty {
                    Section(header: Text("Valid Passwords")) {
                        ForEach(validPasswords) { password in
                            NavigationLink(destination: PasswordDetail(password: password)) {
                                PasswordRow(password: password)
                            }
                        }.onDelete(perform: deletePasswords)
                    }
                }

                if !expiredPasswords.isEmpty {
                    Section(header: Text("Expired Passwords")) {
                        ForEach(expiredPasswords) { password in
                            NavigationLink(destination: PasswordDetail(password: password)) {
                                PasswordRow(password: password)
                            }
                        }.onDelete(perform: deletePasswords)
                    }
                }
            }
            .navigationBarTitle("All Passwords")
        }
    }

    private func deletePasswords(offsets: IndexSet) {
        withAnimation {
            offsets.map { validPasswords[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

extension Password {
    var isValid: Bool {
        if doesExpire == false {
            return true
        }
        guard let dateCreated = self.dateCreated else {
            return false
        }

        let validityDurationInSeconds = TimeInterval(self.validityDurationInMonths * 30 * 24 * 60 * 60)
        let expirationDate = dateCreated.addingTimeInterval(validityDurationInSeconds)
        return expirationDate > Date()
    }
}
