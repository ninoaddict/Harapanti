// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listVacancyByFilterHash() =>
    r'ee559f884b8a84c2d3eb7c02e600da5cdaeec108';

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

/// See also [listVacancyByFilter].
@ProviderFor(listVacancyByFilter)
const listVacancyByFilterProvider = ListVacancyByFilterFamily();

/// See also [listVacancyByFilter].
class ListVacancyByFilterFamily extends Family<AsyncValue<List<Vacancy>>> {
  /// See also [listVacancyByFilter].
  const ListVacancyByFilterFamily();

  /// See also [listVacancyByFilter].
  ListVacancyByFilterProvider call(
    List<String> listJobType,
    List<String> listRangeType,
  ) {
    return ListVacancyByFilterProvider(
      listJobType,
      listRangeType,
    );
  }

  @override
  ListVacancyByFilterProvider getProviderOverride(
    covariant ListVacancyByFilterProvider provider,
  ) {
    return call(
      provider.listJobType,
      provider.listRangeType,
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
  String? get name => r'listVacancyByFilterProvider';
}

/// See also [listVacancyByFilter].
class ListVacancyByFilterProvider
    extends AutoDisposeFutureProvider<List<Vacancy>> {
  /// See also [listVacancyByFilter].
  ListVacancyByFilterProvider(
    List<String> listJobType,
    List<String> listRangeType,
  ) : this._internal(
          (ref) => listVacancyByFilter(
            ref as ListVacancyByFilterRef,
            listJobType,
            listRangeType,
          ),
          from: listVacancyByFilterProvider,
          name: r'listVacancyByFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listVacancyByFilterHash,
          dependencies: ListVacancyByFilterFamily._dependencies,
          allTransitiveDependencies:
              ListVacancyByFilterFamily._allTransitiveDependencies,
          listJobType: listJobType,
          listRangeType: listRangeType,
        );

  ListVacancyByFilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listJobType,
    required this.listRangeType,
  }) : super.internal();

  final List<String> listJobType;
  final List<String> listRangeType;

  @override
  Override overrideWith(
    FutureOr<List<Vacancy>> Function(ListVacancyByFilterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListVacancyByFilterProvider._internal(
        (ref) => create(ref as ListVacancyByFilterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listJobType: listJobType,
        listRangeType: listRangeType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Vacancy>> createElement() {
    return _ListVacancyByFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListVacancyByFilterProvider &&
        other.listJobType == listJobType &&
        other.listRangeType == listRangeType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listJobType.hashCode);
    hash = _SystemHash.combine(hash, listRangeType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListVacancyByFilterRef on AutoDisposeFutureProviderRef<List<Vacancy>> {
  /// The parameter `listJobType` of this provider.
  List<String> get listJobType;

  /// The parameter `listRangeType` of this provider.
  List<String> get listRangeType;
}

class _ListVacancyByFilterProviderElement
    extends AutoDisposeFutureProviderElement<List<Vacancy>>
    with ListVacancyByFilterRef {
  _ListVacancyByFilterProviderElement(super.provider);

  @override
  List<String> get listJobType =>
      (origin as ListVacancyByFilterProvider).listJobType;
  @override
  List<String> get listRangeType =>
      (origin as ListVacancyByFilterProvider).listRangeType;
}

String _$listVacancyByPantiHash() =>
    r'e64f7caef37ba0cf7adc85958619be9dac999a3e';

/// See also [listVacancyByPanti].
@ProviderFor(listVacancyByPanti)
const listVacancyByPantiProvider = ListVacancyByPantiFamily();

/// See also [listVacancyByPanti].
class ListVacancyByPantiFamily extends Family<AsyncValue<List<Vacancy>>> {
  /// See also [listVacancyByPanti].
  const ListVacancyByPantiFamily();

  /// See also [listVacancyByPanti].
  ListVacancyByPantiProvider call(
    String status,
    String pantiID,
  ) {
    return ListVacancyByPantiProvider(
      status,
      pantiID,
    );
  }

  @override
  ListVacancyByPantiProvider getProviderOverride(
    covariant ListVacancyByPantiProvider provider,
  ) {
    return call(
      provider.status,
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
  String? get name => r'listVacancyByPantiProvider';
}

/// See also [listVacancyByPanti].
class ListVacancyByPantiProvider
    extends AutoDisposeFutureProvider<List<Vacancy>> {
  /// See also [listVacancyByPanti].
  ListVacancyByPantiProvider(
    String status,
    String pantiID,
  ) : this._internal(
          (ref) => listVacancyByPanti(
            ref as ListVacancyByPantiRef,
            status,
            pantiID,
          ),
          from: listVacancyByPantiProvider,
          name: r'listVacancyByPantiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listVacancyByPantiHash,
          dependencies: ListVacancyByPantiFamily._dependencies,
          allTransitiveDependencies:
              ListVacancyByPantiFamily._allTransitiveDependencies,
          status: status,
          pantiID: pantiID,
        );

  ListVacancyByPantiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
    required this.pantiID,
  }) : super.internal();

  final String status;
  final String pantiID;

  @override
  Override overrideWith(
    FutureOr<List<Vacancy>> Function(ListVacancyByPantiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListVacancyByPantiProvider._internal(
        (ref) => create(ref as ListVacancyByPantiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
        pantiID: pantiID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Vacancy>> createElement() {
    return _ListVacancyByPantiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListVacancyByPantiProvider &&
        other.status == status &&
        other.pantiID == pantiID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);
    hash = _SystemHash.combine(hash, pantiID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListVacancyByPantiRef on AutoDisposeFutureProviderRef<List<Vacancy>> {
  /// The parameter `status` of this provider.
  String get status;

  /// The parameter `pantiID` of this provider.
  String get pantiID;
}

class _ListVacancyByPantiProviderElement
    extends AutoDisposeFutureProviderElement<List<Vacancy>>
    with ListVacancyByPantiRef {
  _ListVacancyByPantiProviderElement(super.provider);

  @override
  String get status => (origin as ListVacancyByPantiProvider).status;
  @override
  String get pantiID => (origin as ListVacancyByPantiProvider).pantiID;
}

String _$vacancyListHash() => r'895ebf67a5e9529c7e27ab0d361f18abd464a347';

/// See also [VacancyList].
@ProviderFor(VacancyList)
final vacancyListProvider =
    AutoDisposeAsyncNotifierProvider<VacancyList, List<Vacancy>>.internal(
  VacancyList.new,
  name: r'vacancyListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vacancyListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VacancyList = AutoDisposeAsyncNotifier<List<Vacancy>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
