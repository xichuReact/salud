// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alimento.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRegistroAlimentoCollection on Isar {
  IsarCollection<RegistroAlimento> get registroAlimentos => this.collection();
}

const RegistroAlimentoSchema = CollectionSchema(
  name: r'RegistroAlimento',
  id: 7453641214179629064,
  properties: {
    r'calorias': PropertySchema(
      id: 0,
      name: r'calorias',
      type: IsarType.double,
    ),
    r'caloriasCalculadas': PropertySchema(
      id: 1,
      name: r'caloriasCalculadas',
      type: IsarType.double,
    ),
    r'cantidad': PropertySchema(
      id: 2,
      name: r'cantidad',
      type: IsarType.double,
    ),
    r'carbohidratos': PropertySchema(
      id: 3,
      name: r'carbohidratos',
      type: IsarType.double,
    ),
    r'descripcion': PropertySchema(
      id: 4,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'esHoy': PropertySchema(
      id: 5,
      name: r'esHoy',
      type: IsarType.bool,
    ),
    r'fecha': PropertySchema(
      id: 6,
      name: r'fecha',
      type: IsarType.dateTime,
    ),
    r'fechaCreacion': PropertySchema(
      id: 7,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 8,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'grasas': PropertySchema(
      id: 9,
      name: r'grasas',
      type: IsarType.double,
    ),
    r'nombre': PropertySchema(
      id: 10,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'proteinas': PropertySchema(
      id: 11,
      name: r'proteinas',
      type: IsarType.double,
    ),
    r'tipoComida': PropertySchema(
      id: 12,
      name: r'tipoComida',
      type: IsarType.string,
    ),
    r'unidadMedida': PropertySchema(
      id: 13,
      name: r'unidadMedida',
      type: IsarType.string,
    )
  },
  estimateSize: _registroAlimentoEstimateSize,
  serialize: _registroAlimentoSerialize,
  deserialize: _registroAlimentoDeserialize,
  deserializeProp: _registroAlimentoDeserializeProp,
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
    ),
    r'tipoComida': IndexSchema(
      id: 1910261281474005086,
      name: r'tipoComida',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tipoComida',
          type: IndexType.hash,
          caseSensitive: true,
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
  embeddedSchemas: {},
  getId: _registroAlimentoGetId,
  getLinks: _registroAlimentoGetLinks,
  attach: _registroAlimentoAttach,
  version: '3.1.0+1',
);

int _registroAlimentoEstimateSize(
  RegistroAlimento object,
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
  {
    final value = object.firebaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.tipoComida.length * 3;
  bytesCount += 3 + object.unidadMedida.length * 3;
  return bytesCount;
}

void _registroAlimentoSerialize(
  RegistroAlimento object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.calorias);
  writer.writeDouble(offsets[1], object.caloriasCalculadas);
  writer.writeDouble(offsets[2], object.cantidad);
  writer.writeDouble(offsets[3], object.carbohidratos);
  writer.writeString(offsets[4], object.descripcion);
  writer.writeBool(offsets[5], object.esHoy);
  writer.writeDateTime(offsets[6], object.fecha);
  writer.writeDateTime(offsets[7], object.fechaCreacion);
  writer.writeString(offsets[8], object.firebaseId);
  writer.writeDouble(offsets[9], object.grasas);
  writer.writeString(offsets[10], object.nombre);
  writer.writeDouble(offsets[11], object.proteinas);
  writer.writeString(offsets[12], object.tipoComida);
  writer.writeString(offsets[13], object.unidadMedida);
}

RegistroAlimento _registroAlimentoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RegistroAlimento();
  object.calorias = reader.readDouble(offsets[0]);
  object.cantidad = reader.readDouble(offsets[2]);
  object.carbohidratos = reader.readDouble(offsets[3]);
  object.descripcion = reader.readStringOrNull(offsets[4]);
  object.fecha = reader.readDateTime(offsets[6]);
  object.fechaCreacion = reader.readDateTime(offsets[7]);
  object.firebaseId = reader.readStringOrNull(offsets[8]);
  object.grasas = reader.readDouble(offsets[9]);
  object.id = id;
  object.nombre = reader.readString(offsets[10]);
  object.proteinas = reader.readDouble(offsets[11]);
  object.tipoComida = reader.readString(offsets[12]);
  object.unidadMedida = reader.readString(offsets[13]);
  return object;
}

P _registroAlimentoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _registroAlimentoGetId(RegistroAlimento object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _registroAlimentoGetLinks(RegistroAlimento object) {
  return [];
}

void _registroAlimentoAttach(
    IsarCollection<dynamic> col, Id id, RegistroAlimento object) {
  object.id = id;
}

extension RegistroAlimentoQueryWhereSort
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QWhere> {
  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhere> anyFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'fecha'),
      );
    });
  }
}

extension RegistroAlimentoQueryWhere
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QWhereClause> {
  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause> idBetween(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      nombreEqualTo(String nombre) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nombre',
        value: [nombre],
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      nombreNotEqualTo(String nombre) {
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      tipoComidaEqualTo(String tipoComida) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tipoComida',
        value: [tipoComida],
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      tipoComidaNotEqualTo(String tipoComida) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tipoComida',
              lower: [],
              upper: [tipoComida],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tipoComida',
              lower: [tipoComida],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tipoComida',
              lower: [tipoComida],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tipoComida',
              lower: [],
              upper: [tipoComida],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
      fechaEqualTo(DateTime fecha) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fecha',
        value: [fecha],
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterWhereClause>
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

extension RegistroAlimentoQueryFilter
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QFilterCondition> {
  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calorias',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calorias',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calorias',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calorias',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasCalculadasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caloriasCalculadas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasCalculadasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caloriasCalculadas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasCalculadasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caloriasCalculadas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      caloriasCalculadasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caloriasCalculadas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      cantidadEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      cantidadGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      cantidadLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      cantidadBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      carbohidratosEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carbohidratos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      carbohidratosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carbohidratos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      carbohidratosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carbohidratos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      carbohidratosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carbohidratos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      descripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      descripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      descripcionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      descripcionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      esHoyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'esHoy',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      fechaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fecha',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      fechaCreacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      firebaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      firebaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      grasasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grasas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      grasasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grasas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      grasasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grasas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      grasasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grasas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreEqualTo(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreGreaterThan(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreLessThan(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreBetween(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreStartsWith(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreEndsWith(
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

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      proteinasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proteinas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      proteinasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proteinas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      proteinasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proteinas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      proteinasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proteinas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoComida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipoComida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipoComida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipoComida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipoComida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipoComida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipoComida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipoComida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipoComida',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      tipoComidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipoComida',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unidadMedida',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unidadMedida',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unidadMedida',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidadMedida',
        value: '',
      ));
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterFilterCondition>
      unidadMedidaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unidadMedida',
        value: '',
      ));
    });
  }
}

extension RegistroAlimentoQueryObject
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QFilterCondition> {}

extension RegistroAlimentoQueryLinks
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QFilterCondition> {}

extension RegistroAlimentoQuerySortBy
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QSortBy> {
  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCalorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCaloriasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCaloriasCalculadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasCalculadas', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCaloriasCalculadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasCalculadas', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByCarbohidratosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy> sortByEsHoy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esHoy', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByEsHoyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esHoy', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByGrasasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByProteinasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByTipoComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByTipoComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByUnidadMedida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      sortByUnidadMedidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.desc);
    });
  }
}

extension RegistroAlimentoQuerySortThenBy
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QSortThenBy> {
  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCalorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCaloriasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCaloriasCalculadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasCalculadas', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCaloriasCalculadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caloriasCalculadas', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByCarbohidratosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy> thenByEsHoy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esHoy', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByEsHoyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'esHoy', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByGrasasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByProteinasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByTipoComida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByTipoComidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipoComida', Sort.desc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByUnidadMedida() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.asc);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QAfterSortBy>
      thenByUnidadMedidaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadMedida', Sort.desc);
    });
  }
}

extension RegistroAlimentoQueryWhereDistinct
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct> {
  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByCalorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calorias');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByCaloriasCalculadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caloriasCalculadas');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidad');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbohidratos');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByDescripcion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByEsHoy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'esHoy');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByFirebaseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grasas');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinas');
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByTipoComida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipoComida', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RegistroAlimento, RegistroAlimento, QDistinct>
      distinctByUnidadMedida({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unidadMedida', caseSensitive: caseSensitive);
    });
  }
}

extension RegistroAlimentoQueryProperty
    on QueryBuilder<RegistroAlimento, RegistroAlimento, QQueryProperty> {
  QueryBuilder<RegistroAlimento, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RegistroAlimento, double, QQueryOperations> caloriasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calorias');
    });
  }

  QueryBuilder<RegistroAlimento, double, QQueryOperations>
      caloriasCalculadasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caloriasCalculadas');
    });
  }

  QueryBuilder<RegistroAlimento, double, QQueryOperations> cantidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidad');
    });
  }

  QueryBuilder<RegistroAlimento, double, QQueryOperations>
      carbohidratosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbohidratos');
    });
  }

  QueryBuilder<RegistroAlimento, String?, QQueryOperations>
      descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<RegistroAlimento, bool, QQueryOperations> esHoyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'esHoy');
    });
  }

  QueryBuilder<RegistroAlimento, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<RegistroAlimento, DateTime, QQueryOperations>
      fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<RegistroAlimento, String?, QQueryOperations>
      firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<RegistroAlimento, double, QQueryOperations> grasasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grasas');
    });
  }

  QueryBuilder<RegistroAlimento, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<RegistroAlimento, double, QQueryOperations> proteinasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinas');
    });
  }

  QueryBuilder<RegistroAlimento, String, QQueryOperations>
      tipoComidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipoComida');
    });
  }

  QueryBuilder<RegistroAlimento, String, QQueryOperations>
      unidadMedidaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unidadMedida');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlimentoBaseCollection on Isar {
  IsarCollection<AlimentoBase> get alimentoBases => this.collection();
}

const AlimentoBaseSchema = CollectionSchema(
  name: r'AlimentoBase',
  id: -8966385024249253181,
  properties: {
    r'activo': PropertySchema(
      id: 0,
      name: r'activo',
      type: IsarType.bool,
    ),
    r'calorias': PropertySchema(
      id: 1,
      name: r'calorias',
      type: IsarType.double,
    ),
    r'cantidadReferencia': PropertySchema(
      id: 2,
      name: r'cantidadReferencia',
      type: IsarType.double,
    ),
    r'carbohidratos': PropertySchema(
      id: 3,
      name: r'carbohidratos',
      type: IsarType.double,
    ),
    r'categoria': PropertySchema(
      id: 4,
      name: r'categoria',
      type: IsarType.string,
    ),
    r'color': PropertySchema(
      id: 5,
      name: r'color',
      type: IsarType.string,
    ),
    r'descripcion': PropertySchema(
      id: 6,
      name: r'descripcion',
      type: IsarType.string,
    ),
    r'fechaCreacion': PropertySchema(
      id: 7,
      name: r'fechaCreacion',
      type: IsarType.dateTime,
    ),
    r'firebaseId': PropertySchema(
      id: 8,
      name: r'firebaseId',
      type: IsarType.string,
    ),
    r'grasas': PropertySchema(
      id: 9,
      name: r'grasas',
      type: IsarType.double,
    ),
    r'icono': PropertySchema(
      id: 10,
      name: r'icono',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 11,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'proteinas': PropertySchema(
      id: 12,
      name: r'proteinas',
      type: IsarType.double,
    ),
    r'unidadReferencia': PropertySchema(
      id: 13,
      name: r'unidadReferencia',
      type: IsarType.string,
    )
  },
  estimateSize: _alimentoBaseEstimateSize,
  serialize: _alimentoBaseSerialize,
  deserialize: _alimentoBaseDeserialize,
  deserializeProp: _alimentoBaseDeserializeProp,
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
  embeddedSchemas: {},
  getId: _alimentoBaseGetId,
  getLinks: _alimentoBaseGetLinks,
  attach: _alimentoBaseAttach,
  version: '3.1.0+1',
);

int _alimentoBaseEstimateSize(
  AlimentoBase object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.categoria;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
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
  {
    final value = object.firebaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.icono;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.unidadReferencia.length * 3;
  return bytesCount;
}

void _alimentoBaseSerialize(
  AlimentoBase object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.activo);
  writer.writeDouble(offsets[1], object.calorias);
  writer.writeDouble(offsets[2], object.cantidadReferencia);
  writer.writeDouble(offsets[3], object.carbohidratos);
  writer.writeString(offsets[4], object.categoria);
  writer.writeString(offsets[5], object.color);
  writer.writeString(offsets[6], object.descripcion);
  writer.writeDateTime(offsets[7], object.fechaCreacion);
  writer.writeString(offsets[8], object.firebaseId);
  writer.writeDouble(offsets[9], object.grasas);
  writer.writeString(offsets[10], object.icono);
  writer.writeString(offsets[11], object.nombre);
  writer.writeDouble(offsets[12], object.proteinas);
  writer.writeString(offsets[13], object.unidadReferencia);
}

AlimentoBase _alimentoBaseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlimentoBase();
  object.activo = reader.readBool(offsets[0]);
  object.calorias = reader.readDouble(offsets[1]);
  object.cantidadReferencia = reader.readDouble(offsets[2]);
  object.carbohidratos = reader.readDouble(offsets[3]);
  object.categoria = reader.readStringOrNull(offsets[4]);
  object.color = reader.readStringOrNull(offsets[5]);
  object.descripcion = reader.readStringOrNull(offsets[6]);
  object.fechaCreacion = reader.readDateTime(offsets[7]);
  object.firebaseId = reader.readStringOrNull(offsets[8]);
  object.grasas = reader.readDouble(offsets[9]);
  object.icono = reader.readStringOrNull(offsets[10]);
  object.id = id;
  object.nombre = reader.readString(offsets[11]);
  object.proteinas = reader.readDouble(offsets[12]);
  object.unidadReferencia = reader.readString(offsets[13]);
  return object;
}

P _alimentoBaseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _alimentoBaseGetId(AlimentoBase object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _alimentoBaseGetLinks(AlimentoBase object) {
  return [];
}

void _alimentoBaseAttach(
    IsarCollection<dynamic> col, Id id, AlimentoBase object) {
  object.id = id;
}

extension AlimentoBaseQueryWhereSort
    on QueryBuilder<AlimentoBase, AlimentoBase, QWhere> {
  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AlimentoBaseQueryWhere
    on QueryBuilder<AlimentoBase, AlimentoBase, QWhereClause> {
  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> idBetween(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> nombreEqualTo(
      String nombre) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nombre',
        value: [nombre],
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterWhereClause> nombreNotEqualTo(
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

extension AlimentoBaseQueryFilter
    on QueryBuilder<AlimentoBase, AlimentoBase, QFilterCondition> {
  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> activoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activo',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      caloriasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calorias',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      caloriasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calorias',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      caloriasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calorias',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      caloriasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calorias',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      cantidadReferenciaEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidadReferencia',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      cantidadReferenciaGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidadReferencia',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      cantidadReferenciaLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidadReferencia',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      cantidadReferenciaBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidadReferencia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      carbohidratosEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carbohidratos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      carbohidratosGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carbohidratos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      carbohidratosLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carbohidratos',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      carbohidratosBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carbohidratos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoria',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoria',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      categoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoria',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> colorEqualTo(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      colorGreaterThan(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> colorLessThan(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> colorBetween(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      colorStartsWith(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> colorEndsWith(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> colorContains(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> colorMatches(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      descripcionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      descripcionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descripcion',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      descripcionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descripcion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      descripcionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descripcion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      descripcionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      descripcionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descripcion',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      fechaCreacionEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fechaCreacion',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      firebaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      firebaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firebaseId',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      firebaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      firebaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      firebaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      firebaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> grasasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grasas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      grasasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grasas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      grasasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grasas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> grasasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grasas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      iconoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'icono',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      iconoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'icono',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> iconoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icono',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      iconoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'icono',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> iconoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'icono',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> iconoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'icono',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      iconoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'icono',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> iconoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'icono',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> iconoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'icono',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> iconoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'icono',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      iconoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icono',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      iconoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'icono',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> nombreEqualTo(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreGreaterThan(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreLessThan(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> nombreBetween(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreStartsWith(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreEndsWith(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition> nombreMatches(
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

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      proteinasEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proteinas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      proteinasGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proteinas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      proteinasLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proteinas',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      proteinasBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proteinas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidadReferencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unidadReferencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unidadReferencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unidadReferencia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unidadReferencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unidadReferencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unidadReferencia',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unidadReferencia',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidadReferencia',
        value: '',
      ));
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterFilterCondition>
      unidadReferenciaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unidadReferencia',
        value: '',
      ));
    });
  }
}

extension AlimentoBaseQueryObject
    on QueryBuilder<AlimentoBase, AlimentoBase, QFilterCondition> {}

extension AlimentoBaseQueryLinks
    on QueryBuilder<AlimentoBase, AlimentoBase, QFilterCondition> {}

extension AlimentoBaseQuerySortBy
    on QueryBuilder<AlimentoBase, AlimentoBase, QSortBy> {
  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByActivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByCalorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByCaloriasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByCantidadReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadReferencia', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByCantidadReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadReferencia', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByCarbohidratosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByGrasasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByIcono() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icono', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByIconoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icono', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> sortByProteinasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByUnidadReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadReferencia', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      sortByUnidadReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadReferencia', Sort.desc);
    });
  }
}

extension AlimentoBaseQuerySortThenBy
    on QueryBuilder<AlimentoBase, AlimentoBase, QSortThenBy> {
  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByActivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByCalorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByCaloriasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calorias', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByCantidadReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadReferencia', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByCantidadReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadReferencia', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByCarbohidratosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carbohidratos', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByDescripcion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByDescripcionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descripcion', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByFechaCreacionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaCreacion', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByFirebaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByFirebaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseId', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByGrasasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grasas', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByIcono() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icono', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByIconoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icono', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy> thenByProteinasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinas', Sort.desc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByUnidadReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadReferencia', Sort.asc);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QAfterSortBy>
      thenByUnidadReferenciaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidadReferencia', Sort.desc);
    });
  }
}

extension AlimentoBaseQueryWhereDistinct
    on QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> {
  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activo');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByCalorias() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calorias');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct>
      distinctByCantidadReferencia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadReferencia');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct>
      distinctByCarbohidratos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carbohidratos');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByCategoria(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoria', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByDescripcion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descripcion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct>
      distinctByFechaCreacion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaCreacion');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByFirebaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByGrasas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grasas');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByIcono(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'icono', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct> distinctByProteinas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinas');
    });
  }

  QueryBuilder<AlimentoBase, AlimentoBase, QDistinct>
      distinctByUnidadReferencia({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unidadReferencia',
          caseSensitive: caseSensitive);
    });
  }
}

extension AlimentoBaseQueryProperty
    on QueryBuilder<AlimentoBase, AlimentoBase, QQueryProperty> {
  QueryBuilder<AlimentoBase, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AlimentoBase, bool, QQueryOperations> activoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activo');
    });
  }

  QueryBuilder<AlimentoBase, double, QQueryOperations> caloriasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calorias');
    });
  }

  QueryBuilder<AlimentoBase, double, QQueryOperations>
      cantidadReferenciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadReferencia');
    });
  }

  QueryBuilder<AlimentoBase, double, QQueryOperations> carbohidratosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carbohidratos');
    });
  }

  QueryBuilder<AlimentoBase, String?, QQueryOperations> categoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoria');
    });
  }

  QueryBuilder<AlimentoBase, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<AlimentoBase, String?, QQueryOperations> descripcionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descripcion');
    });
  }

  QueryBuilder<AlimentoBase, DateTime, QQueryOperations>
      fechaCreacionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaCreacion');
    });
  }

  QueryBuilder<AlimentoBase, String?, QQueryOperations> firebaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseId');
    });
  }

  QueryBuilder<AlimentoBase, double, QQueryOperations> grasasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grasas');
    });
  }

  QueryBuilder<AlimentoBase, String?, QQueryOperations> iconoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icono');
    });
  }

  QueryBuilder<AlimentoBase, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<AlimentoBase, double, QQueryOperations> proteinasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinas');
    });
  }

  QueryBuilder<AlimentoBase, String, QQueryOperations>
      unidadReferenciaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unidadReferencia');
    });
  }
}
