// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordatorio.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecordatorioCollection on Isar {
  IsarCollection<Recordatorio> get recordatorios => this.collection();
}

const RecordatorioSchema = CollectionSchema(
  name: r'Recordatorio',
  id: -4733392926757800545,
  properties: {
    r'activo': PropertySchema(
      id: 0,
      name: r'activo',
      type: IsarType.bool,
    ),
    r'descripcion': PropertySchema(
      id: 1,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'diasSemana': PropertySchema(
      id: 2,
      name: r'diasSemana',
      type: IsarType.longList,
    ),
    r'fechaCreacion': PropertySchema(
      id: 3,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'hora': PropertySchema(
      id: 4,
      name: r'hora',
      type: IsarType.string,
    ),
    r'notificationIds': PropertySchema(
      id: 5,
      name: r'notificationIds',
      type: IsarType.longList,
    ),
    r'sonido': PropertySchema(
      id: 6,
      name: r'sonido',
      type: IsarType.string,
    ),
    r'titulo': PropertySchema(
      id: 7,
      name: r'titulo',
      type: IsarType.string,
    ),
    r'ultimaNotificacion': PropertySchema(
      id: 8,
      name: r'ultimaNotificacion',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _recordatorioEstimateSize,
  serialize: _recordatorioSerialize,
  deserialize: _recordatorioDeserialize,
  deserializeProp: _recordatorioDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recordatorioGetId,
  getLinks: _recordatorioGetLinks,
  attach: _recordatorioAttach,
  version: '3.1.0+1',
);

int _recordatorioEstimateSize(
  Recordatorio object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.descripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.diasSemana.length * 8;
  bytesCount += 3 + object.hora.length * 3;
  bytesCount += 3 + object.notificationIds.length * 8;
  {
    final value = object.sonido;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.titulo.length * 3;
  return bytesCount;
}

void _recordatorioSerialize(
  Recordatorio object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.activo);
  writer.writeString(offsets[1], object.descripcion);
  writer.writeLongList(offsets[2], object.diasSemana);
  writer.writeDateTime(offsets[3], object.fechaCreacion);
  writer.writeString(offsets[4], object.hora);
  writer.writeLongList(offsets[5], object.notificationIds);
  writer.writeString(offsets[6], object.sonido);
  writer.writeString(offsets[7], object.titulo);
  writer.writeDateTime(offsets[8], object.ultimaNotificacion);
}

Recordatorio _recordatorioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Recordatorio();
  object.activo = reader.readBool(offsets[0]);
  object.descripcion = reader.readStringOrNull(offsets[1]);
  object.diasSemana = reader.readLongList(offsets[2]) ?? [];
  object.fechaCreacion = reader.readDateTime(offsets[3]);
  object.hora = reader.readString(offsets[4]);
  object.id = id;
  object.notificationIds = reader.readLongList(offsets[5]) ?? [];
  object.sonido = reader.readStringOrNull(offsets[6]);
  object.titulo = reader.readString(offsets[7]);
  object.ultimaNotificacion = reader.readDateTimeOrNull(offsets[8]);
  return object;
}

P _recordatorioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLongList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recordatorioGetId(Recordatorio object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recordatorioGetLinks(Recordatorio object) {
  return [];
}

void _recordatorioAttach(
    IsarCollection<dynamic> col, Id id, Recordatorio object) {
  object.id = id;
}

extension RecordatorioQueryWhereSort
    on QueryBuilder<Recordatorio, Recordatorio, QWhere> {
  QueryBuilder<Recordatorio, Recordatorio, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecordatorioQueryWhere
    on QueryBuilder<Recordatorio, Recordatorio, QWhereClause> {
  QueryBuilder<Recordatorio, Recordatorio, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecordatorioQueryFilter
    on QueryBuilder<Recordatorio, Recordatorio, QFilterCondition> {
  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> activoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activo',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descripcion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diasSemana',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diasSemana',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diasSemana',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diasSemana',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diasSemana',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diasSemana',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diasSemana',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diasSemana',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diasSemana',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      diasSemanaLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diasSemana',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      fechaCreacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      fechaCreacionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      fechaCreacionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      fechaCreacionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaCreacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> horaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      horaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> horaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> horaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hora',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      horaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> horaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> horaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hora',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> horaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hora',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      horaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hora',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      horaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hora',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      notificationIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sonido',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sonido',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> sonidoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sonido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sonido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sonido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> sonidoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sonido',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sonido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sonido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sonido',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> sonidoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sonido',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sonido',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      sonidoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sonido',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> tituloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> tituloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titulo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titulo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition> tituloMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titulo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      tituloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titulo',
        value: '',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      ultimaNotificacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ultimaNotificacion',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      ultimaNotificacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ultimaNotificacion',
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      ultimaNotificacionEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ultimaNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      ultimaNotificacionGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ultimaNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      ultimaNotificacionLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ultimaNotificacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterFilterCondition>
      ultimaNotificacionBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ultimaNotificacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecordatorioQueryObject
    on QueryBuilder<Recordatorio, Recordatorio, QFilterCondition> {}

extension RecordatorioQueryLinks
    on QueryBuilder<Recordatorio, Recordatorio, QFilterCondition> {}

extension RecordatorioQuerySortBy
    on QueryBuilder<Recordatorio, Recordatorio, QSortBy> {
  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByActivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByHora() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hora', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByHoraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hora', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortBySonido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonido', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortBySonidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonido', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> sortByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      sortByUltimaNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaNotificacion', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      sortByUltimaNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaNotificacion', Sort.desc);
    });
  }
}

extension RecordatorioQuerySortThenBy
    on QueryBuilder<Recordatorio, Recordatorio, QSortThenBy> {
  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByActivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByHora() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hora', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByHoraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hora', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenBySonido() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonido', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenBySonidoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sonido', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByTitulo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy> thenByTituloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titulo', Sort.desc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      thenByUltimaNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaNotificacion', Sort.asc);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QAfterSortBy>
      thenByUltimaNotificacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ultimaNotificacion', Sort.desc);
    });
  }
}

extension RecordatorioQueryWhereDistinct
    on QueryBuilder<Recordatorio, Recordatorio, QDistinct> {
  QueryBuilder<Recordatorio, Recordatorio, QDistinct> distinctByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activo');
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct> distinctByDescripcion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct> distinctByDiasSemana() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diasSemana');
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct>
      distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct> distinctByHora(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hora', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct>
      distinctByNotificationIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationIds');
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct> distinctBySonido(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sonido', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct> distinctByTitulo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titulo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recordatorio, Recordatorio, QDistinct>
      distinctByUltimaNotificacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ultimaNotificacion');
    });
  }
}

extension RecordatorioQueryProperty
    on QueryBuilder<Recordatorio, Recordatorio, QQueryProperty> {
  QueryBuilder<Recordatorio, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Recordatorio, bool, QQueryOperations> activoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activo');
    });
  }

  QueryBuilder<Recordatorio, String?, QQueryOperations> descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<Recordatorio, List<int>, QQueryOperations> diasSemanaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diasSemana');
    });
  }

  QueryBuilder<Recordatorio, DateTime, QQueryOperations>
      fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<Recordatorio, String, QQueryOperations> horaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hora');
    });
  }

  QueryBuilder<Recordatorio, List<int>, QQueryOperations>
      notificationIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationIds');
    });
  }

  QueryBuilder<Recordatorio, String?, QQueryOperations> sonidoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sonido');
    });
  }

  QueryBuilder<Recordatorio, String, QQueryOperations> tituloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titulo');
    });
  }

  QueryBuilder<Recordatorio, DateTime?, QQueryOperations>
      ultimaNotificacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ultimaNotificacion');
    });
  }
}
