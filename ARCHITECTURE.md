# 🏗️ Arquitectura de la Aplicación

## Patrón MVC (Model-View-Controller)

```
┌─────────────────────────────────────────────────────────────┐
│                         VIEW LAYER                           │
│  (views/screens/*.dart)                                      │
│  - UI Components                                             │
│  - Flutter Widgets                                           │
│  - User Interactions                                         │
└───────────────────┬─────────────────────────────────────────┘
                    │ (consume)
                    ↓
┌─────────────────────────────────────────────────────────────┐
│                    CONTROLLER LAYER                          │
│  (controllers/*.dart)                                        │
│  - Business Logic                                            │
│  - State Management (Riverpod)                               │
│  - Event Handling                                            │
└───────────────────┬─────────────────────────────────────────┘
                    │ (use)
                    ↓
┌─────────────────────────────────────────────────────────────┐
│                      MODEL LAYER                             │
│  (models/*.dart, repositories/*.dart, services/*.dart)       │
│  - Data Models (Isar Entities)                               │
│  - Data Access (Repositories)                                │
│  - Database Service                                          │
└─────────────────────────────────────────────────────────────┘
```

## Flujo de Datos

### 1. User Action → View
```dart
// Usuario presiona botón en la UI
ElevatedButton(
  onPressed: () => ref.read(ejercicioControllerProvider.notifier)
                      .crearEjercicio(ejercicio),
)
```

### 2. View → Controller
```dart
// Controller recibe acción y procesa lógica
class EjercicioController extends StateNotifier<AsyncValue<void>> {
  Future<void> crearEjercicio(Ejercicio ejercicio) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(ejercicio); // ← Llama al Repository
    });
  }
}
```

### 3. Controller → Repository
```dart
// Repository maneja acceso a datos
class EjercicioRepository {
  Future<int> save(Ejercicio ejercicio) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.ejercicios.put(ejercicio); // ← BD
    });
  }
}
```

### 4. Repository → Database
```dart
// IsarService abstrae la base de datos
class IsarService {
  Isar get db {
    return _isar!; // Instancia de Isar
  }
}
```

### 5. Database → Repository → Controller → View
```dart
// Stream reactivo notifica cambios a la UI
final ejerciciosProvider = StreamProvider<List<Ejercicio>>((ref) {
  final repository = ref.watch(ejercicioRepositoryProvider);
  return repository.watchAll(); // ← Stream de Isar
});
```

## Componentes Principales

### Models (Entidades de Datos)
```dart
@collection
class Ejercicio {
  Id id = Isar.autoIncrement;
  late String nombre;
  String? descripcion;
  // ... campos
  String? firebaseId; // ← Preparado para Firebase
}
```

**Responsabilidades:**
- Definir estructura de datos
- Anotaciones de Isar (@collection, @Index)
- Validaciones básicas
- Preparación para sincronización (firebaseId)

### Repositories (Acceso a Datos)
```dart
class EjercicioRepository {
  final IsarService _isarService;
  
  Future<List<Ejercicio>> getAll() async { }
  Future<int> save(Ejercicio ejercicio) async { }
  Stream<List<Ejercicio>> watchAll() { }
}
```

**Responsabilidades:**
- CRUD operations
- Queries complejas
- Streams reactivos
- Abstracción de la base de datos
- Futura sincronización con Firebase

### Controllers (Lógica de Negocio)
```dart
class EjercicioController extends StateNotifier<AsyncValue<void>> {
  final EjercicioRepository _repository;
  
  Future<void> crearEjercicio(Ejercicio ejercicio) async { }
  Future<void> eliminarEjercicio(int id) async { }
}
```

**Responsabilidades:**
- Validaciones complejas
- Orquestación de operaciones
- Manejo de estado (loading, error, success)
- Transformación de datos
- Lógica de negocio

### Views (Interfaz de Usuario)
```dart
class ConfiguracionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ejercicios = ref.watch(ejerciciosProvider);
    // ... UI
  }
}
```

**Responsabilidades:**
- Renderizar UI
- Capturar eventos del usuario
- Consumir state de controllers
- Navegación

## State Management con Riverpod

### Providers
```dart
// Service Provider (Singleton)
final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

// Repository Provider
final ejercicioRepositoryProvider = Provider<EjercicioRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return EjercicioRepository(isarService);
});

// Stream Provider (Reactivo)
final ejerciciosProvider = StreamProvider<List<Ejercicio>>((ref) {
  final repository = ref.watch(ejercicioRepositoryProvider);
  return repository.watchAll();
});

// State Notifier Provider (Con estado)
final ejercicioControllerProvider = 
    StateNotifierProvider<EjercicioController, AsyncValue<void>>((ref) {
  final repository = ref.watch(ejercicioRepositoryProvider);
  return EjercicioController(repository);
});
```

### Consumir Providers en UI
```dart
// StreamProvider
final ejercicios = ref.watch(ejerciciosProvider);
ejercicios.when(
  data: (list) => _buildList(list),
  loading: () => CircularProgressIndicator(),
  error: (e, _) => Text('Error: $e'),
);

// StateNotifier - Leer acción
ref.read(ejercicioControllerProvider.notifier).crearEjercicio(ejercicio);

// StateNotifier - Watch estado
final state = ref.watch(ejercicioControllerProvider);
```

## Base de Datos Isar

### Ventajas
- ⚡ **Velocidad**: 10x más rápida que SQLite
- 📦 **Sin dependencias**: No requiere código nativo
- 🔄 **Reactiva**: Streams automáticos con `.watch()`
- 💾 **Eficiente**: Compresión automática
- 🐛 **Inspector**: Herramienta web para debug

### Schemas Generados
```bash
flutter pub run build_runner build
```

Genera:
- `ejercicio.g.dart`
- `rutina.g.dart`
- `registro_ejercicio.g.dart`
- etc.

### Queries
```dart
// Simple
await isar.ejercicios.get(id);

// Filtrado
await isar.ejercicios
    .filter()
    .activoEqualTo(true)
    .tipoEqualTo('fuerza')
    .findAll();

// Stream reactivo
isar.ejercicios
    .filter()
    .activoEqualTo(true)
    .watch(fireImmediately: true);
```

## Preparación para Firebase

### Estructura Actual (Local)
```
Usuario → UI → Controller → Repository → Isar → Disco Local
```

### Estructura Futura (Firebase)
```
Usuario → UI → Controller → Repository → {
                                           Isar (Cache) ←→ Sincronización
                                           Firebase (Cloud)
                                         }
```

### Migración
1. **Agregar Firebase SDK**
```yaml
dependencies:
  firebase_core: ^latest
  cloud_firestore: ^latest
  firebase_auth: ^latest
```

2. **Crear FirebaseService**
```dart
class FirebaseService {
  Future<void> syncEjercicio(Ejercicio ejercicio) async {
    if (ejercicio.firebaseId == null) {
      // Crear en Firebase
      final docRef = await FirebaseFirestore.instance
          .collection('ejercicios')
          .add(ejercicio.toMap());
      ejercicio.firebaseId = docRef.id;
      await IsarService().db.ejercicios.put(ejercicio);
    } else {
      // Actualizar en Firebase
      await FirebaseFirestore.instance
          .collection('ejercicios')
          .doc(ejercicio.firebaseId)
          .update(ejercicio.toMap());
    }
  }
}
```

3. **Actualizar Repositories**
```dart
class EjercicioRepository {
  Future<int> save(Ejercicio ejercicio) async {
    // Guardar localmente
    final id = await _isarService.db.writeTxn(() async {
      return await _isarService.db.ejercicios.put(ejercicio);
    });
    
    // Sincronizar con Firebase (si está conectado)
    if (await _connectivityService.isOnline()) {
      await _firebaseService.syncEjercicio(ejercicio);
    }
    
    return id;
  }
}
```

## Testing

### Unit Tests (Models & Repositories)
```dart
test('Ejercicio debe guardar correctamente', () async {
  final isar = await Isar.openTest([EjercicioSchema]);
  final repository = EjercicioRepository(IsarService());
  
  final ejercicio = Ejercicio()..nombre = 'Test';
  await repository.save(ejercicio);
  
  final result = await repository.getAll();
  expect(result.length, 1);
});
```

### Widget Tests (UI)
```dart
testWidgets('Dashboard debe mostrar métricas', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(home: DashboardScreen()),
    ),
  );
  
  expect(find.text('Ejercicios Hoy'), findsOneWidget);
});
```

## Buenas Prácticas

### ✅ DO
- Mantener lógica de negocio en Controllers
- Usar Repositories para acceso a datos
- Implementar streams reactivos para UI en tiempo real
- Manejar errores con `AsyncValue`
- Documentar métodos complejos

### ❌ DON'T
- Acceder a Isar directamente desde Views
- Poner lógica de negocio en Widgets
- Usar setState en lugar de Riverpod
- Olvidar llamar `build_runner` después de cambiar models
- Hardcodear valores (usar constantes)

## Performance

### Optimizaciones Implementadas
- ✅ Lazy loading de datos
- ✅ Streams reactivos (solo actualiza lo necesario)
- ✅ Indexes en Isar para queries rápidas
- ✅ Paginación en listas largas (próximamente)
- ✅ Caché de imágenes (próximamente)

### Monitoring
```dart
// En desarrollo
final stopwatch = Stopwatch()..start();
await repository.getAll();
debugPrint('Query took: ${stopwatch.elapsedMilliseconds}ms');
```

## Escalabilidad

La arquitectura actual soporta:
- ✅ Múltiples fuentes de datos (Isar, Firebase, API REST)
- ✅ Migración entre backends
- ✅ Testing independiente por capas
- ✅ Trabajo en equipo (separación clara)
- ✅ Feature flags
- ✅ Versionado de base de datos

---

**Última actualización:** Octubre 2025
