# CONTACTFLOW

## DESCRIPTION OF THE APP
Contactflow is an amazing contact app that allows users to save contact information on the app. A user is expevted to register on the app and then is given the access to store, fetch, modify or delete contacts on the application and the information is well secured and protected within the app. The user interface of the app is nice and intuitive to use.

## DESCRIPTION OF CODE BASE
The code base is structured with a total number of 5 folders which I used to structure my app in a very clean and orderlly manner. The first folder is named "model" and it contains the model structure file of the api responses. The next folder is called "providers" and it houses the provider file which contains the api call and some state management code. The next folder is called "screens" which contains all the screen files in the app. The next folder is named widgets and it contains all the extracted widgets in the app. The last folder is called "styles" and it contains the styling file of the app.

## HOW TO USE THE APP
After launching the app the first screen that comes up is the splash screen and it displays the logo of the app for 3 seconds. Then it moves to the login page where a user is expected to put in their login credentials to login to the app. A sign up option is also created for users who have do not have an account. After login in to the app the users name is displayed at the top of the screen and the list of all contacts saved on the app is loaded on the screen. If there are no saved contacts created yet, an information is then provided to direct the user on how to create contacts(contacts can be created by clicking the + icon at the lower left part of the screen). A user can modify or even delete the contact information.

## DESCRIPTION OF LIBRARIES USED
1. ### Provider
   I made use of the provider state management tool in the implementation of my API call and sharing of data within the app.
   
2. ### http
   I made use of the http package to enable me make network calls to the API.

3. ### shared_preferences
   I made use of shared_preferences to store and retrieve username information.
   
4. ### flutter_native_splash
   I made use of flutter native splash to implement a splash screen and also to remove the white screen that comes up at the start of flutter apps.

## CHALLENGES FACED AND HOW I OVERCAME
   There were no major challenges while building this app.
   
## FEATURES I WOULD LOVE TO ADD IF I HAD MORE TIME
   Automatic language detector.
   
## LINK TO THE APK UPLOADED ON GOOGLEDRIVE
  https://drive.google.com/file/d/1qWlNbwdGhUwBsZdgyndcSetJv4vC9DSS/view?usp=drive_link
