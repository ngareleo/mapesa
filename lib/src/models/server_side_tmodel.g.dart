// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_side_tmodel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServerSideTModelCollection on Isar {
  IsarCollection<ServerSideTModel> get serverSideTModels => this.collection();
}

const ServerSideTModelSchema = CollectionSchema(
  name: r'ServerSideTModel',
  id: 3624531698623825734,
  properties: {
    r'agent_number': PropertySchema(
      id: 0,
      name: r'agent_number',
      type: IsarType.string,
    ),
    r'balance': PropertySchema(
      id: 1,
      name: r'balance',
      type: IsarType.object,
      target: r'Money',
    ),
    r'dateTime': PropertySchema(
      id: 2,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'interest': PropertySchema(
      id: 3,
      name: r'interest',
      type: IsarType.object,
      target: r'Money',
    ),
    r'location': PropertySchema(
      id: 4,
      name: r'location',
      type: IsarType.string,
    ),
    r'message_id': PropertySchema(
      id: 5,
      name: r'message_id',
      type: IsarType.long,
    ),
    r'subject': PropertySchema(
      id: 6,
      name: r'subject',
      type: IsarType.string,
    ),
    r'subject_account': PropertySchema(
      id: 7,
      name: r'subject_account',
      type: IsarType.string,
    ),
    r'subject_phone_number': PropertySchema(
      id: 8,
      name: r'subject_phone_number',
      type: IsarType.string,
    ),
    r'transaction_amount': PropertySchema(
      id: 9,
      name: r'transaction_amount',
      type: IsarType.object,
      target: r'Money',
    ),
    r'transaction_code': PropertySchema(
      id: 10,
      name: r'transaction_code',
      type: IsarType.string,
    ),
    r'transaction_cost': PropertySchema(
      id: 11,
      name: r'transaction_cost',
      type: IsarType.object,
      target: r'Money',
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.string,
      enumMap: _ServerSideTModeltypeEnumValueMap,
    )
  },
  estimateSize: _serverSideTModelEstimateSize,
  serialize: _serverSideTModelSerialize,
  deserialize: _serverSideTModelDeserialize,
  deserializeProp: _serverSideTModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _serverSideTModelGetId,
  getLinks: _serverSideTModelGetLinks,
  attach: _serverSideTModelAttach,
  version: '3.1.0+1',
);

int _serverSideTModelEstimateSize(
  ServerSideTModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.agentNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 +
      MoneySchema.estimateSize(object.balance, allOffsets[Money]!, allOffsets);
  {
    final value = object.interest;
    if (value != null) {
      bytesCount +=
          3 + MoneySchema.estimateSize(value, allOffsets[Money]!, allOffsets);
    }
  }
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.subject.length * 3;
  {
    final value = object.subjectAccount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 +
      MoneySchema.estimateSize(
          object.transactionAmount, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.transactionCode.length * 3;
  bytesCount += 3 +
      MoneySchema.estimateSize(
          object.transactionCost, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.type.serverSide.length * 3;
  return bytesCount;
}

void _serverSideTModelSerialize(
  ServerSideTModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.agentNumber);
  writer.writeObject<Money>(
    offsets[1],
    allOffsets,
    MoneySchema.serialize,
    object.balance,
  );
  writer.writeDateTime(offsets[2], object.dateTime);
  writer.writeObject<Money>(
    offsets[3],
    allOffsets,
    MoneySchema.serialize,
    object.interest,
  );
  writer.writeString(offsets[4], object.location);
  writer.writeLong(offsets[5], object.messageId);
  writer.writeString(offsets[6], object.subject);
  writer.writeString(offsets[7], object.subjectAccount);
  writer.writeString(offsets[8], object.phoneNumber);
  writer.writeObject<Money>(
    offsets[9],
    allOffsets,
    MoneySchema.serialize,
    object.transactionAmount,
  );
  writer.writeString(offsets[10], object.transactionCode);
  writer.writeObject<Money>(
    offsets[11],
    allOffsets,
    MoneySchema.serialize,
    object.transactionCost,
  );
  writer.writeString(offsets[12], object.type.serverSide);
}

ServerSideTModel _serverSideTModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServerSideTModel(
    agentNumber: reader.readStringOrNull(offsets[0]),
    balance: reader.readObjectOrNull<Money>(
          offsets[1],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    dateTime: reader.readDateTime(offsets[2]),
    interest: reader.readObjectOrNull<Money>(
      offsets[3],
      MoneySchema.deserialize,
      allOffsets,
    ),
    location: reader.readStringOrNull(offsets[4]),
    messageId: reader.readLong(offsets[5]),
    subject: reader.readString(offsets[6]),
    subjectAccount: reader.readStringOrNull(offsets[7]),
    phoneNumber: reader.readStringOrNull(offsets[8]),
    transactionAmount: reader.readObjectOrNull<Money>(
          offsets[9],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    transactionCode: reader.readString(offsets[10]),
    transactionCost: reader.readObjectOrNull<Money>(
          offsets[11],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    type: _ServerSideTModeltypeValueEnumMap[
            reader.readStringOrNull(offsets[12])] ??
        TransactionType.receiveMoney,
  );
  return object;
}

P _serverSideTModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<Money>(
        offset,
        MoneySchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 12:
      return (_ServerSideTModeltypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TransactionType.receiveMoney) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ServerSideTModeltypeEnumValueMap = {
  r'receiveMoney': r'receive',
  r'sendMoney': r'send',
  r'lipaNaMpesa': r'buygoods',
  r'payBillMoney': r'paybill',
  r'airtime': r'airtime',
  r'airtimeFor': r'airtime_for',
  r'withdrawMoney': r'withdraw',
  r'fuliza': r'fuliza',
  r'depositMoney': r'deposit',
};
const _ServerSideTModeltypeValueEnumMap = {
  r'receive': TransactionType.receiveMoney,
  r'send': TransactionType.sendMoney,
  r'buygoods': TransactionType.lipaNaMpesa,
  r'paybill': TransactionType.payBillMoney,
  r'airtime': TransactionType.airtime,
  r'airtime_for': TransactionType.airtimeFor,
  r'withdraw': TransactionType.withdrawMoney,
  r'fuliza': TransactionType.fuliza,
  r'deposit': TransactionType.depositMoney,
};

Id _serverSideTModelGetId(ServerSideTModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serverSideTModelGetLinks(ServerSideTModel object) {
  return [];
}

void _serverSideTModelAttach(
    IsarCollection<dynamic> col, Id id, ServerSideTModel object) {}

extension ServerSideTModelQueryWhereSort
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QWhere> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ServerSideTModelQueryWhere
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QWhereClause> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterWhereClause>
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

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterWhereClause> idBetween(
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

extension ServerSideTModelQueryFilter
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QFilterCondition> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'agent_number',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'agent_number',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'agent_number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agent_number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agent_number',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      agentNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agent_number',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
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

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
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

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
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

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      interestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interest',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      interestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interest',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message_id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      messageIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message_id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      messageIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message_id',
        value: value,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      messageIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message_id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subject',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subject_account',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subject_account',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subject_account',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject_account',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject_account',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      subjectAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject_account',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subject_phone_number',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subject_phone_number',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subject_phone_number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject_phone_number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject_phone_number',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject_phone_number',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transaction_code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transaction_code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transaction_code',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transaction_code',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeEqualTo(
    TransactionType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeGreaterThan(
    TransactionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeLessThan(
    TransactionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeBetween(
    TransactionType lower,
    TransactionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ServerSideTModelQueryObject
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QFilterCondition> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      balance(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'balance');
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      interest(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'interest');
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionAmount(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_amount');
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterFilterCondition>
      transactionCost(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_cost');
    });
  }
}

extension ServerSideTModelQueryLinks
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QFilterCondition> {}

extension ServerSideTModelQuerySortBy
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QSortBy> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByAgentNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByAgentNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortBySubjectAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortBySubjectAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ServerSideTModelQuerySortThenBy
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QSortThenBy> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByAgentNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByAgentNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenBySubjectAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenBySubjectAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ServerSideTModelQueryWhereDistinct
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct> {
  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctByAgentNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agent_number', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message_id');
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct> distinctBySubject(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctBySubjectAccount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject_account',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctByPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject_phone_number',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct>
      distinctByTransactionCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transaction_code',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServerSideTModel, ServerSideTModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ServerSideTModelQueryProperty
    on QueryBuilder<ServerSideTModel, ServerSideTModel, QQueryProperty> {
  QueryBuilder<ServerSideTModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ServerSideTModel, String?, QQueryOperations>
      agentNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agent_number');
    });
  }

  QueryBuilder<ServerSideTModel, Money, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<ServerSideTModel, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<ServerSideTModel, Money?, QQueryOperations> interestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interest');
    });
  }

  QueryBuilder<ServerSideTModel, String?, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<ServerSideTModel, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message_id');
    });
  }

  QueryBuilder<ServerSideTModel, String, QQueryOperations> subjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject');
    });
  }

  QueryBuilder<ServerSideTModel, String?, QQueryOperations>
      subjectAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject_account');
    });
  }

  QueryBuilder<ServerSideTModel, String?, QQueryOperations>
      phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject_phone_number');
    });
  }

  QueryBuilder<ServerSideTModel, Money, QQueryOperations>
      transactionAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_amount');
    });
  }

  QueryBuilder<ServerSideTModel, String, QQueryOperations>
      transactionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_code');
    });
  }

  QueryBuilder<ServerSideTModel, Money, QQueryOperations>
      transactionCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_cost');
    });
  }

  QueryBuilder<ServerSideTModel, TransactionType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
