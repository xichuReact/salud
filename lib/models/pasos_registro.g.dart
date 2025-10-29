// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pasos_registro.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPasosRegistroCollection on Isar {
  IsarCollection<PasosRegistro> get pasosRegistros => this.collection();
}

const PasosRegistroSchema = CollectionSchema(
  name: r'PasosRegistro',
  id: 1316937431000735517,
  properties: {
    r'fecha': PropertySchema(
      id: 0,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'fechaSinHora': PropertySchema(
      id: 1,
      name: r'fechaSinHora',
      type: IsarType.dateTime,
    ),
    r'pasos': PropertySchema(
      id: 2,
      name: r'pasos',
      type: IsarType.long,
    )
  },
  estimateSize: _pasosRegistroEstimateSize,
  serialize: _pasosRegistroSerialize,
  deserialize: _pasosRegistroDeserialize,
  deserializeProp: _pasosRegistroDeserializeProp,
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
  getId: _pasosRegistroGetId,
  getLinks: _pasosRegistroGetLinks,
  attach: _pasosRegistroAttach,
  version: '3.1.0+1',
);

int _pasosRegistroEstimateSize(
  PasosRegistro object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _pasosRegistroSerialize(
  PasosRegistro object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.fecha);
  writer.writeDateTime(offsets[1], object.fechaSinHora);
  writer.writeLong(offsets[2], object.pasos);
}

PasosRegistro _pasosRegistroDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PasosRegistro();
  object.fecha = reader.readDateTime(offsets[0]);
  object.id = id;
  object.pasos = reader.readLong(offsets[2]);
  return object;
}

P _pasosRegistroDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pasosRegistroGetId(PasosRegistro object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pasosRegistroGetLinks(PasosRegistro object) {
  return [];
}

void _pasosRegistroAttach(
    IsarCollection<dynamic> col, Id id, PasosRegistro object) {
  object.id = id;
}

extension PasosRegistroQueryWhereSort
    on QueryBuilder<PasosRegistro, PasosRegistro, QWhere> {
  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension PasosRegistroQueryWhere
    on QueryBuilder<PasosRegistro, PasosRegistro, QWhereClause> {
  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> idBetween(
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> fechaEqualTo(
      DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fecha',
        value: [fecha],
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> fechaNotEqualTo(
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause>
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> fechaLessThan(
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterWhereClause> fechaBetween(
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

extension PasosRegistroQueryFilter
    on QueryBuilder<PasosRegistro, PasosRegistro, QFilterCondition> {
  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      fechaSinHoraEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaSinHora',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      fechaSinHoraGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fechaSinHora',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      fechaSinHoraLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fechaSinHora',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      fechaSinHoraBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fechaSinHora',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      pasosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pasos',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      pasosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pasos',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      pasosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pasos',
        value: value,
      ));
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterFilterCondition>
      pasosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pasos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PasosRegistroQueryObject
    on QueryBuilder<PasosRegistro, PasosRegistro, QFilterCondition> {}

extension PasosRegistroQueryLinks
    on QueryBuilder<PasosRegistro, PasosRegistro, QFilterCondition> {}

extension PasosRegistroQuerySortBy
    on QueryBuilder<PasosRegistro, PasosRegistro, QSortBy> {
  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy>
      sortByFechaSinHora() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaSinHora', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy>
      sortByFechaSinHoraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaSinHora', Sort.desc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> sortByPasos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasos', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> sortByPasosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasos', Sort.desc);
    });
  }
}

extension PasosRegistroQuerySortThenBy
    on QueryBuilder<PasosRegistro, PasosRegistro, QSortThenBy> {
  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy>
      thenByFechaSinHora() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaSinHora', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy>
      thenByFechaSinHoraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaSinHora', Sort.desc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> thenByPasos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasos', Sort.asc);
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QAfterSortBy> thenByPasosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pasos', Sort.desc);
    });
  }
}

extension PasosRegistroQueryWhereDistinct
    on QueryBuilder<PasosRegistro, PasosRegistro, QDistinct> {
  QueryBuilder<PasosRegistro, PasosRegistro, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QDistinct>
      distinctByFechaSinHora() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaSinHora');
    });
  }

  QueryBuilder<PasosRegistro, PasosRegistro, QDistinct> distinctByPasos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pasos');
    });
  }
}

extension PasosRegistroQueryProperty
    on QueryBuilder<PasosRegistro, PasosRegistro, QQueryProperty> {
  QueryBuilder<PasosRegistro, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PasosRegistro, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<PasosRegistro, DateTime, QQueryOperations>
      fechaSinHoraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaSinHora');
    });
  }

  QueryBuilder<PasosRegistro, int, QQueryOperations> pasosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pasos');
    });
  }
}
