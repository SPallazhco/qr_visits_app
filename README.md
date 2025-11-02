QR Visits App

Flutter app to register visits by scanning QR/barcodes. Offline-first (SQLite/Drift), role-based views, and optional geolocation. Clean separation of presentation / domain / data.

Setup

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run


Android – AndroidManifest.xml

<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-feature android:name="android.hardware.camera" android:required="false"/>

iOS – Podfile

platform :ios, '15.5'

Then cd ios && pod install.

iOS – Info.plist keys

<key>NSCameraUsageDescription</key>
<string>Se requiere acceso a la cámara para escanear códigos QR.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Se requiere la ubicación para registrar la visita con coordenadas.</string>
<key>CFBundleDevelopmentRegion</key>

  ¿Cómo Ver los Datos de Prueba?

Cambiar temporalmente a InMemory (solo para testing)

// En providers.dart:20-23
final visitRepositoryProvider = Provider<VisitRepository>((ref) {
    return InMemoryVisitRepository();  // ← Datos en memoria con seeds
});

