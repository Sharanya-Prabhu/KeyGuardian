# kpass (work in progress!)
kpass is a simple-to-use password manager app. I built it for two reasons:

1. To try native app development and Swift.

2. I don't like any of the existing password managers. I wanted to have something that I can use quickly and without an internet connection to ensure that my data is not going anywhere (except for Apple, in this case).

kpass utilises Apple's Core Data framework to ensure persistence of your data even when the app is closed. It also uses FaceID for locking the app away from unwanted users. If the app is put into background, it will immediately lock itself.

Please note, the UI, and some of the features (e.g. the Settings tab) are still unfinished. 

## Tech Stack

| Technology          | Use                               |
| ------------------- | --------------------------------- |
| Swift               | Language                          |
| SwiftUI             | Creating views                    |
| Core Data           | Data persistence on flash storage |
| LocalAuthentication | Locking the app behind FaceID     |


## Setup

1. [Install Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12)  
2. While that is downloading (it's a big one), clone this repo.  
3. Open the repo with Xcode.  

### If You Have an iPhone with FaceID
1. Connect it to your computer and choose it as the simulator device.  
<img src="screenshots/iphonesim.png" width="600">  
2. Build the project. 
3. Accept the FaceID request.  
4. Click Unlock Password and use FaceID.  

### If You Don't Have an iPhone with FaceID
1. Choose iPhone X or later.  
<img src="screenshots/xcodesim.png" width="600">  
2. Build the project.  
3. Got to Feature > FaceID > Enrolled.  
<img src="screenshots/enrolled.png" width="600">  
4. Click Unlock Passwords button.  
5. Go to Features > FaceID > Matching Face.  
<img src="screenshots/matchingface.png" width="600">  

## How to Use

If you don't have any passwords, you will be greeted with this screen on the All Passwords page:   
<img src="screenshots/empty.png" width="300">  

### Adding a Password

Go to the New Password tab, and fill in the form:     
<img src="screenshots/addpwd1.png" width="300">  

Note: the Add Password button will only show up once all the fields are not blank. You can also use the Show toggle to see what you're typing.

### Using Your Passwords

Once you have something saved, you can go back to the All Passwords tab, where you will find your list.  
<img src="screenshots/allpwds.png" width="300">  

Tap on one of the items, and you will be taken to a detail screen:  
<img src="screenshots/google.png" width="300">       

On this screen, you have three buttons: 
1. The eye button will show or hide your password.  
<img src="screenshots/show.png" width="150">
2. The copy button will copy the password to your clipboard.   
3. The pencil button will take you to the Edit Password page.   
<img src="screenshots/editpwd.png" width="250">

## Bugs
- All passwords page -> Title not showing 
- Padding in PasswordDetail wrong 
