import SwiftUI
import CoreData
import UIKit

struct AddPasswordForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var service: String = ""
    @State private var username: String = ""
    @State private var password: String = "" {
        didSet {
            updatePasswordStrength()
        }
    }
    @State private var doesExpire = false
    @State private var validityDurationInMonths = 3
    
    @State private var dateCreated: Date = Date() // Add the dateCreated field
    @State private var showPassword = false
    @State private var isSuccessful = false
    @State private var passwordStrength: String = "Weak"
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                            Section(header: Text("SERVICE")) {
                                TextField("Twitter", text: $service)
                            }

                            Section(header: Text("USERNAME")) {
                                TextField("John", text: $username)
                            }

                            Section(header: Text("PASSWORD")) {
                                
                                HStack {
                                        if !showPassword {
                                            SecureField("********", text: $password).onChange(of: password) { newValue in
                                                updatePasswordStrength()
                                            }
                                        } else {
                                            TextField("Qwerty123", text: $password).onChange(of: password) { newValue in
                                                updatePasswordStrength()
                                            }
                                        }
                                        Button(action: {
                                            showPassword.toggle()
                                        }) {
                                            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Text("\(passwordStrength) password")
                                        .foregroundColor(passwordColor())
                                    
                                Button(action: {
                                        password = generateRandomPassword()
                                        }, label: {
                                            Text("Generate a strong password")
                                        }
                                    )
                            }

                            // DatePicker for dateCreated
                            Section(header: Text("DATE CREATED")) {
                                DatePicker("Select Date", selection: $dateCreated, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                                                    .datePickerStyle(DefaultDatePickerStyle())
                            }

                            Section(header: Text("PASSWORD EXPIRATION")) {
                               Toggle("Expires", isOn: $doesExpire)
                               
                                if doesExpire {
                                    HStack {
                                        Text("Validity Duration (months)")
                                        Spacer()
                                        
                                        Picker("", selection: $validityDurationInMonths) {
                                            ForEach(1...60, id: \.self) {
                                                Text("\($0)")
                                            }
                                        }
                                        .pickerStyle(WheelPickerStyle())
                                        .frame(width: 80, height: 40)
                                    }
                                }
                           }
                    
                            // Show button to add password only when all fields filled in
                            Button(action: {
                                        addPassword()
                                        self.isSuccessful = true
                                        self.hideKeyboard()
                                    }, label: {
                                        Text("Add Password")
                                    })
                                    .alert(isPresented: $isSuccessful) {
                                        Alert(title: Text("Success!"), message: Text("Password for \(service) saved"), dismissButton: .default(Text("Got it!")) {
                                            self.clearFields()
                                        })
                                    }
                                    .disabled(!isInfoValid())
                        }
                        .navigationBarTitle("New Password")
            }
        }
    }
    
    //check if all fields have values
    private func isInfoValid() -> Bool {
        if service.isEmpty {
            return false
        }
        if username.isEmpty {
            return false
        }
        if password.isEmpty {
            return false
        }
        return true
    }
    
    private func clearFields() {
        self.service = ""
        self.username = ""
        self.password = ""
    }
    
    //create a new instance of Password with values from text fields and try save it
    private func addPassword() {
        let newPassword = Password(context: viewContext)
        newPassword.service = service
        newPassword.username = username
        newPassword.password = password
        newPassword.dateCreated = dateCreated
        newPassword.validityDurationInMonths = Int64(validityDurationInMonths)
        newPassword.doesExpire = doesExpire
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func generateRandomPassword() -> String {
        // Implement your logic to generate a random strong password
        // This is just a basic example, you may want to use a more sophisticated algorithm
        let passwordLength = 12
        let passwordCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:'\",.<>/?"
        let password = (0..<passwordLength).map { _ in
            passwordCharacters.randomElement()!
        }
        return String(password)
    }
    
    func updatePasswordStrength() {
           // Implement your password strength checking logic
           // This is a basic example; you may want to use a more sophisticated algorithm
           let strength = PasswordStrengthChecker.checkStrength(password)
           passwordStrength = strength.rawValue
    }
    
    func passwordColor() -> Color {
            // Define colors based on password strength
            switch passwordStrength {
            case "Weak":
                return .red
            case "Moderate":
                return .orange
            case "Strong":
                return .green
            default:
                return .black
            }
        }
}

// A basic password strength checker
enum PasswordStrength: String {
    case Weak = "Weak"
    case Moderate = "Moderate"
    case Strong = "Strong"
}

struct PasswordStrengthChecker {
    static func checkStrength(_ password: String) -> PasswordStrength {
        // Implement your password strength checking logic here
        // This is a basic example; you may want to use a more sophisticated algorithm
        var strength = 0

        // Check for common passwords
        if isCommonPassword(password) {
            return .Weak
        }

        // Check length
        let length = password.count
        switch length {
        case 0...5:
            strength += 1
        case 6...10:
            strength += 2
        default:
            strength += 3
        }

        // Check for uppercase letters
        let uppercasePattern = ".*[A-Z]+.*"
        if NSPredicate(format: "SELF MATCHES %@", uppercasePattern).evaluate(with: password) {
            strength += 1
        }

        // Check for lowercase letters
        let lowercasePattern = ".*[a-z]+.*"
        if NSPredicate(format: "SELF MATCHES %@", lowercasePattern).evaluate(with: password) {
            strength += 1
        }

        // Check for numbers
        let numberPattern = ".*[0-9]+.*"
        if NSPredicate(format: "SELF MATCHES %@", numberPattern).evaluate(with: password) {
            strength += 1
        }

        // Check for special characters
        let specialCharacterPattern = ".*[!@#$%^&*()_+\\-=\\[\\]{};:'\",.<>/?]+.*"
        if NSPredicate(format: "SELF MATCHES %@", specialCharacterPattern).evaluate(with: password) {
            strength += 1
        }

        // Evaluate overall strength
        switch strength {
        case 0...2:
            return .Weak
        case 3...5:
            return .Moderate
        default:
            return .Strong
        }
    }

    static func isCommonPassword(_ password: String) -> Bool {
        // Implement logic to check against a list of common passwords
        let commonPasswords = ["password", "123456", "qwerty", "abc123", "password123"]
        return commonPasswords.contains(password.lowercased())
    }
}


struct AddPasswordForm_Previews: PreviewProvider {
    static var previews: some View {
        AddPasswordForm()
    }
}
