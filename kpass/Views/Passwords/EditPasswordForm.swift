import SwiftUI

struct EditPasswordForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    var model: Password
    @State var service: String
    @State var username: String
    @State var password: String
    @Binding var valueFromDetail: Bool
    @State private var isSuccessful = false
    
    var body: some View {
        Form {
            Section(header: Text("USERNAME")) {
                TextField("", text: $username)
            }
            Section(header: Text("PASSWORD")) {
                TextField("", text: $password)
            }
            Button(action: {
                editPassword(model)
                self.isSuccessful = true
                
            }, label: {
                Text("Save Changes")
            })
            .alert(isPresented: $isSuccessful) {
                Alert(title: Text("Success!"), message: Text("Changes for \(service) Saved"), dismissButton: .default(Text("Got it!")) {
                        self.valueFromDetail = false
                    })
            }

        }
    }
    
    
    private func editPassword(_ model: Password) {
        model.username = username
        model.password = password
        model.dateCreated = Date()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//struct EditPasswordForm_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPasswordForm()
//    }
//}
