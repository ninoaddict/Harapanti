// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panti_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pantiDataHash() => r'5b15510607fb020a8b4d18223e3454a86dd627e3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [pantiData].
@ProviderFor(pantiData)
const pantiDataProvider = PantiDataFamily();

/// See also [pantiData].
class PantiDataFamily extends Family<AsyncValue<List<Panti>>> {
  /// See also [pantiData].
  const PantiDataFamily();

  /// See also [pantiData].
  PantiDataProvider call(
    String cityQuery,
  ) {
    return PantiDataProvider(
      cityQuery,
    );
  }

  @override
  PantiDataProvider getProviderOverride(
    covariant PantiDataProvider provider,
  ) {
    return call(
      provider.cityQuery,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pantiDataProvider';
}

/// See also [pantiData].
class PantiDataProvider extends AutoDisposeFutureProvider<List<Panti>> {
  /// See also [pantiData].
  PantiDataProvider(
    String cityQuery,
  ) : this._internal(
          (ref) => pantiData(
            ref as PantiDataRef,
            cityQuery,
          ),
          from: pantiDataProvider,
          name: r'pantiDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pantiDataHash,
          dependencies: PantiDataFamily._dependencies,
          allTransitiveDependencies: PantiDataFamily._allTransitiveDependencies,
          cityQuery: cityQuery,
        );

  PantiDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityQuery,
  }) : super.internal();

  final String cityQuery;

  @override
  Override overrideWith(
    FutureOr<List<Panti>> Function(PantiDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PantiDataProvider._internal(
        (ref) => create(ref as PantiDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityQuery: cityQuery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Panti>> createElement() {
    return _PantiDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PantiDataProvider && other.cityQuery == cityQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PantiDataRef on AutoDisposeFutureProviderRef<List<Panti>> {
  /// The parameter `cityQuery` of this provider.
  String get cityQuery;
}

class _PantiDataProviderElement
    extends AutoDisposeFutureProviderElement<List<Panti>> with PantiDataRef {
  _PantiDataProviderElement(super.provider);

  @override
  String get cityQuery => (origin as PantiDataProvider).cityQuery;
}

String _$singlePantiHash() => r'00ccd8db1dc03936d3dbe22fa0a9b6040a426db7';

/// See also [singlePanti].
@ProviderFor(singlePanti)
const singlePantiProvider = SinglePantiFamily();

/// See also [singlePanti].
class SinglePantiFamily extends Family<AsyncValue<Panti>> {
  /// See also [singlePanti].
  const SinglePantiFamily();

  /// See also [singlePanti].
  SinglePantiProvider call(
    String pantiID,
  ) {
    return SinglePantiProvider(
      pantiID,
    );
  }

  @override
  SinglePantiProvider getProviderOverride(
    covariant SinglePantiProvider provider,
  ) {
    return call(
      provider.pantiID,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singlePantiProvider';
}

/// See also [singlePanti].
class SinglePantiProvider extends AutoDisposeFutureProvider<Panti> {
  /// See also [singlePanti].
  SinglePantiProvider(
    String pantiID,
  ) : this._internal(
          (ref) => singlePanti(
            ref as SinglePantiRef,
            pantiID,
          ),
          from: singlePantiProvider,
          name: r'singlePantiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singlePantiHash,
          dependencies: SinglePantiFamily._dependencies,
          allTransitiveDependencies:
              SinglePantiFamily._allTransitiveDependencies,
          pantiID: pantiID,
        );

  SinglePantiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pantiID,
  }) : super.internal();

  final String pantiID;

  @override
  Override overrideWith(
    FutureOr<Panti> Function(SinglePantiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SinglePantiProvider._internal(
        (ref) => create(ref as SinglePantiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pantiID: pantiID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Panti> createElement() {
    return _SinglePantiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SinglePantiProvider && other.pantiID == pantiID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pantiID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SinglePantiRef on AutoDisposeFutureProviderRef<Panti> {
  /// The parameter `pantiID` of this provider.
  String get pantiID;
}

class _SinglePantiProviderElement
    extends AutoDisposeFutureProviderElement<Panti> with SinglePantiRef {
  _SinglePantiProviderElement(super.provider);

  @override
  String get pantiID => (origin as SinglePantiProvider).pantiID;
}

String _$singlePantiByUserHash() => r'b62c814f77151cf25b36269a2e7489e8d6e75b87';

/// See also [singlePantiByUser].
@ProviderFor(singlePantiByUser)
const singlePantiByUserProvider = SinglePantiByUserFamily();

/// See also [singlePantiByUser].
class SinglePantiByUserFamily extends Family<AsyncValue<Panti>> {
  /// See also [singlePantiByUser].
  const SinglePantiByUserFamily();

  /// See also [singlePantiByUser].
  SinglePantiByUserProvider call(
    String userID,
  ) {
    return SinglePantiByUserProvider(
      userID,
    );
  }

  @override
  SinglePantiByUserProvider getProviderOverride(
    covariant SinglePantiByUserProvider provider,
  ) {
    return call(
      provider.userID,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singlePantiByUserProvider';
}

/// See also [singlePantiByUser].
class SinglePantiByUserProvider extends AutoDisposeFutureProvider<Panti> {
  /// See also [singlePantiByUser].
  SinglePantiByUserProvider(
    String userID,
  ) : this._internal(
          (ref) => singlePantiByUser(
            ref as SinglePantiByUserRef,
            userID,
          ),
          from: singlePantiByUserProvider,
          name: r'singlePantiByUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singlePantiByUserHash,
          dependencies: SinglePantiByUserFamily._dependencies,
          allTransitiveDependencies:
              SinglePantiByUserFamily._allTransitiveDependencies,
          userID: userID,
        );

  SinglePantiByUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userID,
  }) : super.internal();

  final String userID;

  @override
  Override overrideWith(
    FutureOr<Panti> Function(SinglePantiByUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SinglePantiByUserProvider._internal(
        (ref) => create(ref as SinglePantiByUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userID: userID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Panti> createElement() {
    return _SinglePantiByUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SinglePantiByUserProvider && other.userID == userID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SinglePantiByUserRef on AutoDisposeFutureProviderRef<Panti> {
  /// The parameter `userID` of this provider.
  String get userID;
}

class _SinglePantiByUserProviderElement
    extends AutoDisposeFutureProviderElement<Panti> with SinglePantiByUserRef {
  _SinglePantiByUserProviderElement(super.provider);

  @override
  String get userID => (origin as SinglePantiByUserProvider).userID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
