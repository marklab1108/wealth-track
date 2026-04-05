// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yahooFinanceServiceHash() =>
    r'6bf49b767b36e69e92dfc245b13f9a41e82e953a';

/// See also [yahooFinanceService].
@ProviderFor(yahooFinanceService)
final yahooFinanceServiceProvider = Provider<YahooFinanceService>.internal(
  yahooFinanceService,
  name: r'yahooFinanceServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yahooFinanceServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef YahooFinanceServiceRef = ProviderRef<YahooFinanceService>;
String _$exchangeRateServiceHash() =>
    r'd8d7dfd19efdea06428a41b49e75b4c2df7238a3';

/// See also [exchangeRateService].
@ProviderFor(exchangeRateService)
final exchangeRateServiceProvider = Provider<ExchangeRateService>.internal(
  exchangeRateService,
  name: r'exchangeRateServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeRateServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExchangeRateServiceRef = ProviderRef<ExchangeRateService>;
String _$twseMisServiceHash() => r'12aee4cd03e41653ad6013722287f75e3797042f';

/// See also [twseMisService].
@ProviderFor(twseMisService)
final twseMisServiceProvider = Provider<TwseMisService>.internal(
  twseMisService,
  name: r'twseMisServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$twseMisServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TwseMisServiceRef = ProviderRef<TwseMisService>;
String _$twseServiceHash() => r'e39a01ffdd414cf196567ddd9fa99fa6e593aaae';

/// See also [twseService].
@ProviderFor(twseService)
final twseServiceProvider = Provider<TwseService>.internal(
  twseService,
  name: r'twseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$twseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TwseServiceRef = ProviderRef<TwseService>;
String _$exchangeRateRepositoryHash() =>
    r'43310339fa01bb4351b877da8c0d7f29b3868be3';

/// See also [exchangeRateRepository].
@ProviderFor(exchangeRateRepository)
final exchangeRateRepositoryProvider =
    Provider<ExchangeRateRepository>.internal(
      exchangeRateRepository,
      name: r'exchangeRateRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$exchangeRateRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExchangeRateRepositoryRef = ProviderRef<ExchangeRateRepository>;
String _$usdToTwdHash() => r'a0abfb37cdbad220a0bbf13f2f31e579a8a13579';

/// Fetches USD→TWD rate. Uses DB cache (24h), falls back to API.
///
/// Copied from [usdToTwd].
@ProviderFor(usdToTwd)
final usdToTwdProvider = AutoDisposeFutureProvider<double>.internal(
  usdToTwd,
  name: r'usdToTwdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usdToTwdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UsdToTwdRef = AutoDisposeFutureProviderRef<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
