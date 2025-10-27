# 🚀 Guía de Inicio Rápido - Salud Flutter

## Pasos para ejecutar la aplicación

### 1. Instalar dependencias
```bash
flutter pub get
```

### 2. Generar código de Isar y Riverpod
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Ejecutar la aplicación
```bash
flutter run
```

## 📱 Funcionalidades Principales

### Dashboard
- Visualiza tu progreso diario
- Gráficas de progreso semanal
- Métricas rápidas

### Ejercicios (Configuración)
1. Toca el botón "+" flotante
2. Completa el formulario:
   - Nombre del ejercicio
   - Descripción
   - Tipo (fuerza, cardio, flexibilidad)
   - Grupos musculares
3. Guarda tu ejercicio

### Rutinas
1. Ve a la pestaña "Rutinas"
2. Crea una nueva rutina con ejercicios
3. Selecciona días de la semana
4. Ejecuta la rutina y registra tus series

### Cronómetro
1. Ve a la pestaña "Cronómetro"
2. Presiona "Iniciar" para comenzar
3. Puedes pausar y reanudar
4. Al finalizar, guarda tu caminata con detalles

### Calendario
1. Ve a la pestaña "Calendario"
2. Selecciona un día
3. Agrega rutinas al día
4. Marca como completado cuando termines

## 🎯 Datos de Ejemplo

La primera vez que ejecutes la app, se crearán automáticamente 13 ejercicios de ejemplo:

**Fuerza:**
- Press de Banca
- Flexiones
- Dominadas
- Remo con Barra
- Sentadillas
- Peso Muerto
- Plancha
- Abdominales

**Cardio:**
- Correr
- Burpees
- Saltar Cuerda

**Flexibilidad:**
- Yoga
- Estiramientos

## 🔧 Comandos Útiles

### Limpiar y reconstruir
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Ver errores de análisis
```bash
flutter analyze
```

### Ejecutar en modo release
```bash
flutter run --release
```

### Generar APK (Android)
```bash
flutter build apk --release
```

### Generar IPA (iOS)
```bash
flutter build ios --release
```

## 🐛 Solución de Problemas

### Error: "Target of URI hasn't been generated"
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Error: "Isar not initialized"
Asegúrate de que `main.dart` inicialice Isar antes de usar la app.

### Hot Reload no funciona después de cambios en modelos
Después de modificar modelos (archivos con `@collection`), debes:
1. Detener la app
2. Ejecutar `flutter pub run build_runner build --delete-conflicting-outputs`
3. Volver a ejecutar la app

## 📊 Inspeccionar Base de Datos

Isar incluye un inspector web para ver tus datos:

```bash
flutter pub run build_runner serve
```

Luego abre: `http://localhost:8080`

## 🎨 Personalización

### Cambiar colores del tema
Edita `/lib/config/theme.dart`:
```dart
static const Color primaryColor = Color(0xFF6366F1); // Tu color
```

### Agregar nuevos ejercicios por defecto
Edita `/lib/utils/seed_data.dart` y agrega más ejercicios.

## 📱 Próximos Pasos

1. **Crear tus primeros ejercicios personalizados**
2. **Organizar ejercicios en rutinas**
3. **Planificar tu semana en el calendario**
4. **Registrar tus caminatas con el cronómetro**
5. **Ver tu progreso en el dashboard**

## 🔥 Migración a Firebase (Futuro)

Cuando quieras sincronizar con Firebase:

1. Instalar Firebase:
```bash
flutter pub add firebase_core cloud_firestore firebase_auth
```

2. Configurar Firebase en tu proyecto

3. Implementar `FirebaseService` siguiendo la estructura preparada

4. Los modelos ya tienen `firebaseId` listo para sincronización

## 💡 Tips

- Usa el **tema oscuro** desde configuración del sistema
- Los datos se guardan **localmente** en tu dispositivo
- Puedes **exportar/importar** datos (próximamente)
- Todas las gráficas son **interactivas** (toca para ver detalles)

¡Listo! Comienza a entrenar 💪
