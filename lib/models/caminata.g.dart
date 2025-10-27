// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caminata.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCaminataCollection on Isar {
  IsarCollection<Caminata> get caminatas => this.collection();
}

const CaminataSchema = CollectionSchema(
  name: r'Caminata',
  id: -2503043775164409246,
  properties: {
    r'caloriasEstimadas': PropertySchema(
      id: 0,
      name: r'caloriasEstimadas',
      type: IsarType.long,
    ),
    r'desnivelMetros': PropertySchema(
      id: 1,
      name: r'desnivelMetros',
      type: IsarType.double,
    ),
    r'distanciaMetros': PropertySchema(
      id: 2,
      name: r'distanciaMetros',
      type: IsarType.double,
    ),
    r'duracionSegundos': PropertySchema(
      id: 3,
      name: r'duracionSegundos',
      type: IsarType.long,
    ),
    r'fecha': PropertySchema(
      id: 4,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 5,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'notas': PropertySchema(
      id: 6,
      name: r'notas',
      type: IsarType.string,
    ),
    r'ritmoCardiacoPromedio': PropertySchema(
      id: 7,
      name: r'ritmoCardiacoPromedio',
      type: IsarType.long,
    ),
    r'ubicacion': PropertySchema(
      id: 8,
      name: r'ubicacion',
      type: IsarType.string,
    )
  },
  estimateSize: _caminataEstimateSize,
  serialize: _caminataSerialize,
  deserialize: _caminataDeserialize,
  deserializeProp: _caminataDeserializeProp,
  idName: r'id',
  indexes: {
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
  embeddedSchemas: {},
  getId: _caminataGetId,
  getLinks: _caminataGetLinks,
  attach: _caminataAttach,
  version: '3.1.0+1',
);

int _caminataEstimateSize(
  Caminata object,
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
  {
    final value = object.ubicacion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _caminataSerialize(
  Caminata object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.caloriasEstimadas);
  writer.writeDouble(offsets[1], object.desnivelMetros);
  writer.writeDouble(offsets[2], object.distanciaMetros);
  writer.writeLong(offsets[3], object.duracionSegundos);
  writer.writeDateTime(offsets[4], object.fecha);
  writer.writeString(offsets[5], object.firebaseId);
  writer.writeString(offsets[6], object.notas);
  writer.writeLong(offsets[7], object.ritmoCardiacoPromedio);
  writer.writeString(offsets[8], object.ubicacion);
}

Caminata _caminataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Caminata();
  object.caloriasEstimadas = reader.readLongOrNull(offsets[0]);
  object.desnivelMetros = reader.readDoubleOrNull(offsets[1]);
  object.distanciaMetros = reader.readDoubleOrNull(offsets[2]);
  object.duracionSegundos = reader.readLong(offsets[3]);
  object.fecha = reader.readDateTime(offsets[4]);
  object.firebaseId = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.notas = reader.readStringOrNull(offsets[6]);
  object.ritmoCardiacoPromedio = reader.readLongOrNull(offsets[7]);
  object.ubicacion = reader.readStringOrNull(offsets[8]);
  return object;
}

P _caminataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _caminataGetId(Caminata object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _caminataGetLinks(Caminata object) {
  return [];
}

void _caminataAttach(IsarCollection<dynamic> col, Id id, Caminata object) {
  object.id = id;
}

extension CaminataQueryWhereSort on QueryBuilder<Caminata, Caminata, QWhere> {
  QueryBuilder<Caminata, Caminata, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension CaminataQueryWhere on QueryBuilder<Caminata, Caminata, QWhereClause> {
  QueryBuilder<Caminata, Caminata, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> idBetween(
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

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> fechaEqualTo(
      DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fecha',
        value: [fecha],
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> fechaNotEqualTo(
      DateTime fecha) {
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

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> fechaGreaterThan(
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

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> fechaLessThan(
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

  QueryBuilder<Caminata, Caminata, QAfterWhereClause> fechaBetween(
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

extension CaminataQueryFilter
    on QueryBuilder<Caminata, Caminata, QFilterCondition> {
  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      caloriasEstimadasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'caloriasEstimadas',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      caloriasEstimadasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'caloriasEstimadas',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      caloriasEstimadasEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caloriasEstimadas',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      caloriasEstimadasGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caloriasEstimadas',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      caloriasEstimadasLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caloriasEstimadas',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      caloriasEstimadasBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caloriasEstimadas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      desnivelMetrosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'desnivelMetros',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      desnivelMetrosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'desnivelMetros',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> desnivelMetrosEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'desnivelMetros',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      desnivelMetrosGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'desnivelMetros',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      desnivelMetrosLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'desnivelMetros',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> desnivelMetrosBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'desnivelMetros',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      distanciaMetrosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'distanciaMetros',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      distanciaMetrosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'distanciaMetros',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      distanciaMetrosEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanciaMetros',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      distanciaMetrosGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanciaMetros',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      distanciaMetrosLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanciaMetros',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      distanciaMetrosBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanciaMetros',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      duracionSegundosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracionSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      duracionSegundosGreaterThan(
    int value, {
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      duracionSegundosLessThan(
    int value, {
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      duracionSegundosBetween(
    int lower,
    int upper, {
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> fechaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> fechaGreaterThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> fechaLessThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> fechaBetween(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdEqualTo(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdGreaterThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdLessThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdBetween(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdStartsWith(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdEndsWith(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdContains(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdMatches(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasEqualTo(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasGreaterThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasLessThan(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasBetween(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasStartsWith(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasEndsWith(
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

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ritmoCardiacoPromedioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ritmoCardiacoPromedio',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ritmoCardiacoPromedioIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ritmoCardiacoPromedio',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ritmoCardiacoPromedioEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ritmoCardiacoPromedio',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ritmoCardiacoPromedioGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ritmoCardiacoPromedio',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ritmoCardiacoPromedioLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ritmoCardiacoPromedio',
        value: value,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ritmoCardiacoPromedioBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ritmoCardiacoPromedio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ubicacion',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ubicacion',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ubicacion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ubicacion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ubicacion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition> ubicacionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ubicacion',
        value: '',
      ));
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterFilterCondition>
      ubicacionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ubicacion',
        value: '',
      ));
    });
  }
}

extension CaminataQueryObject
    on QueryBuilder<Caminata, Caminata, QFilterCondition> {}

extension CaminataQueryLinks
    on QueryBuilder<Caminata, Caminata, QFilterCondition> {}

extension CaminataQuerySortBy on QueryBuilder<Caminata, Caminata, QSortBy> {
  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByCaloriasEstimadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasEstimadas', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByCaloriasEstimadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasEstimadas', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByDesnivelMetros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'desnivelMetros', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByDesnivelMetrosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'desnivelMetros', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByDistanciaMetros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaMetros', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByDistanciaMetrosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaMetros', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByDuracionSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByDuracionSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByRitmoCardiacoPromedio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ritmoCardiacoPromedio', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy>
      sortByRitmoCardiacoPromedioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ritmoCardiacoPromedio', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByUbicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> sortByUbicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.desc);
    });
  }
}

extension CaminataQuerySortThenBy
    on QueryBuilder<Caminata, Caminata, QSortThenBy> {
  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByCaloriasEstimadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasEstimadas', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByCaloriasEstimadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasEstimadas', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByDesnivelMetros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'desnivelMetros', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByDesnivelMetrosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'desnivelMetros', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByDistanciaMetros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaMetros', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByDistanciaMetrosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanciaMetros', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByDuracionSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByDuracionSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionSegundos', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByRitmoCardiacoPromedio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ritmoCardiacoPromedio', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy>
      thenByRitmoCardiacoPromedioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ritmoCardiacoPromedio', Sort.desc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByUbicacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.asc);
    });
  }

  QueryBuilder<Caminata, Caminata, QAfterSortBy> thenByUbicacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ubicacion', Sort.desc);
    });
  }
}

extension CaminataQueryWhereDistinct
    on QueryBuilder<Caminata, Caminata, QDistinct> {
  QueryBuilder<Caminata, Caminata, QDistinct> distinctByCaloriasEstimadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caloriasEstimadas');
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByDesnivelMetros() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'desnivelMetros');
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByDistanciaMetros() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanciaMetros');
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByDuracionSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duracionSegundos');
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct>
      distinctByRitmoCardiacoPromedio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ritmoCardiacoPromedio');
    });
  }

  QueryBuilder<Caminata, Caminata, QDistinct> distinctByUbicacion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ubicacion', caseSensitive: caseSensitive);
    });
  }
}

extension CaminataQueryProperty
    on QueryBuilder<Caminata, Caminata, QQueryProperty> {
  QueryBuilder<Caminata, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Caminata, int?, QQueryOperations> caloriasEstimadasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caloriasEstimadas');
    });
  }

  QueryBuilder<Caminata, double?, QQueryOperations> desnivelMetrosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'desnivelMetros');
    });
  }

  QueryBuilder<Caminata, double?, QQueryOperations> distanciaMetrosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanciaMetros');
    });
  }

  QueryBuilder<Caminata, int, QQueryOperations> duracionSegundosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duracionSegundos');
    });
  }

  QueryBuilder<Caminata, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<Caminata, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<Caminata, String?, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<Caminata, int?, QQueryOperations>
      ritmoCardiacoPromedioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ritmoCardiacoPromedio');
    });
  }

  QueryBuilder<Caminata, String?, QQueryOperations> ubicacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ubicacion');
    });
  }
}
