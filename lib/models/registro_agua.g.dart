// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_agua.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroAguaCollection on Isar {
  IsarCollection<RegistroAgua> get registroAguas => this.collection();
}

const RegistroAguaSchema = CollectionSchema(
  name: r'RegistroAgua',
  id: 3228413567836297462,
  properties: {
    r'cantidadMl': PropertySchema(
      id: 0,
      name: r'cantidadMl',
      type: IsarType.long,
    ),
    r'fecha': PropertySchema(
      id: 1,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'fechaCreacion': PropertySchema(
      id: 2,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 3,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'nota': PropertySchema(
      id: 4,
      name: r'nota',
      type: IsarType.string,
    ),
    r'objetivoDiario': PropertySchema(
      id: 5,
      name: r'objetivoDiario',
      type: IsarType.long,
    )
  },
  estimateSize: _registroAguaEstimateSize,
  serialize: _registroAguaSerialize,
  deserialize: _registroAguaDeserialize,
  deserializeProp: _registroAguaDeserializeProp,
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
  getId: _registroAguaGetId,
  getLinks: _registroAguaGetLinks,
  attach: _registroAguaAttach,
  version: '3.1.0+1',
);

int _registroAguaEstimateSize(
  RegistroAgua object,
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
    final value = object.nota;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _registroAguaSerialize(
  RegistroAgua object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cantidadMl);
  writer.writeDateTime(offsets[1], object.fecha);
  writer.writeDateTime(offsets[2], object.fechaCreacion);
  writer.writeString(offsets[3], object.firebaseId);
  writer.writeString(offsets[4], object.nota);
  writer.writeLong(offsets[5], object.objetivoDiario);
}

RegistroAgua _registroAguaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroAgua();
  object.cantidadMl = reader.readLong(offsets[0]);
  object.fecha = reader.readDateTime(offsets[1]);
  object.fechaCreacion = reader.readDateTime(offsets[2]);
  object.firebaseId = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.nota = reader.readStringOrNull(offsets[4]);
  object.objetivoDiario = reader.readLong(offsets[5]);
  return object;
}

P _registroAguaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _registroAguaGetId(RegistroAgua object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroAguaGetLinks(RegistroAgua object) {
  return [];
}

void _registroAguaAttach(
    IsarCollection<dynamic> col, Id id, RegistroAgua object) {
  object.id = id;
}

extension RegistroAguaQueryWhereSort
    on QueryBuilder<RegistroAgua, RegistroAgua, QWhere> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension RegistroAguaQueryWhere
    on QueryBuilder<RegistroAgua, RegistroAgua, QWhereClause> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> idBetween(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaEqualTo(
      DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fecha',
        value: [fecha],
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaNotEqualTo(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaGreaterThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaLessThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterWhereClause> fechaBetween(
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

extension RegistroAguaQueryFilter
    on QueryBuilder<RegistroAgua, RegistroAgua, QFilterCondition> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      cantidadMlEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadMl',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      cantidadMlGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadMl',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      cantidadMlLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadMl',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      cantidadMlBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadMl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> fechaEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> fechaLessThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> fechaBetween(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      fechaCreacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      firebaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      firebaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nota',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      notaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nota',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      notaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nota',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      notaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nota',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition> notaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nota',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      notaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nota',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      notaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nota',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      objetivoDiarioEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objetivoDiario',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      objetivoDiarioGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objetivoDiario',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      objetivoDiarioLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objetivoDiario',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterFilterCondition>
      objetivoDiarioBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objetivoDiario',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RegistroAguaQueryObject
    on QueryBuilder<RegistroAgua, RegistroAgua, QFilterCondition> {}

extension RegistroAguaQueryLinks
    on QueryBuilder<RegistroAgua, RegistroAgua, QFilterCondition> {}

extension RegistroAguaQuerySortBy
    on QueryBuilder<RegistroAgua, RegistroAgua, QSortBy> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByCantidadMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadMl', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      sortByCantidadMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadMl', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> sortByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      sortByObjetivoDiario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoDiario', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      sortByObjetivoDiarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoDiario', Sort.desc);
    });
  }
}

extension RegistroAguaQuerySortThenBy
    on QueryBuilder<RegistroAgua, RegistroAgua, QSortThenBy> {
  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByCantidadMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadMl', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      thenByCantidadMlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadMl', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByNota() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy> thenByNotaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nota', Sort.desc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      thenByObjetivoDiario() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoDiario', Sort.asc);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QAfterSortBy>
      thenByObjetivoDiarioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objetivoDiario', Sort.desc);
    });
  }
}

extension RegistroAguaQueryWhereDistinct
    on QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> {
  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> distinctByCantidadMl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadMl');
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct>
      distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct> distinctByNota(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nota', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroAgua, RegistroAgua, QDistinct>
      distinctByObjetivoDiario() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objetivoDiario');
    });
  }
}

extension RegistroAguaQueryProperty
    on QueryBuilder<RegistroAgua, RegistroAgua, QQueryProperty> {
  QueryBuilder<RegistroAgua, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroAgua, int, QQueryOperations> cantidadMlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadMl');
    });
  }

  QueryBuilder<RegistroAgua, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<RegistroAgua, DateTime, QQueryOperations>
      fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<RegistroAgua, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<RegistroAgua, String?, QQueryOperations> notaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nota');
    });
  }

  QueryBuilder<RegistroAgua, int, QQueryOperations> objetivoDiarioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objetivoDiario');
    });
  }
}
