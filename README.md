# QR Visits App

<div align="center">

![Flutter Version](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**Aplicación Flutter para registro de visitas mediante escaneo de códigos QR y de barras**

[Características](#características) •
[Instalación](#instalación) •
[Configuración](#configuración) •
[Uso](#uso) •
[Arquitectura](#arquitectura)

</div>

---

## Descripción

QR Visits App es una aplicación móvil robusta diseñada para el registro eficiente de visitas mediante escaneo de códigos QR/barcodes. Construida con Flutter, ofrece funcionalidad offline-first utilizando SQLite/Drift, vistas basadas en roles y geolocalización opcional.

## Características

- **Escaneo QR/Barcode**: Captura rápida de códigos mediante cámara
- **Offline-First**: Funciona sin conexión usando SQLite/Drift
- **Vistas Basadas en Roles**: Diferentes interfaces según permisos
- **Geolocalización**: Registro opcional de coordenadas de visita
- **Arquitectura Limpia**: Separación clara de capas (Presentation / Domain / Data)
- **Sincronización**: Soporte para sincronización de datos cuando hay conexión

## Instalación

### Requisitos Previos

- Flutter SDK 3.0 o superior
- Dart 3.0 o superior
- Android Studio / Xcode (según plataforma)

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/qr-visits-app.git
   cd qr-visits-app
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Generar código necesario**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## Configuración

### Android

Agregar los siguientes permisos en `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Permisos requeridos -->
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    
    <!-- Features opcionales -->
    <uses-feature android:name="android.hardware.camera" android:required="false"/>
    
    <application>
        <!-- ... -->
    </application>
</manifest>
```

### iOS

#### 1. Configurar versión mínima

En `ios/Podfile`, asegurar la versión mínima:

```ruby
platform :ios, '15.5'
```

#### 2. Instalar pods

```bash
cd ios
pod install
cd ..
```

#### 3. Agregar descripciones de permisos

En `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Se requiere acceso a la cámara para escanear códigos QR.</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Se requiere la ubicación para registrar la visita con coordenadas.</string>

<key>CFBundleDevelopmentRegion</key>
<string>es_ES</string>
```

#### 4. Configurar permission_handler

Modificar `ios/Podfile` en la sección `post_install`:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    # Habilitar permisos para permission_handler
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_CAMERA=1',
        'PERMISSION_LOCATION_WHENINUSE=1',
      ]
    end
  end
end
```

#### 5. Reinstalar pods

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

## Uso

### Inicio Rápido

1. Abre la aplicación
2. Selecciona tu rol (Administrador/Usuario)
3. Toca el botón de escanear
4. Apunta la cámara al código QR
5. Confirma los datos de la visita

### Modo de Prueba

Para probar la aplicación con datos de ejemplo en memoria:

#### Cambiar a repositorio InMemory

En `lib/providers.dart` (líneas 20-23):

```dart
final visitRepositoryProvider = Provider<VisitRepository>((ref) {
    return InMemoryVisitRepository();  // ← Datos en memoria con seeds
});
```

> **Nota**: Recuerda revertir este cambio para producción.

## Arquitectura

El proyecto sigue los principios de **Clean Architecture** con tres capas principales:

```
lib/
|-- core/            # Utilidades, Constantes, Extensiones, Configuración
├── presentation/    # UI, Widgets, Pages, Controllers
├── domain/          # Entidades, Casos de Uso, Interfaces
└── data/            # Repositorios, Data Sources, DTOs
```

### Tecnologías Principales

- **Flutter**: Framework UI
- **Riverpod**: Gestión de estado
- **Drift**: Base de datos SQL local
- **mobile_scanner**: Escaneo de códigos
- **geolocator**: Servicios de ubicación
- **permission_handler**: Manejo de permisos


---

<div align="center">
  Hecho con Flutter
</div>