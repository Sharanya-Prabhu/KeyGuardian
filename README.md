
# KeyGuardian – A simple-to-use password manager app

Managing passwords securely in an increasingly digital world is challenging. The aim of the project is to develop an easy-to-use iOS app to manage all your passwords. Proposed methodology includes biometric authentication, encryption algorithms, real-time assessments, and proactive notifications. The value proposition is the reduced burden of managing passwords manually and keeping passwords secure. Expected outcome is the complete development of the app with adequate testing and potential deployment in the app store simplifying password management for everyone.



## Problem Statement

Users face the challenge of securely managing numerous passwords with existing solutions often
compromising security or lacking user-friendly interfaces. KeyGuardian aims to address these issues by offering a sophisticated, secure, and intuitive password management solution, enhancing both security and user experience.
## User Stories

1. As a user I want to effortlessly access my password manager using Face ID for a seamless and secure experience.
2. As a user I need the ability to add, edit, view, and copy passwords easily to efficiently manage my diverse online accounts.
3. As a user I want the assurance of offline accessibility, ensuring I can access my passwords anytime, even without an internet connection.
4. As a user I desire a strong password suggestions/generator feature to assist me in creating and maintaining secure and unique passwords.
5. As a user I need a password strength checker to evaluate and improve the security of my existing passwords.
6. As a user I expect timely alerts for passwords nearing expiration, enhancing my proactive approach to maintaining digital security.


## Testing
### GUI Testing
• All Passwords tab must show passwords under two sections, valid and expired (if not empty).

• New Password tab must show a form for adding a new password. It should also contain a password generator button, a password strength checker and ability to input expiration period (if it exists).

• Password details should show all necessary details including expiration date (if it exists).

• Edit password page shows password edit form.

### Features testing
1. User opens the app. User unlocks app using FaceID. User views valid and expired passwords.
2. User unlocks the app. User opens New Password tab and fills in the form. User opens All Passwords tab and sees updated list.
3. User unlocks the app. User clicks on a password to show details. User can view and copy password. User clicks edit button to update password. User navigates back to All Passwords tab and sees updated password.
4. User unlocks the app. User opens New Password tab and fills in the form. When typing the password, user sees the Password strength checker label change from Weak, to Moderate to Strong.
5. User unlocks the app. User opens New Password tab and fills in the form. User uses the Generate a strong password button to generate a random strong password. 

## Conclusion
We have successfully created a password manager app with functionalities to add, edit, view and copy passwords. It is secured through FaceID and contains a password strength checker and strong password generator.

## Future scope: 
- Add functionality for alerting the user as password nears expiry.
- Add logic for encryption and decryption of passwords for increased security.
