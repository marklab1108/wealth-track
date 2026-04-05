import 'package:flutter/foundation.dart';

enum AssetType { cash, stock, fund, crypto }

enum StockMarket { tw, us }

enum CurrencyCode { twd, usd, jpy, eur, gbp, aud, cad, chf, cny, hkd, sgd, krw }

extension CurrencyCodeX on CurrencyCode {
  String get label => name.toUpperCase();

  String get symbol => switch (this) {
        CurrencyCode.twd => 'NT\$',
        CurrencyCode.usd => '\$',
        CurrencyCode.jpy => '¥',
        CurrencyCode.eur => '€',
        CurrencyCode.gbp => '£',
        _ => name.toUpperCase(),
      };
}

@immutable
sealed class Asset {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Asset({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  AssetType get type;

  double valueTWD(Map<String, double> exchangeRates);
}

class CashAsset extends Asset {
  final CurrencyCode currency;
  final String bankName;
  final double amount;

  const CashAsset({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required this.currency,
    required this.bankName,
    required this.amount,
  });

  @override
  AssetType get type => AssetType.cash;

  @override
  double valueTWD(Map<String, double> exchangeRates) {
    if (currency == CurrencyCode.twd) return amount;
    final rate = exchangeRates['${currency.label}_TWD'];
    if (rate == null) return 0;
    return amount * rate;
  }
}

class StockAsset extends Asset {
  final String symbol;
  final StockMarket market;
  final double shares;
  final double avgCost;
  final double? currentPrice;
  final DateTime? priceUpdatedAt;

  const StockAsset({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required this.symbol,
    required this.market,
    required this.shares,
    required this.avgCost,
    this.currentPrice,
    this.priceUpdatedAt,
  });

  @override
  AssetType get type => AssetType.stock;

  double get marketValue => shares * (currentPrice ?? avgCost);

  double get returnRate {
    if (avgCost == 0) return 0;
    final price = currentPrice ?? avgCost;
    return (price - avgCost) / avgCost;
  }

  @override
  double valueTWD(Map<String, double> exchangeRates) {
    if (market == StockMarket.tw) return marketValue;
    final rate = exchangeRates['USD_TWD'];
    if (rate == null) return 0;
    return marketValue * rate;
  }
}

class FundAsset extends Asset {
  final String fundCode;
  final double units;
  final double avgCost;
  final double? currentNav;
  final DateTime? navUpdatedAt;

  const FundAsset({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required this.fundCode,
    required this.units,
    required this.avgCost,
    this.currentNav,
    this.navUpdatedAt,
  });

  @override
  AssetType get type => AssetType.fund;

  double get marketValue => units * (currentNav ?? avgCost);

  double get returnRate {
    if (avgCost == 0) return 0;
    final nav = currentNav ?? avgCost;
    return (nav - avgCost) / avgCost;
  }

  @override
  double valueTWD(Map<String, double> exchangeRates) => marketValue;
}

class CryptoAsset extends Asset {
  final String symbol;
  final double amount;
  final double avgCost;
  final double? currentPrice;
  final DateTime? priceUpdatedAt;

  const CryptoAsset({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required this.symbol,
    required this.amount,
    required this.avgCost,
    this.currentPrice,
    this.priceUpdatedAt,
  });

  @override
  AssetType get type => AssetType.crypto;

  double get marketValue => amount * (currentPrice ?? avgCost);

  double get returnRate {
    if (avgCost == 0) return 0;
    final price = currentPrice ?? avgCost;
    return (price - avgCost) / avgCost;
  }

  @override
  double valueTWD(Map<String, double> exchangeRates) {
    final rate = exchangeRates['USD_TWD'];
    if (rate == null) return marketValue;
    return marketValue * rate;
  }
}
