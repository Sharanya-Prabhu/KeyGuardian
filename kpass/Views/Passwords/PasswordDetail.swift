import SwiftUI
import CoreData

struct PasswordDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    let pasteboard = UIPasteboard.general
    var password: Password
    @State private var showPassword = false
    @State var isEditPressed = false
    
    var body: some View {
        ZStack {
            if !isEditPressed {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Username:")
                            .font(.largeTitle)
                        Text(password.username!)
                            .padding(.vertical, 20.0)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Password:")
                            .font(.largeTitle)
                        
                        if !showPassword {
                            Text("**********")
                                .padding(.vertical, 20.0)
                        } else {
                            Text(password.password!)
                                .padding(.vertical, 20.0)
                        }
                    }
                    
                    
                    
                    HStack {
                        Spacer()
                        if !showPassword {
                            Button(action: {
                                self.showPassword = true
                            }, label: {
                                Image(systemName: "eye")
                            })
                            
                        } else {
                            Button(action: {
                                self.showPassword = false
                            }, label: {
                                Image(systemName: "eye.slash")
                            })
                        }
                        Spacer()
                        Button(action: {
                            pasteboard.string = password.password
                        }, label: {
                            Image(systemName: "doc.on.doc")
                        })
                        Spacer()
                        Button(action: {
                            self.isEditPressed = true
                        }, label: {
                            Image(systemName: "pencil")
                        })
                        Spacer()
                    }
                    .padding(/*@START_MENU_TOKEN@*/.bottom, 20.0/*@END_MENU_TOKEN@*/)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Date created:")
                            .font(.largeTitle)
                        Text(getCurrentDate(password.dateCreated ?? Date()))
                            .padding(.vertical, 20.0)
                    }
                    
                    Divider()
                    
                    if let expiryDate = getExpiryDate() {
                        VStack(alignment: .leading) {
                            Text("Expiry Date:")
                                .font(.largeTitle)
                            Text(getCurrentDate(expiryDate))
                                .padding(.vertical, 20.0)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle(password.service!)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                EditPasswordForm(model: password, service: password.service!, username: password.username!, password: password.password!, valueFromDetail: $isEditPressed)
            }
            
            
        }
    }
    
    func getExpiryDate() -> Date? {
        guard let dateCreated = password.dateCreated else {
            return nil
        }

        guard password.validityDurationInMonths > 0 else {
            return nil
        }

        let validityDurationInSeconds = TimeInterval(password.validityDurationInMonths * 30 * 24 * 60 * 60)
        return dateCreated.addingTimeInterval(validityDurationInSeconds)
    }
    
    func getCurrentDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.string(from: date)
        }
    
    private func editPassword(_ password: Password) {
        password.username = "Updated"
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct PasswordDetail_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var viewContext2

    static var previews: some View {
        let examplePwd = Password(context: viewContext2)
        examplePwd.service = "Twitter"
        examplePwd.username = "kiriarf"
        examplePwd.password = "Password123!"
        return PasswordDetail(password: examplePwd)
    }
}
