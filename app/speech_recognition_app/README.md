#  Speech Recognition Login Mobile App  

This project is a **mobile application developed in Flutter** that performs **user authentication based on voice recognition**.  
Users can register as speakers by recording their voice, and later log in using voice authentication to access a personalized screen.

---

##  Features

-  **Speaker Registration**
  - Users register by recording their voice
  - Audio samples are sent to a backend service for processing
-  Clean and Modular Flutter Architecture**
  - Separation of UI, logic, and data layers


---

##  Technologies Used

- **Flutter**: `3.38.5`
- **Dart**
- **REST API communication** (for speaker registration and authentication)
- **Audio recording and playback**
- **Mobile platforms**: Android and iOS

## Run the Project
- Install Dependencies
```
flutter pub get
```

- Configure Backend URL, in the `.env` change:

```
BASE_URL=http://YOUR_BACKEND_IP:PORT
```
- Connect a Device or Start an Emulator, Check available devices:
```
flutter devices
```

- To run on a specific device:
```
flutter run -d <device_id>
```

## Pages

<p align = "center">
  <img src="../../docs/home.png" width="200" />
  <img src="../../docs/register.png" width="200" />
  <img src="../../docs/login.png" width="200" />
  <img src="../../docs/profile.png" width="200" />
</p>
