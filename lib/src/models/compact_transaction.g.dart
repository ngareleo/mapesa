// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compact_transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompactTransactionCollection on Isar {
  IsarCollection<CompactTransaction> get compactTransactions =>
      this.collection();
}

const CompactTransactionSchema = CollectionSchema(
  name: r'CompactTransaction',
  id: -1944694126826447565,
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
      enumMap: _CompactTransactiontypeEnumValueMap,
    )
  },
  estimateSize: _compactTransactionEstimateSize,
  serialize: _compactTransactionSerialize,
  deserialize: _compactTransactionDeserialize,
  deserializeProp: _compactTransactionDeserializeProp,
  idName: r'id',
  indexes: {
    r'dateTime': IndexSchema(
      id: -138851979697481250,
      name: r'dateTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _compactTransactionGetId,
  getLinks: _compactTransactionGetLinks,
  attach: _compactTransactionAttach,
  version: '3.1.0+1',
);

int _compactTransactionEstimateSize(
  CompactTransaction object,
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

void _compactTransactionSerialize(
  CompactTransaction object,
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

CompactTransaction _compactTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompactTransaction(
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
    type: _CompactTransactiontypeValueEnumMap[
            reader.readStringOrNull(offsets[12])] ??
        TransactionType.receiveMoney,
  );
  return object;
}

P _compactTransactionDeserializeProp<P>(
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
      return (_CompactTransactiontypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TransactionType.receiveMoney) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CompactTransactiontypeEnumValueMap = {
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
const _CompactTransactiontypeValueEnumMap = {
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

Id _compactTransactionGetId(CompactTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _compactTransactionGetLinks(
    CompactTransaction object) {
  return [];
}

void _compactTransactionAttach(
    IsarCollection<dynamic> col, Id id, CompactTransaction object) {}

extension CompactTransactionQueryWhereSort
    on QueryBuilder<CompactTransaction, CompactTransaction, QWhere> {
  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhere>
      anyDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateTime'),
      );
    });
  }
}

extension CompactTransactionQueryWhere
    on QueryBuilder<CompactTransaction, CompactTransaction, QWhereClause> {
  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      dateTimeEqualTo(DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateTime',
        value: [dateTime],
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      dateTimeNotEqualTo(DateTime dateTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      dateTimeGreaterThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [dateTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      dateTimeLessThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [],
        upper: [dateTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterWhereClause>
      dateTimeBetween(
    DateTime lowerDateTime,
    DateTime upperDateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [lowerDateTime],
        includeLower: includeLower,
        upper: [upperDateTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompactTransactionQueryFilter
    on QueryBuilder<CompactTransaction, CompactTransaction, QFilterCondition> {
  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      agentNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'agent_number',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      agentNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'agent_number',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      agentNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agent_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      agentNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agent_number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      agentNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agent_number',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      agentNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agent_number',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      interestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interest',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      interestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interest',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message_id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subject_account',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subject_account',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject_account',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject_account',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject_account',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      subjectAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject_account',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subject_phone_number',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subject_phone_number',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject_phone_number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject_phone_number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject_phone_number',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject_phone_number',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      transactionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      transactionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transaction_code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      transactionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transaction_code',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      transactionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transaction_code',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
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

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension CompactTransactionQueryObject
    on QueryBuilder<CompactTransaction, CompactTransaction, QFilterCondition> {
  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      balance(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'balance');
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      interest(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'interest');
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      transactionAmount(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_amount');
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterFilterCondition>
      transactionCost(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_cost');
    });
  }
}

extension CompactTransactionQueryLinks
    on QueryBuilder<CompactTransaction, CompactTransaction, QFilterCondition> {}

extension CompactTransactionQuerySortBy
    on QueryBuilder<CompactTransaction, CompactTransaction, QSortBy> {
  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByAgentNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByAgentNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortBySubjectAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortBySubjectAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CompactTransactionQuerySortThenBy
    on QueryBuilder<CompactTransaction, CompactTransaction, QSortThenBy> {
  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByAgentNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByAgentNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agent_number', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenBySubjectAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenBySubjectAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_account', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject_phone_number', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CompactTransactionQueryWhereDistinct
    on QueryBuilder<CompactTransaction, CompactTransaction, QDistinct> {
  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByAgentNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agent_number', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message_id');
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctBySubject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctBySubjectAccount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject_account',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject_phone_number',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByTransactionCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transaction_code',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompactTransaction, CompactTransaction, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension CompactTransactionQueryProperty
    on QueryBuilder<CompactTransaction, CompactTransaction, QQueryProperty> {
  QueryBuilder<CompactTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompactTransaction, String?, QQueryOperations>
      agentNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agent_number');
    });
  }

  QueryBuilder<CompactTransaction, Money, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<CompactTransaction, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<CompactTransaction, Money?, QQueryOperations>
      interestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interest');
    });
  }

  QueryBuilder<CompactTransaction, String?, QQueryOperations>
      locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<CompactTransaction, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message_id');
    });
  }

  QueryBuilder<CompactTransaction, String, QQueryOperations> subjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject');
    });
  }

  QueryBuilder<CompactTransaction, String?, QQueryOperations>
      subjectAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject_account');
    });
  }

  QueryBuilder<CompactTransaction, String?, QQueryOperations>
      phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject_phone_number');
    });
  }

  QueryBuilder<CompactTransaction, Money, QQueryOperations>
      transactionAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_amount');
    });
  }

  QueryBuilder<CompactTransaction, String, QQueryOperations>
      transactionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_code');
    });
  }

  QueryBuilder<CompactTransaction, Money, QQueryOperations>
      transactionCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_cost');
    });
  }

  QueryBuilder<CompactTransaction, TransactionType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
