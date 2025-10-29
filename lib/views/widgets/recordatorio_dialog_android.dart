import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/recordatorio.dart';
import '../../controllers/recordatorio_controller.dart';

class RecordatorioDialogAndroid extends ConsumerStatefulWidget {
  final Recordatorio? recordatorio;

  const RecordatorioDialogAndroid({super.key, this.recordatorio});

  @override
  ConsumerState<RecordatorioDialogAndroid> createState() =>
      _RecordatorioDialogAndroidState();
}

class _RecordatorioDialogAndroidState
    extends ConsumerState<RecordatorioDialogAndroid> {
  late TextEditingController _tituloController;
  late Set<int> _diasSeleccionados;
  late int _hora;
  late int _minuto;
  bool _esPM = false;
  String _sonido = 'default';

  @override
  void initState() {
    super.initState();
    _tituloController =
        TextEditingController(text: widget.recordatorio?.titulo ?? 'Ejercicio');
    _diasSeleccionados = widget.recordatorio?.diasSemana.toSet() ?? {};
    _sonido = widget.recordatorio?.sonido ?? 'default';

    if (widget.recordatorio != null) {
      final parts = widget.recordatorio!.hora.split(':');
      int hora24 = int.parse(parts[0]);
      _minuto = int.parse(parts[1]);

      if (hora24 >= 12) {
        _esPM = true;
        _hora = hora24 == 12 ? 12 : hora24 - 12;
      } else {
        _esPM = false;
        _hora = hora24 == 0 ? 12 : hora24;
      }
    } else {
      _hora = 9;
      _minuto = 0;
      _esPM = false;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  String get _horaFormato24 {
    int hora24;
    if (_esPM) {
      hora24 = _hora == 12 ? 12 : _hora + 12;
    } else {
      hora24 = _hora == 12 ? 0 : _hora;
    }
    return '${hora24.toString().padLeft(2, '0')}:${_minuto.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.recordatorio != null;

    return Dialog(
      backgroundColor: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 650),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    isEdit ? 'Editar alarma' : 'Nueva alarma',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          color: Colors.white, size: 20),
                    ),
                    onPressed: _guardar,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Selector de hora (estilo iOS/Android)
                    _buildTimeSelector(),

                    const SizedBox(height: 24),

                    // Opciones
                    _buildOptionsList(),

                    // Botón eliminar (solo en edición)
                    if (isEdit) ...[
                      const SizedBox(height: 16),
                      _buildDeleteButton(),
                    ],

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Horas
          Expanded(
            child: _buildScrollPicker(
              itemCount: 12,
              initialIndex: _hora - 1,
              onChanged: (index) {
                setState(() => _hora = index + 1);
              },
              itemBuilder: (index) {
                final hour = index + 1;
                return Center(
                  child: Text(
                    hour.toString(),
                    style: TextStyle(
                      color:
                          _hora == hour ? Colors.white : Colors.grey.shade600,
                      fontSize: _hora == hour ? 48 : 28,
                      fontWeight:
                          _hora == hour ? FontWeight.w300 : FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),

          // Separador
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              ':',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w300),
            ),
          ),

          // Minutos
          Expanded(
            child: _buildScrollPicker(
              itemCount: 60,
              initialIndex: _minuto,
              onChanged: (index) {
                setState(() => _minuto = index);
              },
              itemBuilder: (index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: _minuto == index
                          ? Colors.white
                          : Colors.grey.shade600,
                      fontSize: _minuto == index ? 48 : 28,
                      fontWeight:
                          _minuto == index ? FontWeight.w300 : FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          // AM/PM
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() => _esPM = false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: !_esPM ? Colors.orange : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'a.m.',
                    style: TextStyle(
                      color: !_esPM ? Colors.white : Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _esPM = true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _esPM ? Colors.orange : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'p.m.',
                    style: TextStyle(
                      color: _esPM ? Colors.white : Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScrollPicker({
    required int itemCount,
    required int initialIndex,
    required Function(int) onChanged,
    required Widget Function(int) itemBuilder,
  }) {
    return ListWheelScrollView.useDelegate(
      itemExtent: 60,
      diameterRatio: 1.5,
      physics: const FixedExtentScrollPhysics(),
      controller: FixedExtentScrollController(initialItem: initialIndex),
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          if (index < 0 || index >= itemCount) return null;
          return itemBuilder(index);
        },
        childCount: itemCount,
      ),
    );
  }

  Widget _buildOptionsList() {
    final diasAbrev = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];

    String repetirTexto = 'Nunca';
    if (_diasSeleccionados.length == 7) {
      repetirTexto = 'Todos los días';
    } else if (_diasSeleccionados.length == 5 &&
        _diasSeleccionados.containsAll([1, 2, 3, 4, 5])) {
      repetirTexto = 'Días laborables';
    } else if (_diasSeleccionados.isNotEmpty) {
      repetirTexto = _diasSeleccionados.map((d) => diasAbrev[d]).join(', ');
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildOption(
            'Repetir',
            repetirTexto,
            onTap: () => _showRepeatDialog(),
          ),
          _buildDivider(),
          _buildOption(
            'Etiqueta',
            _tituloController.text.isEmpty ? 'Alarma' : _tituloController.text,
            onTap: () => _showLabelDialog(),
          ),
          _buildDivider(),
          _buildOption(
            'Sonido',
            _sonidoLabel(),
            onTap: _showSoundDialog,
          ),
        ],
      ),
    );
  }

  String _sonidoLabel() {
    switch (_sonido) {
      case 'silent':
        return 'Silencioso';
      case 'radial':
        return 'Radial';
      case 'campana':
        return 'Campana';
      case 'beep':
        return 'Beep';
      case 'default':
      default:
        return 'Por defecto';
    }
  }

  void _showSoundDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Sonido', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRepeatOption('Por defecto', () {
              setState(() => _sonido = 'default');
              Navigator.pop(context);
            }),
            _buildRepeatOption('Silencioso (solo vibración)', () {
              setState(() => _sonido = 'silent');
              Navigator.pop(context);
            }),
            const Divider(color: Colors.grey),
            const SizedBox(height: 4),
            const Text('Sonidos disponibles',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            _buildRepeatOption('Radial', () {
              setState(() => _sonido = 'radial');
              Navigator.pop(context);
            }),
            _buildRepeatOption('Campana', () {
              setState(() => _sonido = 'campana');
              Navigator.pop(context);
            }),
            _buildRepeatOption('Beep', () {
              setState(() => _sonido = 'beep');
              Navigator.pop(context);
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String label, String value, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                ),
                if (onTap != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Divider(height: 1, color: Colors.grey.shade800),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          if (widget.recordatorio != null) {
            ref
                .read(recordatorioControllerProvider.notifier)
                .eliminarRecordatorio(widget.recordatorio!.id);
            Navigator.pop(context);
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              'Eliminar alarma',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRepeatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Repetir', style: TextStyle(color: Colors.white)),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            final diasNombres = [
              'Domingo',
              'Lunes',
              'Martes',
              'Miércoles',
              'Jueves',
              'Viernes',
              'Sábado'
            ];

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRepeatOption('Nunca', () {
                  setState(() => _diasSeleccionados.clear());
                  Navigator.pop(context);
                }),
                _buildRepeatOption('Todos los días', () {
                  setState(() => _diasSeleccionados = {0, 1, 2, 3, 4, 5, 6});
                  Navigator.pop(context);
                }),
                _buildRepeatOption('Días laborables', () {
                  setState(() => _diasSeleccionados = {1, 2, 3, 4, 5});
                  Navigator.pop(context);
                }),
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                const Text(
                  'Personalizado',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: List.generate(7, (index) {
                    final selected = _diasSeleccionados.contains(index);
                    return FilterChip(
                      label: Text(diasNombres[index].substring(0, 3)),
                      selected: selected,
                      onSelected: (value) {
                        setStateDialog(() {
                          if (value) {
                            _diasSeleccionados.add(index);
                          } else {
                            _diasSeleccionados.remove(index);
                          }
                        });
                        setState(() {});
                      },
                      backgroundColor: const Color(0xFF1C1C1E),
                      selectedColor: Colors.orange,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.grey.shade400,
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  Widget _buildRepeatOption(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showLabelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Etiqueta', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _tituloController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Ejercicio',
            hintStyle: TextStyle(color: Colors.grey.shade600),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Aceptar', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  Future<void> _guardar() async {
    if (_diasSeleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos un día para repetir'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final diasOrdenados = _diasSeleccionados.toList()..sort();

      if (widget.recordatorio != null) {
        final updated = widget.recordatorio!
          ..titulo = _tituloController.text.trim().isEmpty
              ? 'Ejercicio'
              : _tituloController.text.trim()
          ..diasSemana = diasOrdenados
          ..hora = _horaFormato24
          ..sonido = _sonido;

        await ref
            .read(recordatorioControllerProvider.notifier)
            .actualizarRecordatorio(updated);
      } else {
        await ref
            .read(recordatorioControllerProvider.notifier)
            .agregarRecordatorio(
              titulo: _tituloController.text.trim().isEmpty
                  ? 'Ejercicio'
                  : _tituloController.text.trim(),
              descripcion: null,
              diasSemana: diasOrdenados,
              hora: _horaFormato24,
              sonido: _sonido,
            );
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.recordatorio != null
                ? 'Alarma actualizada'
                : 'Alarma creada'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Error: $e';

        if (e.toString().contains('exact_alarms_not_permitted')) {
          errorMessage =
              'Debes otorgar permiso de "Alarmas y recordatorios" en la configuración de la app';
        } else if (e.toString().contains('permisos')) {
          errorMessage =
              'Se requieren permisos de notificaciones para crear alarmas';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }
}
