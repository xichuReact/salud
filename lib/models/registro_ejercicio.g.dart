// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_ejercicio.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroEjercicioCollection on Isar {
  IsarCollection<RegistroEjercicio> get registroEjercicios => this.collection();
}

const RegistroEjercicioSchema = CollectionSchema(
  name: r'RegistroEjercicio',
  id: -2727099357806739886,
  properties: {
    r'duracionSegundos': PropertySchema(
      id: 0,
      name: r'duracionSegundos',
      type: IsarType.long,
    ),
    r'ejercicioId': PropertySchema(
      id: 1,
      name: r'ejercicioId',
      type: IsarType.long,
    ),
    r'fecha': PropertySchema(
      id: 2,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 3,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'notas': PropertySchema(
      id: 4,
      name: r'notas',
      type: IsarType.string,
    ),
    r'sensacion': PropertySchema(
      id: 5,
      name: r'sensacion',
      type: IsarType.long,
    ),
    r'series': PropertySchema(
      id: 6,
      name: r'series',
      type: IsarType.objectList,
      target: r'Serie',
    )
  },
  estimateSize: _registroEjercicioEstimateSize,
  serialize: _registroEjercicioSerialize,
  deserialize: _registroEjercicioDeserialize,
  deserializeProp: _registroEjercicioDeserializeProp,
  idName: r'id',
  indexes: {
    r'ejercicioId': IndexSchema(
      id: 550704206694526357,
      name: r'ejercicioId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ejercicioId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'fecha': IndexSchema(
      id: -5395179286312083551,
      name: r'fecha',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fecha',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Serie': SerieSchema},
  getId: _registroEjercicioGetId,
  getLinks: _registroEjercicioGetLinks,
  attach: _registroEjercicioAttach,
  version: '3.1.0+1',
);

int _registroEjercicioEstimateSize(
  RegistroEjercicio object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.firebaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.series.length * 3;
  {
    final offsets = allOffsets[Serie]!;
    for (var i = 0; i < object.series.length; i++) {
      final value = object.series[i];
      bytesCount += SerieSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _registroEjercicioSerialize(
  RegistroEjercicio object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.duracionSegundos);
  writer.writeLong(offsets[1], object.ejercicioId);
  writer.writeDateTime(offsets[2], object.fecha);
  writer.writeString(offsets[3], object.firebaseId);
  writer.writeString(offsets[4], object.notas);
  writer.writeLong(offsets[5], object.sensacion);
  writer.writeObjectList<Serie>(
    offsets[6],
    allOffsets,
    SerieSchema.serialize,
    object.series,
  );
}

RegistroEjercicio _registroEjercicioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroEjercicio();
  object.duracionSegundos = reader.readLongOrNull(offsets[0]);
  object.ejercicioId = reader.readLong(offsets[1]);
  object.fecha = reader.readDateTime(offsets[2]);
  object.firebaseId = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.notas = reader.readStringOrNull(offsets[4]);
  object.sensacion = reader.readLongOrNull(offsets[5]);
  object.series = reader.readObjectList<Serie>(
        offsets[6],
        SerieSchema.deserialize,
        allOffsets,
        Serie(),
      ) ??
      [];
  return object;
}

P _registroEjercicioDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<Serie>(
            offset,
            SerieSchema.deserialize,
            allOffsets,
            Serie(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _registroEjercicioGetId(RegistroEjercicio object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroEjercicioGetLinks(
    RegistroEjercicio object) {
  return [];
}

void _registroEjercicioAttach(
    IsarCollection<dynamic> col, Id id, RegistroEjercicio object) {
  object.id = id;
}

extension RegistroEjercicioQueryWhereSort
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QWhere> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhere>
      anyEjercicioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'ejercicioId'),
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension RegistroEjercicioQueryWhere
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QWhereClause> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      ejercicioIdEqualTo(int ejercicioId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ejercicioId',
        value: [ejercicioId],
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      ejercicioIdNotEqualTo(int ejercicioId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ejercicioId',
              lower: [],
              upper: [ejercicioId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ejercicioId',
              lower: [ejercicioId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ejercicioId',
              lower: [ejercicioId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ejercicioId',
              lower: [],
              upper: [ejercicioId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      ejercicioIdGreaterThan(
    int ejercicioId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ejercicioId',
        lower: [ejercicioId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      ejercicioIdLessThan(
    int ejercicioId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ejercicioId',
        lower: [],
        upper: [ejercicioId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      ejercicioIdBetween(
    int lowerEjercicioId,
    int upperEjercicioId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ejercicioId',
        lower: [lowerEjercicioId],
        includeLower: includeLower,
        upper: [upperEjercicioId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      fechaEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fecha',
        value: [fecha],
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      fechaNotEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [],
              upper: [fecha],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [fecha],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [fecha],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fecha',
              lower: [],
              upper: [fecha],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      fechaGreaterThan(
    DateTime fecha, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fecha',
        lower: [fecha],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      fechaLessThan(
    DateTime fecha, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fecha',
        lower: [],
        upper: [fecha],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterWhereClause>
      fechaBetween(
    DateTime lowerFecha,
    DateTime upperFecha, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fecha',
        lower: [lowerFecha],
        includeLower: includeLower,
        upper: [upperFecha],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RegistroEjercicioQueryFilter
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QFilterCondition> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      duracionSegundosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duracionSegundos',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      duracionSegundosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duracionSegundos',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      duracionSegundosEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      duracionSegundosGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      duracionSegundosLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      duracionSegundosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duracionSegundos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      ejercicioIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ejercicioId',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fecha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdEqualTo(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdGreaterThan(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdLessThan(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdBetween(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdStartsWith(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdEndsWith(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      sensacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sensacion',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      sensacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sensacion',
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      sensacionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sensacion',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      sensacionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sensacion',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      sensacionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sensacion',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      sensacionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sensacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'series',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'series',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'series',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'series',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'series',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'series',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension RegistroEjercicioQueryObject
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QFilterCondition> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterFilterCondition>
      seriesElement(FilterQuery<Serie> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'series');
    });
  }
}

extension RegistroEjercicioQueryLinks
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QFilterCondition> {}

extension RegistroEjercicioQuerySortBy
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QSortBy> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByDuracionSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByDuracionSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByEjercicioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ejercicioId', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByEjercicioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ejercicioId', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortBySensacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      sortBySensacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.desc);
    });
  }
}

extension RegistroEjercicioQuerySortThenBy
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QSortThenBy> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByDuracionSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByDuracionSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByEjercicioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ejercicioId', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByEjercicioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ejercicioId', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenBySensacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QAfterSortBy>
      thenBySensacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensacion', Sort.desc);
    });
  }
}

extension RegistroEjercicioQueryWhereDistinct
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct> {
  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct>
      distinctByDuracionSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duracionSegundos');
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct>
      distinctByEjercicioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ejercicioId');
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct>
      distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct>
      distinctByFirebaseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroEjercicio, RegistroEjercicio, QDistinct>
      distinctBySensacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sensacion');
    });
  }
}

extension RegistroEjercicioQueryProperty
    on QueryBuilder<RegistroEjercicio, RegistroEjercicio, QQueryProperty> {
  QueryBuilder<RegistroEjercicio, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroEjercicio, int?, QQueryOperations>
      duracionSegundosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duracionSegundos');
    });
  }

  QueryBuilder<RegistroEjercicio, int, QQueryOperations> ejercicioIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ejercicioId');
    });
  }

  QueryBuilder<RegistroEjercicio, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<RegistroEjercicio, String?, QQueryOperations>
      firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<RegistroEjercicio, String?, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<RegistroEjercicio, int?, QQueryOperations> sensacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensacion');
    });
  }

  QueryBuilder<RegistroEjercicio, List<Serie>, QQueryOperations>
      seriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'series');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SerieSchema = Schema(
  name: r'Serie',
  id: 1245856759724849144,
  properties: {
    r'completada': PropertySchema(
      id: 0,
      name: r'completada',
      type: IsarType.bool,
    ),
    r'duracionSegundos': PropertySchema(
      id: 1,
      name: r'duracionSegundos',
      type: IsarType.long,
    ),
    r'peso': PropertySchema(
      id: 2,
      name: r'peso',
      type: IsarType.double,
    ),
    r'repeticiones': PropertySchema(
      id: 3,
      name: r'repeticiones',
      type: IsarType.long,
    )
  },
  estimateSize: _serieEstimateSize,
  serialize: _serieSerialize,
  deserialize: _serieDeserialize,
  deserializeProp: _serieDeserializeProp,
);

int _serieEstimateSize(
  Serie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _serieSerialize(
  Serie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completada);
  writer.writeLong(offsets[1], object.duracionSegundos);
  writer.writeDouble(offsets[2], object.peso);
  writer.writeLong(offsets[3], object.repeticiones);
}

Serie _serieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Serie();
  object.completada = reader.readBool(offsets[0]);
  object.duracionSegundos = reader.readLongOrNull(offsets[1]);
  object.peso = reader.readDoubleOrNull(offsets[2]);
  object.repeticiones = reader.readLong(offsets[3]);
  return object;
}

P _serieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SerieQueryFilter on QueryBuilder<Serie, Serie, QFilterCondition> {
  QueryBuilder<Serie, Serie, QAfterFilterCondition> completadaEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completada',
        value: value,
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> duracionSegundosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duracionSegundos',
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition>
      duracionSegundosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duracionSegundos',
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> duracionSegundosEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> duracionSegundosGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> duracionSegundosLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> duracionSegundosBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duracionSegundos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'peso',
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'peso',
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoEqualTo(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoGreaterThan(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoLessThan(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> pesoBetween(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeticiones',
        value: value,
      ));
    });
  }

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesGreaterThan(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesLessThan(
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

  QueryBuilder<Serie, Serie, QAfterFilterCondition> repeticionesBetween(
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
}

extension SerieQueryObject on QueryBuilder<Serie, Serie, QFilterCondition> {}
