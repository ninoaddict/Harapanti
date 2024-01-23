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

String _$userInfoHash() => r'c4dc3801a947225d1e7a5e8d64991c55ad22bc32';

abstract class _$UserInfo extends BuildlessAutoDisposeAsyncNotifier<UserModel> {
  late final String userID;

  FutureOr<UserModel> build(
    String userID,
  );
}

/// See also [UserInfo].
@ProviderFor(UserInfo)
const userInfoProvider = UserInfoFamily();

/// See also [UserInfo].
class UserInfoFamily extends Family<AsyncValue<UserModel>> {
  /// See also [UserInfo].
  const UserInfoFamily();

  /// See also [UserInfo].
  UserInfoProvider call(
    String userID,
  ) {
    return UserInfoProvider(
      userID,
    );
  }

  @override
  UserInfoProvider getProviderOverride(
    covariant UserInfoProvider provider,
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
  String? get name => r'userInfoProvider';
}

/// See also [UserInfo].
class UserInfoProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserInfo, UserModel> {
  /// See also [UserInfo].
  UserInfoProvider(
    String userID,
  ) : this._internal(
          () => UserInfo()..userID = userID,
          from: userInfoProvider,
          name: r'userInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userInfoHash,
          dependencies: UserInfoFamily._dependencies,
          allTransitiveDependencies: UserInfoFamily._allTransitiveDependencies,
          userID: userID,
        );

  UserInfoProvider._internal(
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
  FutureOr<UserModel> runNotifierBuild(
    covariant UserInfo notifier,
  ) {
    return notifier.build(
      userID,
    );
  }

  @override
  Override overrideWith(UserInfo Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserInfoProvider._internal(
        () => create()..userID = userID,
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
  AutoDisposeAsyncNotifierProviderElement<UserInfo, UserModel> createElement() {
    return _UserInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserInfoProvider && other.userID == userID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserInfoRef on AutoDisposeAsyncNotifierProviderRef<UserModel> {
  /// The parameter `userID` of this provider.
  String get userID;
}

class _UserInfoProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserInfo, UserModel>
    with UserInfoRef {
  _UserInfoProviderElement(super.provider);

  @override
  String get userID => (origin as UserInfoProvider).userID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
