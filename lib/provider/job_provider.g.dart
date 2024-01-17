// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pantiDataHash() => r'a899ada88762947190916cb5b9415a4dd4845b73';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
