// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rutina.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRutinaCollection on Isar {
  IsarCollection<Rutina> get rutinas => this.collection();
}

const RutinaSchema = CollectionSchema(
  name: r'Rutina',
  id: -9135922940175329254,
  properties: {
    r'activa': PropertySchema(
      id: 0,
      name: r'activa',
      type: IsarType.bool,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.string,
    ),
    r'descripcion': PropertySchema(
      id: 2,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'diasSemana': PropertySchema(
      id: 3,
      name: r'diasSemana',
      type: IsarType.longList,
    ),
    r'duracionEstimada': PropertySchema(
      id: 4,
      name: r'duracionEstimada',
      type: IsarType.long,
    ),
    r'ejercicios': PropertySchema(
      id: 5,
      name: r'ejercicios',
      type: IsarType.objectList,
      target: r'EjercicioRutina',
    ),
    r'fechaCreacion': PropertySchema(
      id: 6,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 7,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 8,
      name: r'nombre',
      type: IsarType.string,
    )
  },
  estimateSize: _rutinaEstimateSize,
  serialize: _rutinaSerialize,
  deserialize: _rutinaDeserialize,
  deserializeProp: _rutinaDeserializeProp,
  idName: r'id',
  indexes: {
    r'nombre': IndexSchema(
      id: -8239814765453414572,
      name: r'nombre',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nombre',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'EjercicioRutina': EjercicioRutinaSchema},
  getId: _rutinaGetId,
  getLinks: _rutinaGetLinks,
  attach: _rutinaAttach,
  version: '3.1.0+1',
);

int _rutinaEstimateSize(
  Rutina object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.descripcion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.diasSemana.length * 8;
  bytesCount += 3 + object.ejercicios.length * 3;
  {
    final offsets = allOffsets[EjercicioRutina]!;
    for (var i = 0; i < object.ejercicios.length; i++) {
      final value = object.ejercicios[i];
      bytesCount +=
          EjercicioRutinaSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.firebaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  return bytesCount;
}

void _rutinaSerialize(
  Rutina object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.activa);
  writer.writeString(offsets[1], object.color);
  writer.writeString(offsets[2], object.descripcion);
  writer.writeLongList(offsets[3], object.diasSemana);
  writer.writeLong(offsets[4], object.duracionEstimada);
  writer.writeObjectList<EjercicioRutina>(
    offsets[5],
    allOffsets,
    EjercicioRutinaSchema.serialize,
    object.ejercicios,
  );
  writer.writeDateTime(offsets[6], object.fechaCreacion);
  writer.writeString(offsets[7], object.firebaseId);
  writer.writeString(offsets[8], object.nombre);
}

Rutina _rutinaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Rutina();
  object.activa = reader.readBool(offsets[0]);
  object.color = reader.readStringOrNull(offsets[1]);
  object.descripcion = reader.readStringOrNull(offsets[2]);
  object.diasSemana = reader.readLongList(offsets[3]) ?? [];
  object.duracionEstimada = reader.readLongOrNull(offsets[4]);
  object.ejercicios = reader.readObjectList<EjercicioRutina>(
        offsets[5],
        EjercicioRutinaSchema.deserialize,
        allOffsets,
        EjercicioRutina(),
      ) ??
      [];
  object.fechaCreacion = reader.readDateTime(offsets[6]);
  object.firebaseId = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.nombre = reader.readString(offsets[8]);
  return object;
}

P _rutinaDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readObjectList<EjercicioRutina>(
            offset,
            EjercicioRutinaSchema.deserialize,
            allOffsets,
            EjercicioRutina(),
          ) ??
          []) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _rutinaGetId(Rutina object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _rutinaGetLinks(Rutina object) {
  return [];
}

void _rutinaAttach(IsarCollection<dynamic> col, Id id, Rutina object) {
  object.id = id;
}

extension RutinaQueryWhereSort on QueryBuilder<Rutina, Rutina, QWhere> {
  QueryBuilder<Rutina, Rutina, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RutinaQueryWhere on QueryBuilder<Rutina, Rutina, QWhereClause> {
  QueryBuilder<Rutina, Rutina, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Rutina, Rutina, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterWhereClause> idBetween(
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

  QueryBuilder<Rutina, Rutina, QAfterWhereClause> nombreEqualTo(String nombre) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nombre',
        value: [nombre],
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterWhereClause> nombreNotEqualTo(
      String nombre) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [],
              upper: [nombre],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [nombre],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [nombre],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nombre',
              lower: [],
              upper: [nombre],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RutinaQueryFilter on QueryBuilder<Rutina, Rutina, QFilterCondition> {
  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> activaEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activa',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionEqualTo(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionGreaterThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionLessThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionBetween(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionStartsWith(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionEndsWith(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diasSemana',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition>
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaElementLessThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaElementBetween(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaLengthEqualTo(
      int length) {
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaIsEmpty() {
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaIsNotEmpty() {
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaLengthLessThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition>
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> diasSemanaLengthBetween(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> duracionEstimadaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duracionEstimada',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition>
      duracionEstimadaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duracionEstimada',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> duracionEstimadaEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracionEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition>
      duracionEstimadaGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duracionEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> duracionEstimadaLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duracionEstimada',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> duracionEstimadaBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duracionEstimada',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> ejerciciosLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ejercicios',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> ejerciciosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ejercicios',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> ejerciciosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ejercicios',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> ejerciciosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ejercicios',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition>
      ejerciciosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ejercicios',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> ejerciciosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ejercicios',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> fechaCreacionEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> fechaCreacionGreaterThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> fechaCreacionLessThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> fechaCreacionBetween(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firebaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }
}

extension RutinaQueryObject on QueryBuilder<Rutina, Rutina, QFilterCondition> {
  QueryBuilder<Rutina, Rutina, QAfterFilterCondition> ejerciciosElement(
      FilterQuery<EjercicioRutina> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ejercicios');
    });
  }
}

extension RutinaQueryLinks on QueryBuilder<Rutina, Rutina, QFilterCondition> {}

extension RutinaQuerySortBy on QueryBuilder<Rutina, Rutina, QSortBy> {
  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByActiva() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByActivaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByDuracionEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionEstimada', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByDuracionEstimadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionEstimada', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension RutinaQuerySortThenBy on QueryBuilder<Rutina, Rutina, QSortThenBy> {
  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByActiva() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByActivaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activa', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByDuracionEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionEstimada', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByDuracionEstimadaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionEstimada', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<Rutina, Rutina, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }
}

extension RutinaQueryWhereDistinct on QueryBuilder<Rutina, Rutina, QDistinct> {
  QueryBuilder<Rutina, Rutina, QDistinct> distinctByActiva() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activa');
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByDescripcion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByDiasSemana() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diasSemana');
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByDuracionEstimada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duracionEstimada');
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Rutina, Rutina, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }
}

extension RutinaQueryProperty on QueryBuilder<Rutina, Rutina, QQueryProperty> {
  QueryBuilder<Rutina, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Rutina, bool, QQueryOperations> activaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activa');
    });
  }

  QueryBuilder<Rutina, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<Rutina, String?, QQueryOperations> descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<Rutina, List<int>, QQueryOperations> diasSemanaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diasSemana');
    });
  }

  QueryBuilder<Rutina, int?, QQueryOperations> duracionEstimadaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duracionEstimada');
    });
  }

  QueryBuilder<Rutina, List<EjercicioRutina>, QQueryOperations>
      ejerciciosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ejercicios');
    });
  }

  QueryBuilder<Rutina, DateTime, QQueryOperations> fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<Rutina, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<Rutina, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EjercicioRutinaSchema = Schema(
  name: r'EjercicioRutina',
  id: 176403829287712828,
  properties: {
    r'descansoSegundos': PropertySchema(
      id: 0,
      name: r'descansoSegundos',
      type: IsarType.long,
    ),
    r'ejercicioId': PropertySchema(
      id: 1,
      name: r'ejercicioId',
      type: IsarType.long,
    ),
    r'orden': PropertySchema(
      id: 2,
      name: r'orden',
      type: IsarType.long,
    ),
    r'peso': PropertySchema(
      id: 3,
      name: r'peso',
      type: IsarType.double,
    ),
    r'repeticiones': PropertySchema(
      id: 4,
      name: r'repeticiones',
      type: IsarType.long,
    ),
    r'series': PropertySchema(
      id: 5,
      name: r'series',
      type: IsarType.long,
    )
  },
  estimateSize: _ejercicioRutinaEstimateSize,
  serialize: _ejercicioRutinaSerialize,
  deserialize: _ejercicioRutinaDeserialize,
  deserializeProp: _ejercicioRutinaDeserializeProp,
);

int _ejercicioRutinaEstimateSize(
  EjercicioRutina object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _ejercicioRutinaSerialize(
  EjercicioRutina object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.descansoSegundos);
  writer.writeLong(offsets[1], object.ejercicioId);
  writer.writeLong(offsets[2], object.orden);
  writer.writeDouble(offsets[3], object.peso);
  writer.writeLong(offsets[4], object.repeticiones);
  writer.writeLong(offsets[5], object.series);
}

EjercicioRutina _ejercicioRutinaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EjercicioRutina();
  object.descansoSegundos = reader.readLongOrNull(offsets[0]);
  object.ejercicioId = reader.readLong(offsets[1]);
  object.orden = reader.readLong(offsets[2]);
  object.peso = reader.readDoubleOrNull(offsets[3]);
  object.repeticiones = reader.readLong(offsets[4]);
  object.series = reader.readLong(offsets[5]);
  return object;
}

P _ejercicioRutinaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EjercicioRutinaQueryFilter
    on QueryBuilder<EjercicioRutina, EjercicioRutina, QFilterCondition> {
  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      descansoSegundosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descansoSegundos',
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      descansoSegundosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descansoSegundos',
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      descansoSegundosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descansoSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      descansoSegundosGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descansoSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      descansoSegundosLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descansoSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      descansoSegundosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descansoSegundos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ejercicioIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ejercicioId',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ejercicioIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ejercicioId',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ejercicioIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ejercicioId',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ejercicioIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ejercicioId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ordenEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orden',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ordenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orden',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ordenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orden',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      ordenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orden',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      pesoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'peso',
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      pesoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'peso',
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      pesoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peso',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      pesoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peso',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      pesoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peso',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      pesoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peso',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      repeticionesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeticiones',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      repeticionesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeticiones',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      repeticionesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeticiones',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      repeticionesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeticiones',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      seriesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'series',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      seriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'series',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      seriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'series',
        value: value,
      ));
    });
  }

  QueryBuilder<EjercicioRutina, EjercicioRutina, QAfterFilterCondition>
      seriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'series',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EjercicioRutinaQueryObject
    on QueryBuilder<EjercicioRutina, EjercicioRutina, QFilterCondition> {}
