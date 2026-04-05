// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cryptoRepositoryHash() => r'21b644a531ada8ed044e67b9d3505a39398e93bf';

/// See also [cryptoRepository].
@ProviderFor(cryptoRepository)
final cryptoRepositoryProvider = AutoDisposeProvider<CryptoRepository>.internal(
  cryptoRepository,
  name: r'cryptoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cryptoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CryptoRepositoryRef = AutoDisposeProviderRef<CryptoRepository>;
String _$cryptoAssetsHash() => r'3b187de10d1dbe7f1b1f068e36783db76d10b86e';

/// See also [cryptoAssets].
@ProviderFor(cryptoAssets)
final cryptoAssetsProvider =
    AutoDisposeStreamProvider<List<CryptoAsset>>.internal(
      cryptoAssets,
      name: r'cryptoAssetsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cryptoAssetsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CryptoAssetsRef = AutoDisposeStreamProviderRef<List<CryptoAsset>>;
String _$refreshCryptoPricesHash() =>
    r'1aac31831946a1b84ca2c4ffc67dd3159c75e3cf';

/// See also [refreshCryptoPrices].
@ProviderFor(refreshCryptoPrices)
final refreshCryptoPricesProvider =
    AutoDisposeFutureProvider<RefreshResult>.internal(
      refreshCryptoPrices,
      name: r'refreshCryptoPricesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$refreshCryptoPricesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshCryptoPricesRef = AutoDisposeFutureProviderRef<RefreshResult>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
