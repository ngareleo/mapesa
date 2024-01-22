// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuliza_transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFulizaTransactionCollection on Isar {
  IsarCollection<FulizaTransaction> get fulizaTransactions => this.collection();
}

const FulizaTransactionSchema = CollectionSchema(
  name: r'FulizaTransaction',
  id: 4117662318456421970,
  properties: {
    r'balance': PropertySchema(
      id: 0,
      name: r'balance',
      type: IsarType.object,
      target: r'Money',
    ),
    r'dateTime': PropertySchema(
      id: 1,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'interest': PropertySchema(
      id: 2,
      name: r'interest',
      type: IsarType.object,
      target: r'Money',
    ),
    r'message_id': PropertySchema(
      id: 3,
      name: r'message_id',
      type: IsarType.long,
    ),
    r'subject': PropertySchema(
      id: 4,
      name: r'subject',
      type: IsarType.string,
    ),
    r'transaction_amount': PropertySchema(
      id: 5,
      name: r'transaction_amount',
      type: IsarType.object,
      target: r'Money',
    ),
    r'transaction_code': PropertySchema(
      id: 6,
      name: r'transaction_code',
      type: IsarType.string,
    ),
    r'transaction_cost': PropertySchema(
      id: 7,
      name: r'transaction_cost',
      type: IsarType.object,
      target: r'Money',
    )
  },
  estimateSize: _fulizaTransactionEstimateSize,
  serialize: _fulizaTransactionSerialize,
  deserialize: _fulizaTransactionDeserialize,
  deserializeProp: _fulizaTransactionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _fulizaTransactionGetId,
  getLinks: _fulizaTransactionGetLinks,
  attach: _fulizaTransactionAttach,
  version: '3.1.0+1',
);

int _fulizaTransactionEstimateSize(
  FulizaTransaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      MoneySchema.estimateSize(object.balance, allOffsets[Money]!, allOffsets);
  bytesCount += 3 +
      MoneySchema.estimateSize(object.interest, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.subject.length * 3;
  bytesCount += 3 +
      MoneySchema.estimateSize(
          object.transactionAmount, allOffsets[Money]!, allOffsets);
  bytesCount += 3 + object.transactionCode.length * 3;
  bytesCount += 3 +
      MoneySchema.estimateSize(
          object.transactionCost, allOffsets[Money]!, allOffsets);
  return bytesCount;
}

void _fulizaTransactionSerialize(
  FulizaTransaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<Money>(
    offsets[0],
    allOffsets,
    MoneySchema.serialize,
    object.balance,
  );
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeObject<Money>(
    offsets[2],
    allOffsets,
    MoneySchema.serialize,
    object.interest,
  );
  writer.writeLong(offsets[3], object.messageId);
  writer.writeString(offsets[4], object.subject);
  writer.writeObject<Money>(
    offsets[5],
    allOffsets,
    MoneySchema.serialize,
    object.transactionAmount,
  );
  writer.writeString(offsets[6], object.transactionCode);
  writer.writeObject<Money>(
    offsets[7],
    allOffsets,
    MoneySchema.serialize,
    object.transactionCost,
  );
}

FulizaTransaction _fulizaTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FulizaTransaction(
    balance: reader.readObjectOrNull<Money>(
          offsets[0],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    dateTime: reader.readDateTime(offsets[1]),
    interest: reader.readObjectOrNull<Money>(
          offsets[2],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    messageId: reader.readLong(offsets[3]),
    transactionAmount: reader.readObjectOrNull<Money>(
          offsets[5],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    transactionCode: reader.readString(offsets[6]),
  );
  return object;
}

P _fulizaTransactionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fulizaTransactionGetId(FulizaTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fulizaTransactionGetLinks(
    FulizaTransaction object) {
  return [];
}

void _fulizaTransactionAttach(
    IsarCollection<dynamic> col, Id id, FulizaTransaction object) {}

extension FulizaTransactionQueryWhereSort
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QWhere> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FulizaTransactionQueryWhere
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QWhereClause> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterWhereClause>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterWhereClause>
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
}

extension FulizaTransactionQueryFilter
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QFilterCondition> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message_id',
        value: value,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      subjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      subjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      subjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      subjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
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

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      transactionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      transactionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transaction_code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      transactionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transaction_code',
        value: '',
      ));
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      transactionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transaction_code',
        value: '',
      ));
    });
  }
}

extension FulizaTransactionQueryObject
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QFilterCondition> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      balance(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'balance');
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      interest(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'interest');
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      transactionAmount(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_amount');
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterFilterCondition>
      transactionCost(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_cost');
    });
  }
}

extension FulizaTransactionQueryLinks
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QFilterCondition> {}

extension FulizaTransactionQuerySortBy
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QSortBy> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      sortByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }
}

extension FulizaTransactionQuerySortThenBy
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QSortThenBy> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QAfterSortBy>
      thenByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }
}

extension FulizaTransactionQueryWhereDistinct
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QDistinct> {
  QueryBuilder<FulizaTransaction, FulizaTransaction, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QDistinct>
      distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message_id');
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QDistinct>
      distinctBySubject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FulizaTransaction, FulizaTransaction, QDistinct>
      distinctByTransactionCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transaction_code',
          caseSensitive: caseSensitive);
    });
  }
}

extension FulizaTransactionQueryProperty
    on QueryBuilder<FulizaTransaction, FulizaTransaction, QQueryProperty> {
  QueryBuilder<FulizaTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FulizaTransaction, Money, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<FulizaTransaction, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<FulizaTransaction, Money, QQueryOperations> interestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interest');
    });
  }

  QueryBuilder<FulizaTransaction, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message_id');
    });
  }

  QueryBuilder<FulizaTransaction, String, QQueryOperations> subjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject');
    });
  }

  QueryBuilder<FulizaTransaction, Money, QQueryOperations>
      transactionAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_amount');
    });
  }

  QueryBuilder<FulizaTransaction, String, QQueryOperations>
      transactionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_code');
    });
  }

  QueryBuilder<FulizaTransaction, Money, QQueryOperations>
      transactionCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_cost');
    });
  }
}
