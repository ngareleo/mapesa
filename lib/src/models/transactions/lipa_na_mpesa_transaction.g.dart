// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lipa_na_mpesa_transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLipaNaMpesaTransactionCollection on Isar {
  IsarCollection<LipaNaMpesaTransaction> get lipaNaMpesaTransactions =>
      this.collection();
}

const LipaNaMpesaTransactionSchema = CollectionSchema(
  name: r'LipaNaMpesaTransaction',
  id: 942799935442554187,
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
    r'message_id': PropertySchema(
      id: 2,
      name: r'message_id',
      type: IsarType.long,
    ),
    r'subject': PropertySchema(
      id: 3,
      name: r'subject',
      type: IsarType.string,
    ),
    r'transaction_amount': PropertySchema(
      id: 4,
      name: r'transaction_amount',
      type: IsarType.object,
      target: r'Money',
    ),
    r'transaction_code': PropertySchema(
      id: 5,
      name: r'transaction_code',
      type: IsarType.string,
    ),
    r'transaction_cost': PropertySchema(
      id: 6,
      name: r'transaction_cost',
      type: IsarType.object,
      target: r'Money',
    )
  },
  estimateSize: _lipaNaMpesaTransactionEstimateSize,
  serialize: _lipaNaMpesaTransactionSerialize,
  deserialize: _lipaNaMpesaTransactionDeserialize,
  deserializeProp: _lipaNaMpesaTransactionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Money': MoneySchema},
  getId: _lipaNaMpesaTransactionGetId,
  getLinks: _lipaNaMpesaTransactionGetLinks,
  attach: _lipaNaMpesaTransactionAttach,
  version: '3.1.0+1',
);

int _lipaNaMpesaTransactionEstimateSize(
  LipaNaMpesaTransaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      MoneySchema.estimateSize(object.balance, allOffsets[Money]!, allOffsets);
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

void _lipaNaMpesaTransactionSerialize(
  LipaNaMpesaTransaction object,
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
  writer.writeLong(offsets[2], object.messageId);
  writer.writeString(offsets[3], object.subject);
  writer.writeObject<Money>(
    offsets[4],
    allOffsets,
    MoneySchema.serialize,
    object.transactionAmount,
  );
  writer.writeString(offsets[5], object.transactionCode);
  writer.writeObject<Money>(
    offsets[6],
    allOffsets,
    MoneySchema.serialize,
    object.transactionCost,
  );
}

LipaNaMpesaTransaction _lipaNaMpesaTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LipaNaMpesaTransaction(
    balance: reader.readObjectOrNull<Money>(
          offsets[0],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    dateTime: reader.readDateTime(offsets[1]),
    messageId: reader.readLong(offsets[2]),
    subject: reader.readString(offsets[3]),
    transactionAmount: reader.readObjectOrNull<Money>(
          offsets[4],
          MoneySchema.deserialize,
          allOffsets,
        ) ??
        Money(),
    transactionCode: reader.readString(offsets[5]),
  );
  return object;
}

P _lipaNaMpesaTransactionDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<Money>(
            offset,
            MoneySchema.deserialize,
            allOffsets,
          ) ??
          Money()) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
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

Id _lipaNaMpesaTransactionGetId(LipaNaMpesaTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lipaNaMpesaTransactionGetLinks(
    LipaNaMpesaTransaction object) {
  return [];
}

void _lipaNaMpesaTransactionAttach(
    IsarCollection<dynamic> col, Id id, LipaNaMpesaTransaction object) {}

extension LipaNaMpesaTransactionQueryWhereSort
    on QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QWhere> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LipaNaMpesaTransactionQueryWhere on QueryBuilder<
    LipaNaMpesaTransaction, LipaNaMpesaTransaction, QWhereClause> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterWhereClause> idBetween(
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

extension LipaNaMpesaTransactionQueryFilter on QueryBuilder<
    LipaNaMpesaTransaction, LipaNaMpesaTransaction, QFilterCondition> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> dateTimeGreaterThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> dateTimeLessThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> dateTimeBetween(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> messageIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message_id',
        value: value,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> messageIdGreaterThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> messageIdLessThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> messageIdBetween(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectEqualTo(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectGreaterThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectLessThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectBetween(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectStartsWith(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectEndsWith(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
          QAfterFilterCondition>
      subjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
          QAfterFilterCondition>
      subjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> subjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subject',
        value: '',
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeEqualTo(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeGreaterThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeLessThan(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeBetween(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeStartsWith(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeEndsWith(
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

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
          QAfterFilterCondition>
      transactionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transaction_code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
          QAfterFilterCondition>
      transactionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transaction_code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transaction_code',
        value: '',
      ));
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transaction_code',
        value: '',
      ));
    });
  }
}

extension LipaNaMpesaTransactionQueryObject on QueryBuilder<
    LipaNaMpesaTransaction, LipaNaMpesaTransaction, QFilterCondition> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> balance(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'balance');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionAmount(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_amount');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction,
      QAfterFilterCondition> transactionCost(FilterQuery<Money> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'transaction_cost');
    });
  }
}

extension LipaNaMpesaTransactionQueryLinks on QueryBuilder<
    LipaNaMpesaTransaction, LipaNaMpesaTransaction, QFilterCondition> {}

extension LipaNaMpesaTransactionQuerySortBy
    on QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QSortBy> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      sortByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }
}

extension LipaNaMpesaTransactionQuerySortThenBy on QueryBuilder<
    LipaNaMpesaTransaction, LipaNaMpesaTransaction, QSortThenBy> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message_id', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenBySubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenBySubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subject', Sort.desc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByTransactionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.asc);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QAfterSortBy>
      thenByTransactionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transaction_code', Sort.desc);
    });
  }
}

extension LipaNaMpesaTransactionQueryWhereDistinct
    on QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QDistinct> {
  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QDistinct>
      distinctByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message_id');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QDistinct>
      distinctBySubject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, LipaNaMpesaTransaction, QDistinct>
      distinctByTransactionCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transaction_code',
          caseSensitive: caseSensitive);
    });
  }
}

extension LipaNaMpesaTransactionQueryProperty on QueryBuilder<
    LipaNaMpesaTransaction, LipaNaMpesaTransaction, QQueryProperty> {
  QueryBuilder<LipaNaMpesaTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, Money, QQueryOperations>
      balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, int, QQueryOperations>
      messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message_id');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, String, QQueryOperations>
      subjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subject');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, Money, QQueryOperations>
      transactionAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_amount');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, String, QQueryOperations>
      transactionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_code');
    });
  }

  QueryBuilder<LipaNaMpesaTransaction, Money, QQueryOperations>
      transactionCostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transaction_cost');
    });
  }
}
