# Salud Flutter - Aplicación de Control de Ejercicios

Una aplicación móvil profesional para controlar rutinas de ejercicio, caminatas en la montaña y planificación semanal de entrenamientos.

## 🚀 Características

### ✅ Completadas
- **Dashboard Profesional** con gráficas interactivas (fl_chart)
- **Gestión de Ejercicios** - CRUD completo para crear ejercicios personalizados
- **Rutinas de Entrenamiento** - Organiza ejercicios en rutinas planificadas
- **Cronómetro** para caminatas con historial
- **Calendario Semanal** para planificación de ejercicios
- **Persistencia Local** con Isar Database (más rápida que Hive/SQLite)
- **State Management** moderno con Riverpod 2.x
- **Material Design 3** con tema claro/oscuro
- **Arquitectura MVC** limpia y escalable

## 🛠️ Tecnologías

### Frontend
- **Flutter 3.x** con Material Design 3
- **Riverpod 2.x** - State management moderno
- **Google Fonts** - Tipografía Inter
- **flutter_animate** - Animaciones fluidas

### Base de Datos
- **Isar 3.x** - Base de datos NoSQL ultra rápida
- Preparada para migración a **Firebase**

### Gráficas
- **fl_chart** - Gráficas profesionales (barras, pastel, líneas)

### UI/UX
- **table_calendar** - Calendario interactivo
- **intl** - Internacionalización (español)

## 📁 Arquitectura MVC

```
lib/
├── models/              # Entidades de datos (Isar)
│   ├── ejercicio.dart
│   ├── rutina.dart
│   ├── registro_ejercicio.dart
│   ├── caminata.dart
│   └── plan_semanal.dart
│
├── controllers/         # Lógica de negocio (Riverpod)
│   ├── ejercicio_controller.dart
│   ├── rutina_controller.dart
│   ├── registro_controller.dart
│   ├── caminata_controller.dart
│   ├── cronometro_controller.dart
│   └── calendario_controller.dart
│
├── views/              # UI
│   └── screens/
│       ├── dashboard_screen.dart
│       ├── rutinas_screen.dart
│       ├── cronometro_screen.dart
│       ├── calendario_screen.dart
│       └── configuracion_screen.dart
│
├── services/           # Servicios (DB, Firebase)
│   └── isar_service.dart
│
├── repositories/       # Capa de abstracción de datos
│   ├── ejercicio_repository.dart
│   ├── rutina_repository.dart
│   ├── registro_repository.dart
│   ├── caminata_repository.dart
│   └── plan_semanal_repository.dart
│
├── config/             # Configuraciones
│   ├── theme.dart
│   └── routes.dart
│
└── main.dart
```

## 🚀 Instalación y Ejecución

### Requisitos
- Flutter SDK 3.0+
- Dart SDK 3.0+

### Pasos

1. **Instalar dependencias:**
```bash
flutter pub get
```

2. **Generar código (Isar):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. **Ejecutar la app:**
```bash
flutter run
```

## 📱 Pantallas

### 1. Dashboard
- Tarjeta de bienvenida personalizada
- Métricas rápidas (ejercicios hoy, caminatas, tiempo)
- Gráfica de progreso semanal (barras)
- Lista de ejercicios del día
- Gráfica de distribución por tipo (pastel)

### 2. Configuración de Ejercicios
- Lista de ejercicios agrupados por tipo
- Crear/editar/eliminar ejercicios
- Tipos: Fuerza, Cardio, Flexibilidad, Otro
- Grupos musculares: Pecho, espalda, piernas, brazos, hombros, core

### 3. Rutinas
- Crear rutinas con múltiples ejercicios
- Asignar días de la semana
- Ejecutar rutinas con seguimiento de series
- Registro automático al finalizar

### 4. Cronómetro
- Cronómetro con inicio/pausa/reiniciar
- Guardar caminatas con ubicación y notas
- Historial de caminatas
- Estadísticas de tiempo y distancia

### 5. Calendario
- Vista mensual interactiva
- Planificación semanal de rutinas
- Marcar días como completados
- Visualización de rutinas por día

## 🔥 Migración a Firebase (Preparada)

La arquitectura está preparada para migración a Firebase:

```dart
// En services/firebase_service.dart (futuro)
class FirebaseService {
  // Sincronización automática
  Future<void> syncEjercicios() async { }
  Future<void> syncRutinas() async { }
  Future<void> syncRegistros() async { }
}

// Cada modelo tiene campo firebaseId
class Ejercicio {
  String? firebaseId; // ✅ Preparado
}
```

### Pasos para migrar:
1. Agregar `firebase_core` y `cloud_firestore`
2. Implementar `FirebaseService`
3. Activar sincronización en repositorios
4. Mantener Isar para cache local

## 🎨 Tema y Diseño

- **Material Design 3**
- **Tema claro/oscuro** automático
- **Colores modernos**: Indigo, Púrpura, Verde
- **Tipografía**: Google Fonts Inter
- **Componentes**: Tarjetas elevadas, bordes redondeados, sombras sutiles

## 📊 Base de Datos

### Colecciones Isar:
- `ejercicios` - Ejercicios personalizados
- `rutinas` - Rutinas de entrenamiento
- `registroEjercicios` - Historial de ejercicios
- `caminatas` - Sesiones de caminata
- `planSemanals` - Planificación semanal

### Ventajas de Isar:
- ⚡ 10x más rápida que SQLite
- 📦 Sin dependencias nativas
- 🔍 Queries reactivos con Streams
- 💾 Compresión automática
- 🐛 Inspector de base de datos

## 🔜 Próximas Funcionalidades

- [ ] Sincronización con Firebase
- [ ] Autenticación de usuarios
- [ ] Compartir rutinas entre usuarios
- [ ] Fotos de progreso
- [ ] Gráficas de progreso a largo plazo
- [ ] Notificaciones de recordatorio
- [ ] Exportar datos a PDF/CSV
- [ ] Integración con smartwatch

## 📄 Licencia

MIT License

## 👨‍💻 Desarrollo

Aplicación desarrollada con las tecnologías más modernas de Flutter.
Arquitectura MVC limpia, escalable y lista para producción.
