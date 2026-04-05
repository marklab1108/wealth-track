// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CashAssetsTable extends CashAssets
    with TableInfo<$CashAssetsTable, CashAssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    updatedAt,
    currency,
    bankName,
    amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashAssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashAssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashAssetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $CashAssetsTable createAlias(String alias) {
    return $CashAssetsTable(attachedDatabase, alias);
  }
}

class CashAssetRow extends DataClass implements Insertable<CashAssetRow> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String currency;
  final String bankName;
  final double amount;
  const CashAssetRow({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
    required this.bankName,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['currency'] = Variable<String>(currency);
    map['bank_name'] = Variable<String>(bankName);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  CashAssetsCompanion toCompanion(bool nullToAbsent) {
    return CashAssetsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      currency: Value(currency),
      bankName: Value(bankName),
      amount: Value(amount),
    );
  }

  factory CashAssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashAssetRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      currency: serializer.fromJson<String>(json['currency']),
      bankName: serializer.fromJson<String>(json['bankName']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'currency': serializer.toJson<String>(currency),
      'bankName': serializer.toJson<String>(bankName),
      'amount': serializer.toJson<double>(amount),
    };
  }

  CashAssetRow copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? currency,
    String? bankName,
    double? amount,
  }) => CashAssetRow(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    currency: currency ?? this.currency,
    bankName: bankName ?? this.bankName,
    amount: amount ?? this.amount,
  );
  CashAssetRow copyWithCompanion(CashAssetsCompanion data) {
    return CashAssetRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      currency: data.currency.present ? data.currency.value : this.currency,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashAssetRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('currency: $currency, ')
          ..write('bankName: $bankName, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, createdAt, updatedAt, currency, bankName, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashAssetRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.currency == this.currency &&
          other.bankName == this.bankName &&
          other.amount == this.amount);
}

class CashAssetsCompanion extends UpdateCompanion<CashAssetRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> currency;
  final Value<String> bankName;
  final Value<double> amount;
  final Value<int> rowid;
  const CashAssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.currency = const Value.absent(),
    this.bankName = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashAssetsCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String currency,
    required String bankName,
    required double amount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       currency = Value(currency),
       bankName = Value(bankName),
       amount = Value(amount);
  static Insertable<CashAssetRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? currency,
    Expression<String>? bankName,
    Expression<double>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (currency != null) 'currency': currency,
      if (bankName != null) 'bank_name': bankName,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashAssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? currency,
    Value<String>? bankName,
    Value<double>? amount,
    Value<int>? rowid,
  }) {
    return CashAssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currency: currency ?? this.currency,
      bankName: bankName ?? this.bankName,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashAssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('currency: $currency, ')
          ..write('bankName: $bankName, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockAssetsTable extends StockAssets
    with TableInfo<$StockAssetsTable, StockAssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketMeta = const VerificationMeta('market');
  @override
  late final GeneratedColumn<String> market = GeneratedColumn<String>(
    'market',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<double> shares = GeneratedColumn<double>(
    'shares',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgCostMeta = const VerificationMeta(
    'avgCost',
  );
  @override
  late final GeneratedColumn<double> avgCost = GeneratedColumn<double>(
    'avg_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceUpdatedAtMeta = const VerificationMeta(
    'priceUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> priceUpdatedAt =
      GeneratedColumn<DateTime>(
        'price_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    updatedAt,
    symbol,
    market,
    shares,
    avgCost,
    currentPrice,
    priceUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockAssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('market')) {
      context.handle(
        _marketMeta,
        market.isAcceptableOrUnknown(data['market']!, _marketMeta),
      );
    } else if (isInserting) {
      context.missing(_marketMeta);
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
    }
    if (data.containsKey('avg_cost')) {
      context.handle(
        _avgCostMeta,
        avgCost.isAcceptableOrUnknown(data['avg_cost']!, _avgCostMeta),
      );
    } else if (isInserting) {
      context.missing(_avgCostMeta);
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    }
    if (data.containsKey('price_updated_at')) {
      context.handle(
        _priceUpdatedAtMeta,
        priceUpdatedAt.isAcceptableOrUnknown(
          data['price_updated_at']!,
          _priceUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockAssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockAssetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      market: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shares'],
      )!,
      avgCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_cost'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      ),
      priceUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}price_updated_at'],
      ),
    );
  }

  @override
  $StockAssetsTable createAlias(String alias) {
    return $StockAssetsTable(attachedDatabase, alias);
  }
}

class StockAssetRow extends DataClass implements Insertable<StockAssetRow> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String symbol;
  final String market;
  final double shares;
  final double avgCost;
  final double? currentPrice;
  final DateTime? priceUpdatedAt;
  const StockAssetRow({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.symbol,
    required this.market,
    required this.shares,
    required this.avgCost,
    this.currentPrice,
    this.priceUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['symbol'] = Variable<String>(symbol);
    map['market'] = Variable<String>(market);
    map['shares'] = Variable<double>(shares);
    map['avg_cost'] = Variable<double>(avgCost);
    if (!nullToAbsent || currentPrice != null) {
      map['current_price'] = Variable<double>(currentPrice);
    }
    if (!nullToAbsent || priceUpdatedAt != null) {
      map['price_updated_at'] = Variable<DateTime>(priceUpdatedAt);
    }
    return map;
  }

  StockAssetsCompanion toCompanion(bool nullToAbsent) {
    return StockAssetsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      symbol: Value(symbol),
      market: Value(market),
      shares: Value(shares),
      avgCost: Value(avgCost),
      currentPrice: currentPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPrice),
      priceUpdatedAt: priceUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(priceUpdatedAt),
    );
  }

  factory StockAssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockAssetRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      symbol: serializer.fromJson<String>(json['symbol']),
      market: serializer.fromJson<String>(json['market']),
      shares: serializer.fromJson<double>(json['shares']),
      avgCost: serializer.fromJson<double>(json['avgCost']),
      currentPrice: serializer.fromJson<double?>(json['currentPrice']),
      priceUpdatedAt: serializer.fromJson<DateTime?>(json['priceUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'symbol': serializer.toJson<String>(symbol),
      'market': serializer.toJson<String>(market),
      'shares': serializer.toJson<double>(shares),
      'avgCost': serializer.toJson<double>(avgCost),
      'currentPrice': serializer.toJson<double?>(currentPrice),
      'priceUpdatedAt': serializer.toJson<DateTime?>(priceUpdatedAt),
    };
  }

  StockAssetRow copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? symbol,
    String? market,
    double? shares,
    double? avgCost,
    Value<double?> currentPrice = const Value.absent(),
    Value<DateTime?> priceUpdatedAt = const Value.absent(),
  }) => StockAssetRow(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    symbol: symbol ?? this.symbol,
    market: market ?? this.market,
    shares: shares ?? this.shares,
    avgCost: avgCost ?? this.avgCost,
    currentPrice: currentPrice.present ? currentPrice.value : this.currentPrice,
    priceUpdatedAt: priceUpdatedAt.present
        ? priceUpdatedAt.value
        : this.priceUpdatedAt,
  );
  StockAssetRow copyWithCompanion(StockAssetsCompanion data) {
    return StockAssetRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      market: data.market.present ? data.market.value : this.market,
      shares: data.shares.present ? data.shares.value : this.shares,
      avgCost: data.avgCost.present ? data.avgCost.value : this.avgCost,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      priceUpdatedAt: data.priceUpdatedAt.present
          ? data.priceUpdatedAt.value
          : this.priceUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockAssetRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('shares: $shares, ')
          ..write('avgCost: $avgCost, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('priceUpdatedAt: $priceUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    createdAt,
    updatedAt,
    symbol,
    market,
    shares,
    avgCost,
    currentPrice,
    priceUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockAssetRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.symbol == this.symbol &&
          other.market == this.market &&
          other.shares == this.shares &&
          other.avgCost == this.avgCost &&
          other.currentPrice == this.currentPrice &&
          other.priceUpdatedAt == this.priceUpdatedAt);
}

class StockAssetsCompanion extends UpdateCompanion<StockAssetRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> symbol;
  final Value<String> market;
  final Value<double> shares;
  final Value<double> avgCost;
  final Value<double?> currentPrice;
  final Value<DateTime?> priceUpdatedAt;
  final Value<int> rowid;
  const StockAssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.symbol = const Value.absent(),
    this.market = const Value.absent(),
    this.shares = const Value.absent(),
    this.avgCost = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.priceUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockAssetsCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String symbol,
    required String market,
    required double shares,
    required double avgCost,
    this.currentPrice = const Value.absent(),
    this.priceUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       symbol = Value(symbol),
       market = Value(market),
       shares = Value(shares),
       avgCost = Value(avgCost);
  static Insertable<StockAssetRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? symbol,
    Expression<String>? market,
    Expression<double>? shares,
    Expression<double>? avgCost,
    Expression<double>? currentPrice,
    Expression<DateTime>? priceUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (symbol != null) 'symbol': symbol,
      if (market != null) 'market': market,
      if (shares != null) 'shares': shares,
      if (avgCost != null) 'avg_cost': avgCost,
      if (currentPrice != null) 'current_price': currentPrice,
      if (priceUpdatedAt != null) 'price_updated_at': priceUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockAssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? symbol,
    Value<String>? market,
    Value<double>? shares,
    Value<double>? avgCost,
    Value<double?>? currentPrice,
    Value<DateTime?>? priceUpdatedAt,
    Value<int>? rowid,
  }) {
    return StockAssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      symbol: symbol ?? this.symbol,
      market: market ?? this.market,
      shares: shares ?? this.shares,
      avgCost: avgCost ?? this.avgCost,
      currentPrice: currentPrice ?? this.currentPrice,
      priceUpdatedAt: priceUpdatedAt ?? this.priceUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (market.present) {
      map['market'] = Variable<String>(market.value);
    }
    if (shares.present) {
      map['shares'] = Variable<double>(shares.value);
    }
    if (avgCost.present) {
      map['avg_cost'] = Variable<double>(avgCost.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (priceUpdatedAt.present) {
      map['price_updated_at'] = Variable<DateTime>(priceUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockAssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('symbol: $symbol, ')
          ..write('market: $market, ')
          ..write('shares: $shares, ')
          ..write('avgCost: $avgCost, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('priceUpdatedAt: $priceUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FundAssetsTable extends FundAssets
    with TableInfo<$FundAssetsTable, FundAssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FundAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _fundCodeMeta = const VerificationMeta(
    'fundCode',
  );
  @override
  late final GeneratedColumn<String> fundCode = GeneratedColumn<String>(
    'fund_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<double> units = GeneratedColumn<double>(
    'units',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgCostMeta = const VerificationMeta(
    'avgCost',
  );
  @override
  late final GeneratedColumn<double> avgCost = GeneratedColumn<double>(
    'avg_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentNavMeta = const VerificationMeta(
    'currentNav',
  );
  @override
  late final GeneratedColumn<double> currentNav = GeneratedColumn<double>(
    'current_nav',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _navUpdatedAtMeta = const VerificationMeta(
    'navUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> navUpdatedAt = GeneratedColumn<DateTime>(
    'nav_updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    updatedAt,
    fundCode,
    units,
    avgCost,
    currentNav,
    navUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fund_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<FundAssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('fund_code')) {
      context.handle(
        _fundCodeMeta,
        fundCode.isAcceptableOrUnknown(data['fund_code']!, _fundCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_fundCodeMeta);
    }
    if (data.containsKey('units')) {
      context.handle(
        _unitsMeta,
        units.isAcceptableOrUnknown(data['units']!, _unitsMeta),
      );
    } else if (isInserting) {
      context.missing(_unitsMeta);
    }
    if (data.containsKey('avg_cost')) {
      context.handle(
        _avgCostMeta,
        avgCost.isAcceptableOrUnknown(data['avg_cost']!, _avgCostMeta),
      );
    } else if (isInserting) {
      context.missing(_avgCostMeta);
    }
    if (data.containsKey('current_nav')) {
      context.handle(
        _currentNavMeta,
        currentNav.isAcceptableOrUnknown(data['current_nav']!, _currentNavMeta),
      );
    }
    if (data.containsKey('nav_updated_at')) {
      context.handle(
        _navUpdatedAtMeta,
        navUpdatedAt.isAcceptableOrUnknown(
          data['nav_updated_at']!,
          _navUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FundAssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FundAssetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      fundCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fund_code'],
      )!,
      units: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}units'],
      )!,
      avgCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_cost'],
      )!,
      currentNav: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_nav'],
      ),
      navUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}nav_updated_at'],
      ),
    );
  }

  @override
  $FundAssetsTable createAlias(String alias) {
    return $FundAssetsTable(attachedDatabase, alias);
  }
}

class FundAssetRow extends DataClass implements Insertable<FundAssetRow> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fundCode;
  final double units;
  final double avgCost;
  final double? currentNav;
  final DateTime? navUpdatedAt;
  const FundAssetRow({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.fundCode,
    required this.units,
    required this.avgCost,
    this.currentNav,
    this.navUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['fund_code'] = Variable<String>(fundCode);
    map['units'] = Variable<double>(units);
    map['avg_cost'] = Variable<double>(avgCost);
    if (!nullToAbsent || currentNav != null) {
      map['current_nav'] = Variable<double>(currentNav);
    }
    if (!nullToAbsent || navUpdatedAt != null) {
      map['nav_updated_at'] = Variable<DateTime>(navUpdatedAt);
    }
    return map;
  }

  FundAssetsCompanion toCompanion(bool nullToAbsent) {
    return FundAssetsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fundCode: Value(fundCode),
      units: Value(units),
      avgCost: Value(avgCost),
      currentNav: currentNav == null && nullToAbsent
          ? const Value.absent()
          : Value(currentNav),
      navUpdatedAt: navUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(navUpdatedAt),
    );
  }

  factory FundAssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FundAssetRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fundCode: serializer.fromJson<String>(json['fundCode']),
      units: serializer.fromJson<double>(json['units']),
      avgCost: serializer.fromJson<double>(json['avgCost']),
      currentNav: serializer.fromJson<double?>(json['currentNav']),
      navUpdatedAt: serializer.fromJson<DateTime?>(json['navUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fundCode': serializer.toJson<String>(fundCode),
      'units': serializer.toJson<double>(units),
      'avgCost': serializer.toJson<double>(avgCost),
      'currentNav': serializer.toJson<double?>(currentNav),
      'navUpdatedAt': serializer.toJson<DateTime?>(navUpdatedAt),
    };
  }

  FundAssetRow copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fundCode,
    double? units,
    double? avgCost,
    Value<double?> currentNav = const Value.absent(),
    Value<DateTime?> navUpdatedAt = const Value.absent(),
  }) => FundAssetRow(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    fundCode: fundCode ?? this.fundCode,
    units: units ?? this.units,
    avgCost: avgCost ?? this.avgCost,
    currentNav: currentNav.present ? currentNav.value : this.currentNav,
    navUpdatedAt: navUpdatedAt.present ? navUpdatedAt.value : this.navUpdatedAt,
  );
  FundAssetRow copyWithCompanion(FundAssetsCompanion data) {
    return FundAssetRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      fundCode: data.fundCode.present ? data.fundCode.value : this.fundCode,
      units: data.units.present ? data.units.value : this.units,
      avgCost: data.avgCost.present ? data.avgCost.value : this.avgCost,
      currentNav: data.currentNav.present
          ? data.currentNav.value
          : this.currentNav,
      navUpdatedAt: data.navUpdatedAt.present
          ? data.navUpdatedAt.value
          : this.navUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FundAssetRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fundCode: $fundCode, ')
          ..write('units: $units, ')
          ..write('avgCost: $avgCost, ')
          ..write('currentNav: $currentNav, ')
          ..write('navUpdatedAt: $navUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    createdAt,
    updatedAt,
    fundCode,
    units,
    avgCost,
    currentNav,
    navUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FundAssetRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fundCode == this.fundCode &&
          other.units == this.units &&
          other.avgCost == this.avgCost &&
          other.currentNav == this.currentNav &&
          other.navUpdatedAt == this.navUpdatedAt);
}

class FundAssetsCompanion extends UpdateCompanion<FundAssetRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> fundCode;
  final Value<double> units;
  final Value<double> avgCost;
  final Value<double?> currentNav;
  final Value<DateTime?> navUpdatedAt;
  final Value<int> rowid;
  const FundAssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fundCode = const Value.absent(),
    this.units = const Value.absent(),
    this.avgCost = const Value.absent(),
    this.currentNav = const Value.absent(),
    this.navUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FundAssetsCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String fundCode,
    required double units,
    required double avgCost,
    this.currentNav = const Value.absent(),
    this.navUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       fundCode = Value(fundCode),
       units = Value(units),
       avgCost = Value(avgCost);
  static Insertable<FundAssetRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? fundCode,
    Expression<double>? units,
    Expression<double>? avgCost,
    Expression<double>? currentNav,
    Expression<DateTime>? navUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fundCode != null) 'fund_code': fundCode,
      if (units != null) 'units': units,
      if (avgCost != null) 'avg_cost': avgCost,
      if (currentNav != null) 'current_nav': currentNav,
      if (navUpdatedAt != null) 'nav_updated_at': navUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FundAssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? fundCode,
    Value<double>? units,
    Value<double>? avgCost,
    Value<double?>? currentNav,
    Value<DateTime?>? navUpdatedAt,
    Value<int>? rowid,
  }) {
    return FundAssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fundCode: fundCode ?? this.fundCode,
      units: units ?? this.units,
      avgCost: avgCost ?? this.avgCost,
      currentNav: currentNav ?? this.currentNav,
      navUpdatedAt: navUpdatedAt ?? this.navUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (fundCode.present) {
      map['fund_code'] = Variable<String>(fundCode.value);
    }
    if (units.present) {
      map['units'] = Variable<double>(units.value);
    }
    if (avgCost.present) {
      map['avg_cost'] = Variable<double>(avgCost.value);
    }
    if (currentNav.present) {
      map['current_nav'] = Variable<double>(currentNav.value);
    }
    if (navUpdatedAt.present) {
      map['nav_updated_at'] = Variable<DateTime>(navUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FundAssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fundCode: $fundCode, ')
          ..write('units: $units, ')
          ..write('avgCost: $avgCost, ')
          ..write('currentNav: $currentNav, ')
          ..write('navUpdatedAt: $navUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CryptoAssetsTable extends CryptoAssets
    with TableInfo<$CryptoAssetsTable, CryptoAssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CryptoAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgCostMeta = const VerificationMeta(
    'avgCost',
  );
  @override
  late final GeneratedColumn<double> avgCost = GeneratedColumn<double>(
    'avg_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceUpdatedAtMeta = const VerificationMeta(
    'priceUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> priceUpdatedAt =
      GeneratedColumn<DateTime>(
        'price_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    updatedAt,
    symbol,
    amount,
    avgCost,
    currentPrice,
    priceUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crypto_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<CryptoAssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('avg_cost')) {
      context.handle(
        _avgCostMeta,
        avgCost.isAcceptableOrUnknown(data['avg_cost']!, _avgCostMeta),
      );
    } else if (isInserting) {
      context.missing(_avgCostMeta);
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    }
    if (data.containsKey('price_updated_at')) {
      context.handle(
        _priceUpdatedAtMeta,
        priceUpdatedAt.isAcceptableOrUnknown(
          data['price_updated_at']!,
          _priceUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CryptoAssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CryptoAssetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      avgCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_cost'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      ),
      priceUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}price_updated_at'],
      ),
    );
  }

  @override
  $CryptoAssetsTable createAlias(String alias) {
    return $CryptoAssetsTable(attachedDatabase, alias);
  }
}

class CryptoAssetRow extends DataClass implements Insertable<CryptoAssetRow> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String symbol;
  final double amount;
  final double avgCost;
  final double? currentPrice;
  final DateTime? priceUpdatedAt;
  const CryptoAssetRow({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.symbol,
    required this.amount,
    required this.avgCost,
    this.currentPrice,
    this.priceUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['symbol'] = Variable<String>(symbol);
    map['amount'] = Variable<double>(amount);
    map['avg_cost'] = Variable<double>(avgCost);
    if (!nullToAbsent || currentPrice != null) {
      map['current_price'] = Variable<double>(currentPrice);
    }
    if (!nullToAbsent || priceUpdatedAt != null) {
      map['price_updated_at'] = Variable<DateTime>(priceUpdatedAt);
    }
    return map;
  }

  CryptoAssetsCompanion toCompanion(bool nullToAbsent) {
    return CryptoAssetsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      symbol: Value(symbol),
      amount: Value(amount),
      avgCost: Value(avgCost),
      currentPrice: currentPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPrice),
      priceUpdatedAt: priceUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(priceUpdatedAt),
    );
  }

  factory CryptoAssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CryptoAssetRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      symbol: serializer.fromJson<String>(json['symbol']),
      amount: serializer.fromJson<double>(json['amount']),
      avgCost: serializer.fromJson<double>(json['avgCost']),
      currentPrice: serializer.fromJson<double?>(json['currentPrice']),
      priceUpdatedAt: serializer.fromJson<DateTime?>(json['priceUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'symbol': serializer.toJson<String>(symbol),
      'amount': serializer.toJson<double>(amount),
      'avgCost': serializer.toJson<double>(avgCost),
      'currentPrice': serializer.toJson<double?>(currentPrice),
      'priceUpdatedAt': serializer.toJson<DateTime?>(priceUpdatedAt),
    };
  }

  CryptoAssetRow copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? symbol,
    double? amount,
    double? avgCost,
    Value<double?> currentPrice = const Value.absent(),
    Value<DateTime?> priceUpdatedAt = const Value.absent(),
  }) => CryptoAssetRow(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    symbol: symbol ?? this.symbol,
    amount: amount ?? this.amount,
    avgCost: avgCost ?? this.avgCost,
    currentPrice: currentPrice.present ? currentPrice.value : this.currentPrice,
    priceUpdatedAt: priceUpdatedAt.present
        ? priceUpdatedAt.value
        : this.priceUpdatedAt,
  );
  CryptoAssetRow copyWithCompanion(CryptoAssetsCompanion data) {
    return CryptoAssetRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      amount: data.amount.present ? data.amount.value : this.amount,
      avgCost: data.avgCost.present ? data.avgCost.value : this.avgCost,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      priceUpdatedAt: data.priceUpdatedAt.present
          ? data.priceUpdatedAt.value
          : this.priceUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CryptoAssetRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('symbol: $symbol, ')
          ..write('amount: $amount, ')
          ..write('avgCost: $avgCost, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('priceUpdatedAt: $priceUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    createdAt,
    updatedAt,
    symbol,
    amount,
    avgCost,
    currentPrice,
    priceUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CryptoAssetRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.symbol == this.symbol &&
          other.amount == this.amount &&
          other.avgCost == this.avgCost &&
          other.currentPrice == this.currentPrice &&
          other.priceUpdatedAt == this.priceUpdatedAt);
}

class CryptoAssetsCompanion extends UpdateCompanion<CryptoAssetRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> symbol;
  final Value<double> amount;
  final Value<double> avgCost;
  final Value<double?> currentPrice;
  final Value<DateTime?> priceUpdatedAt;
  final Value<int> rowid;
  const CryptoAssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.symbol = const Value.absent(),
    this.amount = const Value.absent(),
    this.avgCost = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.priceUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CryptoAssetsCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String symbol,
    required double amount,
    required double avgCost,
    this.currentPrice = const Value.absent(),
    this.priceUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       symbol = Value(symbol),
       amount = Value(amount),
       avgCost = Value(avgCost);
  static Insertable<CryptoAssetRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? symbol,
    Expression<double>? amount,
    Expression<double>? avgCost,
    Expression<double>? currentPrice,
    Expression<DateTime>? priceUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (symbol != null) 'symbol': symbol,
      if (amount != null) 'amount': amount,
      if (avgCost != null) 'avg_cost': avgCost,
      if (currentPrice != null) 'current_price': currentPrice,
      if (priceUpdatedAt != null) 'price_updated_at': priceUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CryptoAssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? symbol,
    Value<double>? amount,
    Value<double>? avgCost,
    Value<double?>? currentPrice,
    Value<DateTime?>? priceUpdatedAt,
    Value<int>? rowid,
  }) {
    return CryptoAssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      symbol: symbol ?? this.symbol,
      amount: amount ?? this.amount,
      avgCost: avgCost ?? this.avgCost,
      currentPrice: currentPrice ?? this.currentPrice,
      priceUpdatedAt: priceUpdatedAt ?? this.priceUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (avgCost.present) {
      map['avg_cost'] = Variable<double>(avgCost.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (priceUpdatedAt.present) {
      map['price_updated_at'] = Variable<DateTime>(priceUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CryptoAssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('symbol: $symbol, ')
          ..write('amount: $amount, ')
          ..write('avgCost: $avgCost, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('priceUpdatedAt: $priceUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailySnapshotsTable extends DailySnapshots
    with TableInfo<$DailySnapshotsTable, DailySnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailySnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalValueMeta = const VerificationMeta(
    'totalValue',
  );
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
    'total_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashValueMeta = const VerificationMeta(
    'cashValue',
  );
  @override
  late final GeneratedColumn<double> cashValue = GeneratedColumn<double>(
    'cash_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stockValueMeta = const VerificationMeta(
    'stockValue',
  );
  @override
  late final GeneratedColumn<double> stockValue = GeneratedColumn<double>(
    'stock_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fundValueMeta = const VerificationMeta(
    'fundValue',
  );
  @override
  late final GeneratedColumn<double> fundValue = GeneratedColumn<double>(
    'fund_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cryptoValueMeta = const VerificationMeta(
    'cryptoValue',
  );
  @override
  late final GeneratedColumn<double> cryptoValue = GeneratedColumn<double>(
    'crypto_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    totalValue,
    cashValue,
    stockValue,
    fundValue,
    cryptoValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailySnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_value')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['total_value']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
    }
    if (data.containsKey('cash_value')) {
      context.handle(
        _cashValueMeta,
        cashValue.isAcceptableOrUnknown(data['cash_value']!, _cashValueMeta),
      );
    }
    if (data.containsKey('stock_value')) {
      context.handle(
        _stockValueMeta,
        stockValue.isAcceptableOrUnknown(data['stock_value']!, _stockValueMeta),
      );
    }
    if (data.containsKey('fund_value')) {
      context.handle(
        _fundValueMeta,
        fundValue.isAcceptableOrUnknown(data['fund_value']!, _fundValueMeta),
      );
    }
    if (data.containsKey('crypto_value')) {
      context.handle(
        _cryptoValueMeta,
        cryptoValue.isAcceptableOrUnknown(
          data['crypto_value']!,
          _cryptoValueMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailySnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailySnapshotRow(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_value'],
      )!,
      cashValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cash_value'],
      )!,
      stockValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_value'],
      )!,
      fundValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fund_value'],
      )!,
      cryptoValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}crypto_value'],
      )!,
    );
  }

  @override
  $DailySnapshotsTable createAlias(String alias) {
    return $DailySnapshotsTable(attachedDatabase, alias);
  }
}

class DailySnapshotRow extends DataClass
    implements Insertable<DailySnapshotRow> {
  final String date;
  final double totalValue;
  final double cashValue;
  final double stockValue;
  final double fundValue;
  final double cryptoValue;
  const DailySnapshotRow({
    required this.date,
    required this.totalValue,
    required this.cashValue,
    required this.stockValue,
    required this.fundValue,
    required this.cryptoValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['total_value'] = Variable<double>(totalValue);
    map['cash_value'] = Variable<double>(cashValue);
    map['stock_value'] = Variable<double>(stockValue);
    map['fund_value'] = Variable<double>(fundValue);
    map['crypto_value'] = Variable<double>(cryptoValue);
    return map;
  }

  DailySnapshotsCompanion toCompanion(bool nullToAbsent) {
    return DailySnapshotsCompanion(
      date: Value(date),
      totalValue: Value(totalValue),
      cashValue: Value(cashValue),
      stockValue: Value(stockValue),
      fundValue: Value(fundValue),
      cryptoValue: Value(cryptoValue),
    );
  }

  factory DailySnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailySnapshotRow(
      date: serializer.fromJson<String>(json['date']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      cashValue: serializer.fromJson<double>(json['cashValue']),
      stockValue: serializer.fromJson<double>(json['stockValue']),
      fundValue: serializer.fromJson<double>(json['fundValue']),
      cryptoValue: serializer.fromJson<double>(json['cryptoValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'totalValue': serializer.toJson<double>(totalValue),
      'cashValue': serializer.toJson<double>(cashValue),
      'stockValue': serializer.toJson<double>(stockValue),
      'fundValue': serializer.toJson<double>(fundValue),
      'cryptoValue': serializer.toJson<double>(cryptoValue),
    };
  }

  DailySnapshotRow copyWith({
    String? date,
    double? totalValue,
    double? cashValue,
    double? stockValue,
    double? fundValue,
    double? cryptoValue,
  }) => DailySnapshotRow(
    date: date ?? this.date,
    totalValue: totalValue ?? this.totalValue,
    cashValue: cashValue ?? this.cashValue,
    stockValue: stockValue ?? this.stockValue,
    fundValue: fundValue ?? this.fundValue,
    cryptoValue: cryptoValue ?? this.cryptoValue,
  );
  DailySnapshotRow copyWithCompanion(DailySnapshotsCompanion data) {
    return DailySnapshotRow(
      date: data.date.present ? data.date.value : this.date,
      totalValue: data.totalValue.present
          ? data.totalValue.value
          : this.totalValue,
      cashValue: data.cashValue.present ? data.cashValue.value : this.cashValue,
      stockValue: data.stockValue.present
          ? data.stockValue.value
          : this.stockValue,
      fundValue: data.fundValue.present ? data.fundValue.value : this.fundValue,
      cryptoValue: data.cryptoValue.present
          ? data.cryptoValue.value
          : this.cryptoValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailySnapshotRow(')
          ..write('date: $date, ')
          ..write('totalValue: $totalValue, ')
          ..write('cashValue: $cashValue, ')
          ..write('stockValue: $stockValue, ')
          ..write('fundValue: $fundValue, ')
          ..write('cryptoValue: $cryptoValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    date,
    totalValue,
    cashValue,
    stockValue,
    fundValue,
    cryptoValue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailySnapshotRow &&
          other.date == this.date &&
          other.totalValue == this.totalValue &&
          other.cashValue == this.cashValue &&
          other.stockValue == this.stockValue &&
          other.fundValue == this.fundValue &&
          other.cryptoValue == this.cryptoValue);
}

class DailySnapshotsCompanion extends UpdateCompanion<DailySnapshotRow> {
  final Value<String> date;
  final Value<double> totalValue;
  final Value<double> cashValue;
  final Value<double> stockValue;
  final Value<double> fundValue;
  final Value<double> cryptoValue;
  final Value<int> rowid;
  const DailySnapshotsCompanion({
    this.date = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.cashValue = const Value.absent(),
    this.stockValue = const Value.absent(),
    this.fundValue = const Value.absent(),
    this.cryptoValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailySnapshotsCompanion.insert({
    required String date,
    required double totalValue,
    this.cashValue = const Value.absent(),
    this.stockValue = const Value.absent(),
    this.fundValue = const Value.absent(),
    this.cryptoValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       totalValue = Value(totalValue);
  static Insertable<DailySnapshotRow> custom({
    Expression<String>? date,
    Expression<double>? totalValue,
    Expression<double>? cashValue,
    Expression<double>? stockValue,
    Expression<double>? fundValue,
    Expression<double>? cryptoValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (totalValue != null) 'total_value': totalValue,
      if (cashValue != null) 'cash_value': cashValue,
      if (stockValue != null) 'stock_value': stockValue,
      if (fundValue != null) 'fund_value': fundValue,
      if (cryptoValue != null) 'crypto_value': cryptoValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailySnapshotsCompanion copyWith({
    Value<String>? date,
    Value<double>? totalValue,
    Value<double>? cashValue,
    Value<double>? stockValue,
    Value<double>? fundValue,
    Value<double>? cryptoValue,
    Value<int>? rowid,
  }) {
    return DailySnapshotsCompanion(
      date: date ?? this.date,
      totalValue: totalValue ?? this.totalValue,
      cashValue: cashValue ?? this.cashValue,
      stockValue: stockValue ?? this.stockValue,
      fundValue: fundValue ?? this.fundValue,
      cryptoValue: cryptoValue ?? this.cryptoValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (totalValue.present) {
      map['total_value'] = Variable<double>(totalValue.value);
    }
    if (cashValue.present) {
      map['cash_value'] = Variable<double>(cashValue.value);
    }
    if (stockValue.present) {
      map['stock_value'] = Variable<double>(stockValue.value);
    }
    if (fundValue.present) {
      map['fund_value'] = Variable<double>(fundValue.value);
    }
    if (cryptoValue.present) {
      map['crypto_value'] = Variable<double>(cryptoValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailySnapshotsCompanion(')
          ..write('date: $date, ')
          ..write('totalValue: $totalValue, ')
          ..write('cashValue: $cashValue, ')
          ..write('stockValue: $stockValue, ')
          ..write('fundValue: $fundValue, ')
          ..write('cryptoValue: $cryptoValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTable extends ExchangeRates
    with TableInfo<$ExchangeRatesTable, ExchangeRateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fromCurrencyMeta = const VerificationMeta(
    'fromCurrency',
  );
  @override
  late final GeneratedColumn<String> fromCurrency = GeneratedColumn<String>(
    'from_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toCurrencyMeta = const VerificationMeta(
    'toCurrency',
  );
  @override
  late final GeneratedColumn<String> toCurrency = GeneratedColumn<String>(
    'to_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromCurrency,
    toCurrency,
    rate,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_currency')) {
      context.handle(
        _fromCurrencyMeta,
        fromCurrency.isAcceptableOrUnknown(
          data['from_currency']!,
          _fromCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromCurrencyMeta);
    }
    if (data.containsKey('to_currency')) {
      context.handle(
        _toCurrencyMeta,
        toCurrency.isAcceptableOrUnknown(data['to_currency']!, _toCurrencyMeta),
      );
    } else if (isInserting) {
      context.missing(_toCurrencyMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fromCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_currency'],
      )!,
      toCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_currency'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $ExchangeRatesTable createAlias(String alias) {
    return $ExchangeRatesTable(attachedDatabase, alias);
  }
}

class ExchangeRateRow extends DataClass implements Insertable<ExchangeRateRow> {
  final int id;
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime fetchedAt;
  const ExchangeRateRow({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_currency'] = Variable<String>(fromCurrency);
    map['to_currency'] = Variable<String>(toCurrency);
    map['rate'] = Variable<double>(rate);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      id: Value(id),
      fromCurrency: Value(fromCurrency),
      toCurrency: Value(toCurrency),
      rate: Value(rate),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory ExchangeRateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRateRow(
      id: serializer.fromJson<int>(json['id']),
      fromCurrency: serializer.fromJson<String>(json['fromCurrency']),
      toCurrency: serializer.fromJson<String>(json['toCurrency']),
      rate: serializer.fromJson<double>(json['rate']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromCurrency': serializer.toJson<String>(fromCurrency),
      'toCurrency': serializer.toJson<String>(toCurrency),
      'rate': serializer.toJson<double>(rate),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  ExchangeRateRow copyWith({
    int? id,
    String? fromCurrency,
    String? toCurrency,
    double? rate,
    DateTime? fetchedAt,
  }) => ExchangeRateRow(
    id: id ?? this.id,
    fromCurrency: fromCurrency ?? this.fromCurrency,
    toCurrency: toCurrency ?? this.toCurrency,
    rate: rate ?? this.rate,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  ExchangeRateRow copyWithCompanion(ExchangeRatesCompanion data) {
    return ExchangeRateRow(
      id: data.id.present ? data.id.value : this.id,
      fromCurrency: data.fromCurrency.present
          ? data.fromCurrency.value
          : this.fromCurrency,
      toCurrency: data.toCurrency.present
          ? data.toCurrency.value
          : this.toCurrency,
      rate: data.rate.present ? data.rate.value : this.rate,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRateRow(')
          ..write('id: $id, ')
          ..write('fromCurrency: $fromCurrency, ')
          ..write('toCurrency: $toCurrency, ')
          ..write('rate: $rate, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fromCurrency, toCurrency, rate, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRateRow &&
          other.id == this.id &&
          other.fromCurrency == this.fromCurrency &&
          other.toCurrency == this.toCurrency &&
          other.rate == this.rate &&
          other.fetchedAt == this.fetchedAt);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRateRow> {
  final Value<int> id;
  final Value<String> fromCurrency;
  final Value<String> toCurrency;
  final Value<double> rate;
  final Value<DateTime> fetchedAt;
  const ExchangeRatesCompanion({
    this.id = const Value.absent(),
    this.fromCurrency = const Value.absent(),
    this.toCurrency = const Value.absent(),
    this.rate = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    this.id = const Value.absent(),
    required String fromCurrency,
    required String toCurrency,
    required double rate,
    required DateTime fetchedAt,
  }) : fromCurrency = Value(fromCurrency),
       toCurrency = Value(toCurrency),
       rate = Value(rate),
       fetchedAt = Value(fetchedAt);
  static Insertable<ExchangeRateRow> custom({
    Expression<int>? id,
    Expression<String>? fromCurrency,
    Expression<String>? toCurrency,
    Expression<double>? rate,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromCurrency != null) 'from_currency': fromCurrency,
      if (toCurrency != null) 'to_currency': toCurrency,
      if (rate != null) 'rate': rate,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  ExchangeRatesCompanion copyWith({
    Value<int>? id,
    Value<String>? fromCurrency,
    Value<String>? toCurrency,
    Value<double>? rate,
    Value<DateTime>? fetchedAt,
  }) {
    return ExchangeRatesCompanion(
      id: id ?? this.id,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      rate: rate ?? this.rate,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromCurrency.present) {
      map['from_currency'] = Variable<String>(fromCurrency.value);
    }
    if (toCurrency.present) {
      map['to_currency'] = Variable<String>(toCurrency.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('id: $id, ')
          ..write('fromCurrency: $fromCurrency, ')
          ..write('toCurrency: $toCurrency, ')
          ..write('rate: $rate, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CashAssetsTable cashAssets = $CashAssetsTable(this);
  late final $StockAssetsTable stockAssets = $StockAssetsTable(this);
  late final $FundAssetsTable fundAssets = $FundAssetsTable(this);
  late final $CryptoAssetsTable cryptoAssets = $CryptoAssetsTable(this);
  late final $DailySnapshotsTable dailySnapshots = $DailySnapshotsTable(this);
  late final $ExchangeRatesTable exchangeRates = $ExchangeRatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cashAssets,
    stockAssets,
    fundAssets,
    cryptoAssets,
    dailySnapshots,
    exchangeRates,
  ];
}

typedef $$CashAssetsTableCreateCompanionBuilder =
    CashAssetsCompanion Function({
      required String id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String currency,
      required String bankName,
      required double amount,
      Value<int> rowid,
    });
typedef $$CashAssetsTableUpdateCompanionBuilder =
    CashAssetsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> currency,
      Value<String> bankName,
      Value<double> amount,
      Value<int> rowid,
    });

class $$CashAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $CashAssetsTable> {
  $$CashAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashAssetsTable> {
  $$CashAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashAssetsTable> {
  $$CashAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$CashAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashAssetsTable,
          CashAssetRow,
          $$CashAssetsTableFilterComposer,
          $$CashAssetsTableOrderingComposer,
          $$CashAssetsTableAnnotationComposer,
          $$CashAssetsTableCreateCompanionBuilder,
          $$CashAssetsTableUpdateCompanionBuilder,
          (
            CashAssetRow,
            BaseReferences<_$AppDatabase, $CashAssetsTable, CashAssetRow>,
          ),
          CashAssetRow,
          PrefetchHooks Function()
        > {
  $$CashAssetsTableTableManager(_$AppDatabase db, $CashAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashAssetsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                currency: currency,
                bankName: bankName,
                amount: amount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String currency,
                required String bankName,
                required double amount,
                Value<int> rowid = const Value.absent(),
              }) => CashAssetsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                currency: currency,
                bankName: bankName,
                amount: amount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashAssetsTable,
      CashAssetRow,
      $$CashAssetsTableFilterComposer,
      $$CashAssetsTableOrderingComposer,
      $$CashAssetsTableAnnotationComposer,
      $$CashAssetsTableCreateCompanionBuilder,
      $$CashAssetsTableUpdateCompanionBuilder,
      (
        CashAssetRow,
        BaseReferences<_$AppDatabase, $CashAssetsTable, CashAssetRow>,
      ),
      CashAssetRow,
      PrefetchHooks Function()
    >;
typedef $$StockAssetsTableCreateCompanionBuilder =
    StockAssetsCompanion Function({
      required String id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String symbol,
      required String market,
      required double shares,
      required double avgCost,
      Value<double?> currentPrice,
      Value<DateTime?> priceUpdatedAt,
      Value<int> rowid,
    });
typedef $$StockAssetsTableUpdateCompanionBuilder =
    StockAssetsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> symbol,
      Value<String> market,
      Value<double> shares,
      Value<double> avgCost,
      Value<double?> currentPrice,
      Value<DateTime?> priceUpdatedAt,
      Value<int> rowid,
    });

class $$StockAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $StockAssetsTable> {
  $$StockAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgCost => $composableBuilder(
    column: $table.avgCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get priceUpdatedAt => $composableBuilder(
    column: $table.priceUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockAssetsTable> {
  $$StockAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get market => $composableBuilder(
    column: $table.market,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgCost => $composableBuilder(
    column: $table.avgCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get priceUpdatedAt => $composableBuilder(
    column: $table.priceUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockAssetsTable> {
  $$StockAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get market =>
      $composableBuilder(column: $table.market, builder: (column) => column);

  GeneratedColumn<double> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<double> get avgCost =>
      $composableBuilder(column: $table.avgCost, builder: (column) => column);

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get priceUpdatedAt => $composableBuilder(
    column: $table.priceUpdatedAt,
    builder: (column) => column,
  );
}

class $$StockAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockAssetsTable,
          StockAssetRow,
          $$StockAssetsTableFilterComposer,
          $$StockAssetsTableOrderingComposer,
          $$StockAssetsTableAnnotationComposer,
          $$StockAssetsTableCreateCompanionBuilder,
          $$StockAssetsTableUpdateCompanionBuilder,
          (
            StockAssetRow,
            BaseReferences<_$AppDatabase, $StockAssetsTable, StockAssetRow>,
          ),
          StockAssetRow,
          PrefetchHooks Function()
        > {
  $$StockAssetsTableTableManager(_$AppDatabase db, $StockAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String> market = const Value.absent(),
                Value<double> shares = const Value.absent(),
                Value<double> avgCost = const Value.absent(),
                Value<double?> currentPrice = const Value.absent(),
                Value<DateTime?> priceUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockAssetsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                symbol: symbol,
                market: market,
                shares: shares,
                avgCost: avgCost,
                currentPrice: currentPrice,
                priceUpdatedAt: priceUpdatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String symbol,
                required String market,
                required double shares,
                required double avgCost,
                Value<double?> currentPrice = const Value.absent(),
                Value<DateTime?> priceUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockAssetsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                symbol: symbol,
                market: market,
                shares: shares,
                avgCost: avgCost,
                currentPrice: currentPrice,
                priceUpdatedAt: priceUpdatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockAssetsTable,
      StockAssetRow,
      $$StockAssetsTableFilterComposer,
      $$StockAssetsTableOrderingComposer,
      $$StockAssetsTableAnnotationComposer,
      $$StockAssetsTableCreateCompanionBuilder,
      $$StockAssetsTableUpdateCompanionBuilder,
      (
        StockAssetRow,
        BaseReferences<_$AppDatabase, $StockAssetsTable, StockAssetRow>,
      ),
      StockAssetRow,
      PrefetchHooks Function()
    >;
typedef $$FundAssetsTableCreateCompanionBuilder =
    FundAssetsCompanion Function({
      required String id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String fundCode,
      required double units,
      required double avgCost,
      Value<double?> currentNav,
      Value<DateTime?> navUpdatedAt,
      Value<int> rowid,
    });
typedef $$FundAssetsTableUpdateCompanionBuilder =
    FundAssetsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> fundCode,
      Value<double> units,
      Value<double> avgCost,
      Value<double?> currentNav,
      Value<DateTime?> navUpdatedAt,
      Value<int> rowid,
    });

class $$FundAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $FundAssetsTable> {
  $$FundAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fundCode => $composableBuilder(
    column: $table.fundCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgCost => $composableBuilder(
    column: $table.avgCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentNav => $composableBuilder(
    column: $table.currentNav,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get navUpdatedAt => $composableBuilder(
    column: $table.navUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FundAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $FundAssetsTable> {
  $$FundAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fundCode => $composableBuilder(
    column: $table.fundCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgCost => $composableBuilder(
    column: $table.avgCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentNav => $composableBuilder(
    column: $table.currentNav,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get navUpdatedAt => $composableBuilder(
    column: $table.navUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FundAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FundAssetsTable> {
  $$FundAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get fundCode =>
      $composableBuilder(column: $table.fundCode, builder: (column) => column);

  GeneratedColumn<double> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<double> get avgCost =>
      $composableBuilder(column: $table.avgCost, builder: (column) => column);

  GeneratedColumn<double> get currentNav => $composableBuilder(
    column: $table.currentNav,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get navUpdatedAt => $composableBuilder(
    column: $table.navUpdatedAt,
    builder: (column) => column,
  );
}

class $$FundAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FundAssetsTable,
          FundAssetRow,
          $$FundAssetsTableFilterComposer,
          $$FundAssetsTableOrderingComposer,
          $$FundAssetsTableAnnotationComposer,
          $$FundAssetsTableCreateCompanionBuilder,
          $$FundAssetsTableUpdateCompanionBuilder,
          (
            FundAssetRow,
            BaseReferences<_$AppDatabase, $FundAssetsTable, FundAssetRow>,
          ),
          FundAssetRow,
          PrefetchHooks Function()
        > {
  $$FundAssetsTableTableManager(_$AppDatabase db, $FundAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FundAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FundAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FundAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> fundCode = const Value.absent(),
                Value<double> units = const Value.absent(),
                Value<double> avgCost = const Value.absent(),
                Value<double?> currentNav = const Value.absent(),
                Value<DateTime?> navUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FundAssetsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                fundCode: fundCode,
                units: units,
                avgCost: avgCost,
                currentNav: currentNav,
                navUpdatedAt: navUpdatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String fundCode,
                required double units,
                required double avgCost,
                Value<double?> currentNav = const Value.absent(),
                Value<DateTime?> navUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FundAssetsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                fundCode: fundCode,
                units: units,
                avgCost: avgCost,
                currentNav: currentNav,
                navUpdatedAt: navUpdatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FundAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FundAssetsTable,
      FundAssetRow,
      $$FundAssetsTableFilterComposer,
      $$FundAssetsTableOrderingComposer,
      $$FundAssetsTableAnnotationComposer,
      $$FundAssetsTableCreateCompanionBuilder,
      $$FundAssetsTableUpdateCompanionBuilder,
      (
        FundAssetRow,
        BaseReferences<_$AppDatabase, $FundAssetsTable, FundAssetRow>,
      ),
      FundAssetRow,
      PrefetchHooks Function()
    >;
typedef $$CryptoAssetsTableCreateCompanionBuilder =
    CryptoAssetsCompanion Function({
      required String id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String symbol,
      required double amount,
      required double avgCost,
      Value<double?> currentPrice,
      Value<DateTime?> priceUpdatedAt,
      Value<int> rowid,
    });
typedef $$CryptoAssetsTableUpdateCompanionBuilder =
    CryptoAssetsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> symbol,
      Value<double> amount,
      Value<double> avgCost,
      Value<double?> currentPrice,
      Value<DateTime?> priceUpdatedAt,
      Value<int> rowid,
    });

class $$CryptoAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $CryptoAssetsTable> {
  $$CryptoAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgCost => $composableBuilder(
    column: $table.avgCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get priceUpdatedAt => $composableBuilder(
    column: $table.priceUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CryptoAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $CryptoAssetsTable> {
  $$CryptoAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgCost => $composableBuilder(
    column: $table.avgCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get priceUpdatedAt => $composableBuilder(
    column: $table.priceUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CryptoAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CryptoAssetsTable> {
  $$CryptoAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get avgCost =>
      $composableBuilder(column: $table.avgCost, builder: (column) => column);

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get priceUpdatedAt => $composableBuilder(
    column: $table.priceUpdatedAt,
    builder: (column) => column,
  );
}

class $$CryptoAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CryptoAssetsTable,
          CryptoAssetRow,
          $$CryptoAssetsTableFilterComposer,
          $$CryptoAssetsTableOrderingComposer,
          $$CryptoAssetsTableAnnotationComposer,
          $$CryptoAssetsTableCreateCompanionBuilder,
          $$CryptoAssetsTableUpdateCompanionBuilder,
          (
            CryptoAssetRow,
            BaseReferences<_$AppDatabase, $CryptoAssetsTable, CryptoAssetRow>,
          ),
          CryptoAssetRow,
          PrefetchHooks Function()
        > {
  $$CryptoAssetsTableTableManager(_$AppDatabase db, $CryptoAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CryptoAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CryptoAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CryptoAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> avgCost = const Value.absent(),
                Value<double?> currentPrice = const Value.absent(),
                Value<DateTime?> priceUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CryptoAssetsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                symbol: symbol,
                amount: amount,
                avgCost: avgCost,
                currentPrice: currentPrice,
                priceUpdatedAt: priceUpdatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String symbol,
                required double amount,
                required double avgCost,
                Value<double?> currentPrice = const Value.absent(),
                Value<DateTime?> priceUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CryptoAssetsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                symbol: symbol,
                amount: amount,
                avgCost: avgCost,
                currentPrice: currentPrice,
                priceUpdatedAt: priceUpdatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CryptoAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CryptoAssetsTable,
      CryptoAssetRow,
      $$CryptoAssetsTableFilterComposer,
      $$CryptoAssetsTableOrderingComposer,
      $$CryptoAssetsTableAnnotationComposer,
      $$CryptoAssetsTableCreateCompanionBuilder,
      $$CryptoAssetsTableUpdateCompanionBuilder,
      (
        CryptoAssetRow,
        BaseReferences<_$AppDatabase, $CryptoAssetsTable, CryptoAssetRow>,
      ),
      CryptoAssetRow,
      PrefetchHooks Function()
    >;
typedef $$DailySnapshotsTableCreateCompanionBuilder =
    DailySnapshotsCompanion Function({
      required String date,
      required double totalValue,
      Value<double> cashValue,
      Value<double> stockValue,
      Value<double> fundValue,
      Value<double> cryptoValue,
      Value<int> rowid,
    });
typedef $$DailySnapshotsTableUpdateCompanionBuilder =
    DailySnapshotsCompanion Function({
      Value<String> date,
      Value<double> totalValue,
      Value<double> cashValue,
      Value<double> stockValue,
      Value<double> fundValue,
      Value<double> cryptoValue,
      Value<int> rowid,
    });

class $$DailySnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $DailySnapshotsTable> {
  $$DailySnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cashValue => $composableBuilder(
    column: $table.cashValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockValue => $composableBuilder(
    column: $table.stockValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fundValue => $composableBuilder(
    column: $table.fundValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cryptoValue => $composableBuilder(
    column: $table.cryptoValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailySnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailySnapshotsTable> {
  $$DailySnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cashValue => $composableBuilder(
    column: $table.cashValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockValue => $composableBuilder(
    column: $table.stockValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fundValue => $composableBuilder(
    column: $table.fundValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cryptoValue => $composableBuilder(
    column: $table.cryptoValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailySnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailySnapshotsTable> {
  $$DailySnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cashValue =>
      $composableBuilder(column: $table.cashValue, builder: (column) => column);

  GeneratedColumn<double> get stockValue => $composableBuilder(
    column: $table.stockValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fundValue =>
      $composableBuilder(column: $table.fundValue, builder: (column) => column);

  GeneratedColumn<double> get cryptoValue => $composableBuilder(
    column: $table.cryptoValue,
    builder: (column) => column,
  );
}

class $$DailySnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailySnapshotsTable,
          DailySnapshotRow,
          $$DailySnapshotsTableFilterComposer,
          $$DailySnapshotsTableOrderingComposer,
          $$DailySnapshotsTableAnnotationComposer,
          $$DailySnapshotsTableCreateCompanionBuilder,
          $$DailySnapshotsTableUpdateCompanionBuilder,
          (
            DailySnapshotRow,
            BaseReferences<
              _$AppDatabase,
              $DailySnapshotsTable,
              DailySnapshotRow
            >,
          ),
          DailySnapshotRow,
          PrefetchHooks Function()
        > {
  $$DailySnapshotsTableTableManager(
    _$AppDatabase db,
    $DailySnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailySnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailySnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailySnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<double> cashValue = const Value.absent(),
                Value<double> stockValue = const Value.absent(),
                Value<double> fundValue = const Value.absent(),
                Value<double> cryptoValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailySnapshotsCompanion(
                date: date,
                totalValue: totalValue,
                cashValue: cashValue,
                stockValue: stockValue,
                fundValue: fundValue,
                cryptoValue: cryptoValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                required double totalValue,
                Value<double> cashValue = const Value.absent(),
                Value<double> stockValue = const Value.absent(),
                Value<double> fundValue = const Value.absent(),
                Value<double> cryptoValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailySnapshotsCompanion.insert(
                date: date,
                totalValue: totalValue,
                cashValue: cashValue,
                stockValue: stockValue,
                fundValue: fundValue,
                cryptoValue: cryptoValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailySnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailySnapshotsTable,
      DailySnapshotRow,
      $$DailySnapshotsTableFilterComposer,
      $$DailySnapshotsTableOrderingComposer,
      $$DailySnapshotsTableAnnotationComposer,
      $$DailySnapshotsTableCreateCompanionBuilder,
      $$DailySnapshotsTableUpdateCompanionBuilder,
      (
        DailySnapshotRow,
        BaseReferences<_$AppDatabase, $DailySnapshotsTable, DailySnapshotRow>,
      ),
      DailySnapshotRow,
      PrefetchHooks Function()
    >;
typedef $$ExchangeRatesTableCreateCompanionBuilder =
    ExchangeRatesCompanion Function({
      Value<int> id,
      required String fromCurrency,
      required String toCurrency,
      required double rate,
      required DateTime fetchedAt,
    });
typedef $$ExchangeRatesTableUpdateCompanionBuilder =
    ExchangeRatesCompanion Function({
      Value<int> id,
      Value<String> fromCurrency,
      Value<String> toCurrency,
      Value<double> rate,
      Value<DateTime> fetchedAt,
    });

class $$ExchangeRatesTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromCurrency => $composableBuilder(
    column: $table.fromCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toCurrency => $composableBuilder(
    column: $table.toCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExchangeRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromCurrency => $composableBuilder(
    column: $table.fromCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toCurrency => $composableBuilder(
    column: $table.toCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExchangeRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromCurrency => $composableBuilder(
    column: $table.fromCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toCurrency => $composableBuilder(
    column: $table.toCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$ExchangeRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTable,
          ExchangeRateRow,
          $$ExchangeRatesTableFilterComposer,
          $$ExchangeRatesTableOrderingComposer,
          $$ExchangeRatesTableAnnotationComposer,
          $$ExchangeRatesTableCreateCompanionBuilder,
          $$ExchangeRatesTableUpdateCompanionBuilder,
          (
            ExchangeRateRow,
            BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRateRow>,
          ),
          ExchangeRateRow,
          PrefetchHooks Function()
        > {
  $$ExchangeRatesTableTableManager(_$AppDatabase db, $ExchangeRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fromCurrency = const Value.absent(),
                Value<String> toCurrency = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => ExchangeRatesCompanion(
                id: id,
                fromCurrency: fromCurrency,
                toCurrency: toCurrency,
                rate: rate,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fromCurrency,
                required String toCurrency,
                required double rate,
                required DateTime fetchedAt,
              }) => ExchangeRatesCompanion.insert(
                id: id,
                fromCurrency: fromCurrency,
                toCurrency: toCurrency,
                rate: rate,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExchangeRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTable,
      ExchangeRateRow,
      $$ExchangeRatesTableFilterComposer,
      $$ExchangeRatesTableOrderingComposer,
      $$ExchangeRatesTableAnnotationComposer,
      $$ExchangeRatesTableCreateCompanionBuilder,
      $$ExchangeRatesTableUpdateCompanionBuilder,
      (
        ExchangeRateRow,
        BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRateRow>,
      ),
      ExchangeRateRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CashAssetsTableTableManager get cashAssets =>
      $$CashAssetsTableTableManager(_db, _db.cashAssets);
  $$StockAssetsTableTableManager get stockAssets =>
      $$StockAssetsTableTableManager(_db, _db.stockAssets);
  $$FundAssetsTableTableManager get fundAssets =>
      $$FundAssetsTableTableManager(_db, _db.fundAssets);
  $$CryptoAssetsTableTableManager get cryptoAssets =>
      $$CryptoAssetsTableTableManager(_db, _db.cryptoAssets);
  $$DailySnapshotsTableTableManager get dailySnapshots =>
      $$DailySnapshotsTableTableManager(_db, _db.dailySnapshots);
  $$ExchangeRatesTableTableManager get exchangeRates =>
      $$ExchangeRatesTableTableManager(_db, _db.exchangeRates);
}
