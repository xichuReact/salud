# Configuración de Google Sign-In y Google Drive

Este documento explica cómo configurar Google Sign-In para que la funcionalidad de respaldo en Google Drive funcione correctamente.

## 1. Crear Proyecto en Google Cloud Console

1. Ve a [Google Cloud Console](https://console.cloud.google.com)
2. Inicia sesión con **elpasoxichu@gmail.com**
3. Crea un nuevo proyecto llamado "Salud Fitness" o similar
4. Selecciona el proyecto recién creado

## 2. Habilitar Google Drive API

1. En el menú lateral, ve a **APIs & Services** > **Library**
2. Busca "Google Drive API"
3. Haz clic en "Google Drive API" y luego en **Enable**

## 3. Configurar Pantalla de Consentimiento OAuth

1. Ve a **APIs & Services** > **OAuth consent screen**
2. Selecciona **External** (o **Internal** si es G Suite)
3. Completa la información requerida:
   - **App name**: Salud Fitness
   - **User support email**: elpasoxichu@gmail.com
   - **Developer contact information**: elpasoxichu@gmail.com
4. En **Scopes**, agrega los siguientes permisos:
   - `https://www.googleapis.com/auth/drive.file` (ya configurado en la app)
5. Guarda y continúa

## 4. Crear Credenciales OAuth 2.0

### Para iOS

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en **Create Credentials** > **OAuth client ID**
3. Selecciona **iOS** como tipo de aplicación
4. Completa la información:
   - **Name**: Salud Fitness iOS
   - **Bundle ID**: Encuentra tu Bundle ID en `ios/Runner.xcodeproj/project.pbxproj` buscando `PRODUCT_BUNDLE_IDENTIFIER` (por ejemplo: `com.example.saludFlutter`)
5. Haz clic en **Create**
6. **IMPORTANTE**: Copia el **iOS URL scheme** (reversed client ID, formato: `com.googleusercontent.apps.XXXXXXXX`)

### Para Android

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en **Create Credentials** > **OAuth client ID**
3. Selecciona **Android** como tipo de aplicación
4. Completa la información:
   - **Name**: Salud Fitness Android
   - **Package name**: Encuentra tu package en `android/app/build.gradle.kts` buscando `applicationId` (por ejemplo: `com.example.salud_flutter`)
   - **SHA-1 certificate fingerprint**: Obtén tu SHA-1 con este comando en la terminal:
     ```bash
     cd android
     ./gradlew signingReport
     ```
     Busca la línea `SHA1:` en la sección `debug` y copia el hash
5. Haz clic en **Create**
6. **IMPORTANTE**: Copia el **Client ID** (formato: `XXXXXXXX-XXXXXXXX.apps.googleusercontent.com`)

### Para Web (necesario para Google Sign-In)

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en **Create Credentials** > **OAuth client ID**
3. Selecciona **Web application** como tipo de aplicación
4. Completa la información:
   - **Name**: Salud Fitness Web
5. Haz clic en **Create**
6. **IMPORTANTE**: Copia el **Client ID** (formato: `XXXXXXXX-XXXXXXXX.apps.googleusercontent.com`)

## 5. Configurar iOS

Edita el archivo `ios/Runner/Info.plist` y agrega lo siguiente antes del último `</dict>`:

```xml
<!-- Google Sign-In Configuration -->
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <!-- REEMPLAZA ESTO con tu iOS URL scheme (reversed client ID) -->
      <string>com.googleusercontent.apps.XXXXXXXX-XXXXXXXX</string>
    </array>
  </dict>
</array>

<key>GIDClientID</key>
<!-- REEMPLAZA ESTO con tu Web Client ID -->
<string>XXXXXXXX-XXXXXXXX.apps.googleusercontent.com</string>
```

**Importante**: Reemplaza los valores `XXXXXXXX` con los IDs que copiaste en el paso anterior.

## 6. Configurar Android

Edita el archivo `android/app/build.gradle.kts` y agrega en la sección `defaultConfig`:

```kotlin
android {
    defaultConfig {
        applicationId = "com.example.salud_flutter" // Ya debería estar configurado
        
        // Google Sign-In Configuration
        // REEMPLAZA ESTO con tu Web Client ID
        resValue("string", "default_web_client_id", "XXXXXXXX-XXXXXXXX.apps.googleusercontent.com")
    }
}
```

**Importante**: Reemplaza el valor `XXXXXXXX` con el **Web Client ID** que copiaste.

## 7. Verificar Configuración

1. **iOS**: Abre `ios/Runner/Info.plist` y verifica que:
   - El `CFBundleURLSchemes` tiene el reversed client ID correcto
   - El `GIDClientID` tiene el Web Client ID correcto

2. **Android**: Abre `android/app/build.gradle.kts` y verifica que:
   - El `resValue` tiene el Web Client ID correcto
   - El `applicationId` coincide con el package name registrado en Google Cloud Console

## 8. Probar la Aplicación

1. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

2. Ve al Dashboard y toca el ícono de perfil (persona) en la esquina superior derecha

3. En la pantalla de Perfil, toca "Iniciar sesión con Google"

4. Deberías ver la pantalla de autorización de Google

5. Selecciona la cuenta **elpasoxichu@gmail.com**

6. Otorga los permisos solicitados (acceso a Google Drive)

7. Una vez iniciada la sesión, prueba crear un respaldo:
   - Toca "Crear respaldo"
   - Confirma la acción
   - Espera a que se complete (verás un mensaje de éxito)

8. Verifica en [Google Drive](https://drive.google.com):
   - Inicia sesión con **elpasoxichu@gmail.com**
   - Busca la carpeta "SaludFitnessBackups"
   - Deberías ver el archivo "salud_backup.isar"

9. Prueba restaurar el respaldo:
   - En la app, toca "Restaurar respaldo"
   - Confirma la acción (advertencia: esto reemplazará los datos actuales)
   - Espera a que se complete
   - La app debería volver al inicio con los datos restaurados

## Solución de Problemas

### Error: "DEVELOPER_ERROR" o "Sign in failed"
- Verifica que los Client IDs en iOS y Android coincidan exactamente con los de Google Cloud Console
- Asegúrate de que el Bundle ID (iOS) y Package Name (Android) sean correctos
- Verifica que el SHA-1 fingerprint de Android sea el correcto
- En desarrollo, usa el SHA-1 del keystore de debug

### Error: "Access denied" o "Insufficient permissions"
- Asegúrate de que Google Drive API esté habilitada en Google Cloud Console
- Verifica que el scope `https://www.googleapis.com/auth/drive.file` esté configurado
- Revisa la pantalla de consentimiento OAuth y asegúrate de que esté en modo "Testing" o "Published"

### No se puede crear el respaldo
- Verifica que hayas iniciado sesión correctamente
- Comprueba la conexión a internet
- Revisa los logs de la aplicación con `flutter logs`

### No se puede restaurar el respaldo
- Asegúrate de que exista un respaldo previo en Google Drive
- Verifica que el archivo no esté corrupto
- Comprueba que haya suficiente espacio en el dispositivo

## Notas Adicionales

- Los datos de respaldo se almacenan en la carpeta "SaludFitnessBackups" de Google Drive
- Solo el usuario que ha iniciado sesión puede ver y acceder a sus respaldos
- La app automáticamente actualiza el mismo archivo "salud_backup.isar" en cada respaldo (no crea múltiples versiones)
- En caso de error durante la restauración, la app automáticamente revierte a los datos anteriores
- El historial de versiones de Google Drive mantiene versiones anteriores del archivo de respaldo por 30 días

## Referencias

- [Google Sign-In para Flutter](https://pub.dev/packages/google_sign_in)
- [Google Drive API](https://developers.google.com/drive/api/v3/about-sdk)
- [OAuth 2.0 en Google Cloud](https://developers.google.com/identity/protocols/oauth2)
