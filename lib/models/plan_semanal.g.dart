// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_semanal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlanSemanalCollection on Isar {
  IsarCollection<PlanSemanal> get planSemanals => this.collection();
}

const PlanSemanalSchema = CollectionSchema(
  name: r'PlanSemanal',
  id: 245913952989640744,
  properties: {
    r'dias': PropertySchema(
      id: 0,
      name: r'dias',
      type: IsarType.objectList,
      target: r'DiaPlanificado',
    ),
    r'fechaFin': PropertySchema(
      id: 1,
      name: r'fechaFin',
      type: IsarType.dateTime,
    ),
    r'fechaInicio': PropertySchema(
      id: 2,
      name: r'fechaInicio',
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
    )
  },
  estimateSize: _planSemanalEstimateSize,
  serialize: _planSemanalSerialize,
  deserialize: _planSemanalDeserialize,
  deserializeProp: _planSemanalDeserializeProp,
  idName: r'id',
  indexes: {
    r'fechaInicio': IndexSchema(
      id: -8943925949262073739,
      name: r'fechaInicio',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fechaInicio',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'DiaPlanificado': DiaPlanificadoSchema},
  getId: _planSemanalGetId,
  getLinks: _planSemanalGetLinks,
  attach: _planSemanalAttach,
  version: '3.1.0+1',
);

int _planSemanalEstimateSize(
  PlanSemanal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dias.length * 3;
  {
    final offsets = allOffsets[DiaPlanificado]!;
    for (var i = 0; i < object.dias.length; i++) {
      final value = object.dias[i];
      bytesCount +=
          DiaPlanificadoSchema.estimateSize(value, offsets, allOffsets);
    }
  }
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
  return bytesCount;
}

void _planSemanalSerialize(
  PlanSemanal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<DiaPlanificado>(
    offsets[0],
    allOffsets,
    DiaPlanificadoSchema.serialize,
    object.dias,
  );
  writer.writeDateTime(offsets[1], object.fechaFin);
  writer.writeDateTime(offsets[2], object.fechaInicio);
  writer.writeString(offsets[3], object.firebaseId);
  writer.writeString(offsets[4], object.notas);
}

PlanSemanal _planSemanalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlanSemanal();
  object.dias = reader.readObjectList<DiaPlanificado>(
        offsets[0],
        DiaPlanificadoSchema.deserialize,
        allOffsets,
        DiaPlanificado(),
      ) ??
      [];
  object.fechaFin = reader.readDateTime(offsets[1]);
  object.fechaInicio = reader.readDateTime(offsets[2]);
  object.firebaseId = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.notas = reader.readStringOrNull(offsets[4]);
  return object;
}

P _planSemanalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<DiaPlanificado>(
            offset,
            DiaPlanificadoSchema.deserialize,
            allOffsets,
            DiaPlanificado(),
          ) ??
          []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _planSemanalGetId(PlanSemanal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _planSemanalGetLinks(PlanSemanal object) {
  return [];
}

void _planSemanalAttach(
    IsarCollection<dynamic> col, Id id, PlanSemanal object) {
  object.id = id;
}

extension PlanSemanalQueryWhereSort
    on QueryBuilder<PlanSemanal, PlanSemanal, QWhere> {
  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhere> anyFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fechaInicio'),
      );
    });
  }
}

extension PlanSemanalQueryWhere
    on QueryBuilder<PlanSemanal, PlanSemanal, QWhereClause> {
  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> idBetween(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> fechaInicioEqualTo(
      DateTime fechaInicio) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fechaInicio',
        value: [fechaInicio],
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause>
      fechaInicioNotEqualTo(DateTime fechaInicio) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaInicio',
              lower: [],
              upper: [fechaInicio],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaInicio',
              lower: [fechaInicio],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaInicio',
              lower: [fechaInicio],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fechaInicio',
              lower: [],
              upper: [fechaInicio],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause>
      fechaInicioGreaterThan(
    DateTime fechaInicio, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaInicio',
        lower: [fechaInicio],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> fechaInicioLessThan(
    DateTime fechaInicio, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaInicio',
        lower: [],
        upper: [fechaInicio],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterWhereClause> fechaInicioBetween(
    DateTime lowerFechaInicio,
    DateTime upperFechaInicio, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'fechaInicio',
        lower: [lowerFechaInicio],
        includeLower: includeLower,
        upper: [upperFechaInicio],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlanSemanalQueryFilter
    on QueryBuilder<PlanSemanal, PlanSemanal, QFilterCondition> {
  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      diasLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dias',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> diasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dias',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      diasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dias',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      diasLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dias',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      diasLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dias',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      diasLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dias',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> fechaFinEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      fechaFinGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      fechaFinLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaFin',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> fechaFinBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaFin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      fechaInicioEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      fechaInicioGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      fechaInicioLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaInicio',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      fechaInicioBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaInicio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      firebaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      firebaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasEqualTo(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasLessThan(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasBetween(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasStartsWith(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasEndsWith(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasContains(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasMatches(
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

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition>
      notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }
}

extension PlanSemanalQueryObject
    on QueryBuilder<PlanSemanal, PlanSemanal, QFilterCondition> {
  QueryBuilder<PlanSemanal, PlanSemanal, QAfterFilterCondition> diasElement(
      FilterQuery<DiaPlanificado> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dias');
    });
  }
}

extension PlanSemanalQueryLinks
    on QueryBuilder<PlanSemanal, PlanSemanal, QFilterCondition> {}

extension PlanSemanalQuerySortBy
    on QueryBuilder<PlanSemanal, PlanSemanal, QSortBy> {
  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }
}

extension PlanSemanalQuerySortThenBy
    on QueryBuilder<PlanSemanal, PlanSemanal, QSortThenBy> {
  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByFechaFinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaFin', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByFechaInicioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaInicio', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }
}

extension PlanSemanalQueryWhereDistinct
    on QueryBuilder<PlanSemanal, PlanSemanal, QDistinct> {
  QueryBuilder<PlanSemanal, PlanSemanal, QDistinct> distinctByFechaFin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaFin');
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QDistinct> distinctByFechaInicio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaInicio');
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlanSemanal, PlanSemanal, QDistinct> distinctByNotas(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }
}

extension PlanSemanalQueryProperty
    on QueryBuilder<PlanSemanal, PlanSemanal, QQueryProperty> {
  QueryBuilder<PlanSemanal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlanSemanal, List<DiaPlanificado>, QQueryOperations>
      diasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dias');
    });
  }

  QueryBuilder<PlanSemanal, DateTime, QQueryOperations> fechaFinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaFin');
    });
  }

  QueryBuilder<PlanSemanal, DateTime, QQueryOperations> fechaInicioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaInicio');
    });
  }

  QueryBuilder<PlanSemanal, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<PlanSemanal, String?, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DiaPlanificadoSchema = Schema(
  name: r'DiaPlanificado',
  id: -987555046108351109,
  properties: {
    r'completado': PropertySchema(
      id: 0,
      name: r'completado',
      type: IsarType.bool,
    ),
    r'fecha': PropertySchema(
      id: 1,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'notas': PropertySchema(
      id: 2,
      name: r'notas',
      type: IsarType.string,
    ),
    r'rutinaIds': PropertySchema(
      id: 3,
      name: r'rutinaIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _diaPlanificadoEstimateSize,
  serialize: _diaPlanificadoSerialize,
  deserialize: _diaPlanificadoDeserialize,
  deserializeProp: _diaPlanificadoDeserializeProp,
);

int _diaPlanificadoEstimateSize(
  DiaPlanificado object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notas;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.rutinaIds.length * 8;
  return bytesCount;
}

void _diaPlanificadoSerialize(
  DiaPlanificado object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completado);
  writer.writeDateTime(offsets[1], object.fecha);
  writer.writeString(offsets[2], object.notas);
  writer.writeLongList(offsets[3], object.rutinaIds);
}

DiaPlanificado _diaPlanificadoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DiaPlanificado();
  object.completado = reader.readBool(offsets[0]);
  object.fecha = reader.readDateTime(offsets[1]);
  object.notas = reader.readStringOrNull(offsets[2]);
  object.rutinaIds = reader.readLongList(offsets[3]) ?? [];
  return object;
}

P _diaPlanificadoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DiaPlanificadoQueryFilter
    on QueryBuilder<DiaPlanificado, DiaPlanificado, QFilterCondition> {
  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      completadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completado',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      notasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      notasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notas',
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
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

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      notasContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notas',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      notasMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notas',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notas',
        value: '',
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rutinaIds',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rutinaIds',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rutinaIds',
        value: value,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rutinaIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutinaIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutinaIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutinaIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutinaIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutinaIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DiaPlanificado, DiaPlanificado, QAfterFilterCondition>
      rutinaIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'rutinaIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DiaPlanificadoQueryObject
    on QueryBuilder<DiaPlanificado, DiaPlanificado, QFilterCondition> {}
