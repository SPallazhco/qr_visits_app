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

Cambiar en el Podfile de la ruta: "qr_visits_app/ios/Podfile" la seccion "post_install"

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    # Habilitar permisos usados por permission_handler
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_CAMERA=1',
        'PERMISSION_LOCATION_WHENINUSE=1',
      ]
    end
  end
end

Comandos despues de cambiar podfile:
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter run


¿Cómo Ver los Datos de Prueba?

Cambiar temporalmente a InMemory (solo para testing)

// En providers.dart:20-23
final visitRepositoryProvider = Provider<VisitRepository>((ref) {
    return InMemoryVisitRepository();  // ← Datos en memoria con seeds
});

