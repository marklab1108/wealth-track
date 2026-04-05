// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stockRepositoryHash() => r'4e59b1ef37c249e9d209d97ff436f0bc8eecbf94';

/// See also [stockRepository].
@ProviderFor(stockRepository)
final stockRepositoryProvider = AutoDisposeProvider<StockRepository>.internal(
  stockRepository,
  name: r'stockRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stockRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StockRepositoryRef = AutoDisposeProviderRef<StockRepository>;
String _$stockAssetsHash() => r'e8dfe35be3471dc0238a21e8dc7e2071638f2fbc';

/// See also [stockAssets].
@ProviderFor(stockAssets)
final stockAssetsProvider =
    AutoDisposeStreamProvider<List<StockAsset>>.internal(
      stockAssets,
      name: r'stockAssetsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$stockAssetsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StockAssetsRef = AutoDisposeStreamProviderRef<List<StockAsset>>;
String _$allStockAssetsHash() => r'a454d45d143e7cb5d696df4063c2338431ca6d2e';

/// See also [allStockAssets].
@ProviderFor(allStockAssets)
final allStockAssetsProvider =
    AutoDisposeStreamProvider<List<StockAsset>>.internal(
      allStockAssets,
      name: r'allStockAssetsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allStockAssetsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllStockAssetsRef = AutoDisposeStreamProviderRef<List<StockAsset>>;
String _$refreshStockPricesHash() =>
    r'2708568e6863d0d4913053606fdcd16300a8c8d2';

/// See also [refreshStockPrices].
@ProviderFor(refreshStockPrices)
final refreshStockPricesProvider =
    AutoDisposeFutureProvider<RefreshResult>.internal(
      refreshStockPrices,
      name: r'refreshStockPricesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$refreshStockPricesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshStockPricesRef = AutoDisposeFutureProviderRef<RefreshResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
