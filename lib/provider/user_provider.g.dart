// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAdminHash() => r'62f59bb2578294b9355d123c8f9046c78be89eb7';

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

/// See also [isAdmin].
@ProviderFor(isAdmin)
const isAdminProvider = IsAdminFamily();

/// See also [isAdmin].
class IsAdminFamily extends Family<AsyncValue<bool>> {
  /// See also [isAdmin].
  const IsAdminFamily();

  /// See also [isAdmin].
  IsAdminProvider call(
    String userId,
  ) {
    return IsAdminProvider(
      userId,
    );
  }

  @override
  IsAdminProvider getProviderOverride(
    covariant IsAdminProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'isAdminProvider';
}

/// See also [isAdmin].
class IsAdminProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isAdmin].
  IsAdminProvider(
    String userId,
  ) : this._internal(
          (ref) => isAdmin(
            ref as IsAdminRef,
            userId,
          ),
          from: isAdminProvider,
          name: r'isAdminProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isAdminHash,
          dependencies: IsAdminFamily._dependencies,
          allTransitiveDependencies: IsAdminFamily._allTransitiveDependencies,
          userId: userId,
        );

  IsAdminProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsAdminRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsAdminProvider._internal(
        (ref) => create(ref as IsAdminRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsAdminProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsAdminProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsAdminRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _IsAdminProviderElement extends AutoDisposeFutureProviderElement<bool>
    with IsAdminRef {
  _IsAdminProviderElement(super.provider);

  @override
  String get userId => (origin as IsAdminProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
