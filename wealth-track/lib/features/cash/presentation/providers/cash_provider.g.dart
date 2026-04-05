// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cashRepositoryHash() => r'6c2af1dc12c862b083fd1c49ff35acb762a57068';

/// See also [cashRepository].
@ProviderFor(cashRepository)
final cashRepositoryProvider = AutoDisposeProvider<CashRepository>.internal(
  cashRepository,
  name: r'cashRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cashRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashRepositoryRef = AutoDisposeProviderRef<CashRepository>;
String _$cashAssetsHash() => r'dc419bc4975b63ead0b4af0328ad5d795b575074';

/// See also [cashAssets].
@ProviderFor(cashAssets)
final cashAssetsProvider = AutoDisposeStreamProvider<List<CashAsset>>.internal(
  cashAssets,
  name: r'cashAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cashAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashAssetsRef = AutoDisposeStreamProviderRef<List<CashAsset>>;
String _$cashTotalHash() => r'83029e2e404aba970a872a14ec2eea3a992f33b5';

/// See also [cashTotal].
@ProviderFor(cashTotal)
final cashTotalProvider = AutoDisposeProvider<double>.internal(
  cashTotal,
  name: r'cashTotalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cashTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashTotalRef = AutoDisposeProviderRef<double>;
String _$cashByBankHash() => r'419fbba0332d8aa9a5b7b029f60255e4c29af531';

/// See also [cashByBank].
@ProviderFor(cashByBank)
final cashByBankProvider = AutoDisposeProvider<Map<String, double>>.internal(
  cashByBank,
  name: r'cashByBankProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cashByBankHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashByBankRef = AutoDisposeProviderRef<Map<String, double>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
