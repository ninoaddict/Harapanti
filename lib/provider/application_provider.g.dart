// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$applicationDataHash() => r'e8de2bebcf5beed875203a9e615289b08b6e35fa';

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

/// See also [applicationData].
@ProviderFor(applicationData)
const applicationDataProvider = ApplicationDataFamily();

/// See also [applicationData].
class ApplicationDataFamily extends Family<AsyncValue<List<Application>>> {
  /// See also [applicationData].
  const ApplicationDataFamily();

  /// See also [applicationData].
  ApplicationDataProvider call(
    String vacancyID,
  ) {
    return ApplicationDataProvider(
      vacancyID,
    );
  }

  @override
  ApplicationDataProvider getProviderOverride(
    covariant ApplicationDataProvider provider,
  ) {
    return call(
      provider.vacancyID,
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
  String? get name => r'applicationDataProvider';
}

/// See also [applicationData].
class ApplicationDataProvider
    extends AutoDisposeFutureProvider<List<Application>> {
  /// See also [applicationData].
  ApplicationDataProvider(
    String vacancyID,
  ) : this._internal(
          (ref) => applicationData(
            ref as ApplicationDataRef,
            vacancyID,
          ),
          from: applicationDataProvider,
          name: r'applicationDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$applicationDataHash,
          dependencies: ApplicationDataFamily._dependencies,
          allTransitiveDependencies:
              ApplicationDataFamily._allTransitiveDependencies,
          vacancyID: vacancyID,
        );

  ApplicationDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vacancyID,
  }) : super.internal();

  final String vacancyID;

  @override
  Override overrideWith(
    FutureOr<List<Application>> Function(ApplicationDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApplicationDataProvider._internal(
        (ref) => create(ref as ApplicationDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vacancyID: vacancyID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Application>> createElement() {
    return _ApplicationDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplicationDataProvider && other.vacancyID == vacancyID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vacancyID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ApplicationDataRef on AutoDisposeFutureProviderRef<List<Application>> {
  /// The parameter `vacancyID` of this provider.
  String get vacancyID;
}

class _ApplicationDataProviderElement
    extends AutoDisposeFutureProviderElement<List<Application>>
    with ApplicationDataRef {
  _ApplicationDataProviderElement(super.provider);

  @override
  String get vacancyID => (origin as ApplicationDataProvider).vacancyID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
