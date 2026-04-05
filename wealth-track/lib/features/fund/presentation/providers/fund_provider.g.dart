// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fundRepositoryHash() => r'5d9f42a8a51007c9221d2266f3892b5aae8fe5a0';

/// See also [fundRepository].
@ProviderFor(fundRepository)
final fundRepositoryProvider = AutoDisposeProvider<FundRepository>.internal(
  fundRepository,
  name: r'fundRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fundRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FundRepositoryRef = AutoDisposeProviderRef<FundRepository>;
String _$fundAssetsHash() => r'73cd199bf22182a38f8e3a9ab134d7b664f0ac1d';

/// See also [fundAssets].
@ProviderFor(fundAssets)
final fundAssetsProvider = AutoDisposeStreamProvider<List<FundAsset>>.internal(
  fundAssets,
  name: r'fundAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fundAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FundAssetsRef = AutoDisposeStreamProviderRef<List<FundAsset>>;
String _$fundTotalHash() => r'47cf5005046838862cf4499e3c50fa0a51a4a03a';

/// See also [fundTotal].
@ProviderFor(fundTotal)
final fundTotalProvider = AutoDisposeProvider<double>.internal(
  fundTotal,
  name: r'fundTotalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fundTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FundTotalRef = AutoDisposeProviderRef<double>;
String _$refreshFundPricesHash() => r'f5f2a3e8598e43d2fd882ae300c813e35099d5c1';

/// See also [refreshFundPrices].
@ProviderFor(refreshFundPrices)
final refreshFundPricesProvider =
    AutoDisposeFutureProvider<RefreshResult>.internal(
      refreshFundPrices,
      name: r'refreshFundPricesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$refreshFundPricesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshFundPricesRef = AutoDisposeFutureProviderRef<RefreshResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
