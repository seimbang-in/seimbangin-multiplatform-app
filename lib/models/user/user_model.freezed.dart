// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserResponse {
  String get status;
  UserData get data;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserResponseCopyWith<UserResponse> get copyWith =>
      _$UserResponseCopyWithImpl<UserResponse>(
          this as UserResponse, _$identity);

  /// Serializes this UserResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data);

  @override
  String toString() {
    return 'UserResponse(status: $status, data: $data)';
  }
}

/// @nodoc
abstract mixin class $UserResponseCopyWith<$Res> {
  factory $UserResponseCopyWith(
          UserResponse value, $Res Function(UserResponse) _then) =
      _$UserResponseCopyWithImpl;
  @useResult
  $Res call({String status, UserData data});

  $UserDataCopyWith<$Res> get data;
}

/// @nodoc
class _$UserResponseCopyWithImpl<$Res> implements $UserResponseCopyWith<$Res> {
  _$UserResponseCopyWithImpl(this._self, this._then);

  final UserResponse _self;
  final $Res Function(UserResponse) _then;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as UserData,
    ));
  }

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res> get data {
    return $UserDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UserResponse].
extension UserResponsePatterns on UserResponse {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String status, UserData data)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserResponse() when $default != null:
        return $default(_that.status, _that.data);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String status, UserData data) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserResponse():
        return $default(_that.status, _that.data);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String status, UserData data)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserResponse() when $default != null:
        return $default(_that.status, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserResponse implements UserResponse {
  _UserResponse({this.status = '', required this.data});
  factory _UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  final UserData data;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserResponseCopyWith<_UserResponse> get copyWith =>
      __$UserResponseCopyWithImpl<_UserResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data);

  @override
  String toString() {
    return 'UserResponse(status: $status, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$UserResponseCopyWith<$Res>
    implements $UserResponseCopyWith<$Res> {
  factory _$UserResponseCopyWith(
          _UserResponse value, $Res Function(_UserResponse) _then) =
      __$UserResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String status, UserData data});

  @override
  $UserDataCopyWith<$Res> get data;
}

/// @nodoc
class __$UserResponseCopyWithImpl<$Res>
    implements _$UserResponseCopyWith<$Res> {
  __$UserResponseCopyWithImpl(this._self, this._then);

  final _UserResponse _self;
  final $Res Function(_UserResponse) _then;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_UserResponse(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as UserData,
    ));
  }

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res> get data {
    return $UserDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}

/// @nodoc
mixin _$UserData {
  int get id;
  @JsonKey(name: 'full_name')
  String get fullName;
  int? get age;
  String get balance;
  String get username;
  String get email;
  String? get profilePicture;
  String? get university;
  String? get gender;
  @JsonKey(name: 'birth_date')
  String? get birthDate;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @JsonKey(name: 'phone_number')
  String?
      get phoneNumber; // --- LANGKAH 2: GUNAKAN FUNGSI HELPER PADA ANOTASI @JsonKey ---
  @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
  FinanceProfile? get financeProfile;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<UserData> get copyWith =>
      _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);

  /// Serializes this UserData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.university, university) ||
                other.university == university) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.financeProfile, financeProfile) ||
                other.financeProfile == financeProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      age,
      balance,
      username,
      email,
      profilePicture,
      university,
      gender,
      birthDate,
      createdAt,
      updatedAt,
      phoneNumber,
      financeProfile);

  @override
  String toString() {
    return 'UserData(id: $id, fullName: $fullName, age: $age, balance: $balance, username: $username, email: $email, profilePicture: $profilePicture, university: $university, gender: $gender, birthDate: $birthDate, createdAt: $createdAt, updatedAt: $updatedAt, phoneNumber: $phoneNumber, financeProfile: $financeProfile)';
  }
}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) =
      _$UserDataCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'full_name') String fullName,
      int? age,
      String balance,
      String username,
      String email,
      String? profilePicture,
      String? university,
      String? gender,
      @JsonKey(name: 'birth_date') String? birthDate,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
      FinanceProfile? financeProfile});

  $FinanceProfileCopyWith<$Res>? get financeProfile;
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res> implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? age = freezed,
    Object? balance = null,
    Object? username = null,
    Object? email = null,
    Object? profilePicture = freezed,
    Object? university = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? phoneNumber = freezed,
    Object? financeProfile = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: freezed == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      university: freezed == university
          ? _self.university
          : university // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      financeProfile: freezed == financeProfile
          ? _self.financeProfile
          : financeProfile // ignore: cast_nullable_to_non_nullable
              as FinanceProfile?,
    ));
  }

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FinanceProfileCopyWith<$Res>? get financeProfile {
    if (_self.financeProfile == null) {
      return null;
    }

    return $FinanceProfileCopyWith<$Res>(_self.financeProfile!, (value) {
      return _then(_self.copyWith(financeProfile: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UserData].
extension UserDataPatterns on UserData {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserData() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserData() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            @JsonKey(name: 'full_name') String fullName,
            int? age,
            String balance,
            String username,
            String email,
            String? profilePicture,
            String? university,
            String? gender,
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            @JsonKey(name: 'phone_number') String? phoneNumber,
            @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
            FinanceProfile? financeProfile)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserData() when $default != null:
        return $default(
            _that.id,
            _that.fullName,
            _that.age,
            _that.balance,
            _that.username,
            _that.email,
            _that.profilePicture,
            _that.university,
            _that.gender,
            _that.birthDate,
            _that.createdAt,
            _that.updatedAt,
            _that.phoneNumber,
            _that.financeProfile);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            @JsonKey(name: 'full_name') String fullName,
            int? age,
            String balance,
            String username,
            String email,
            String? profilePicture,
            String? university,
            String? gender,
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            @JsonKey(name: 'phone_number') String? phoneNumber,
            @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
            FinanceProfile? financeProfile)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserData():
        return $default(
            _that.id,
            _that.fullName,
            _that.age,
            _that.balance,
            _that.username,
            _that.email,
            _that.profilePicture,
            _that.university,
            _that.gender,
            _that.birthDate,
            _that.createdAt,
            _that.updatedAt,
            _that.phoneNumber,
            _that.financeProfile);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            @JsonKey(name: 'full_name') String fullName,
            int? age,
            String balance,
            String username,
            String email,
            String? profilePicture,
            String? university,
            String? gender,
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            @JsonKey(name: 'phone_number') String? phoneNumber,
            @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
            FinanceProfile? financeProfile)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserData() when $default != null:
        return $default(
            _that.id,
            _that.fullName,
            _that.age,
            _that.balance,
            _that.username,
            _that.email,
            _that.profilePicture,
            _that.university,
            _that.gender,
            _that.birthDate,
            _that.createdAt,
            _that.updatedAt,
            _that.phoneNumber,
            _that.financeProfile);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserData implements UserData {
  _UserData(
      {this.id = 0,
      @JsonKey(name: 'full_name') this.fullName = '',
      this.age,
      this.balance = '0',
      this.username = '',
      this.email = '',
      this.profilePicture,
      this.university,
      this.gender,
      @JsonKey(name: 'birth_date') this.birthDate,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'phone_number') this.phoneNumber,
      @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
      this.financeProfile});
  factory _UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final int? age;
  @override
  @JsonKey()
  final String balance;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String email;
  @override
  final String? profilePicture;
  @override
  final String? university;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
// --- LANGKAH 2: GUNAKAN FUNGSI HELPER PADA ANOTASI @JsonKey ---
  @override
  @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
  final FinanceProfile? financeProfile;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserDataCopyWith<_UserData> get copyWith =>
      __$UserDataCopyWithImpl<_UserData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.university, university) ||
                other.university == university) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.financeProfile, financeProfile) ||
                other.financeProfile == financeProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      age,
      balance,
      username,
      email,
      profilePicture,
      university,
      gender,
      birthDate,
      createdAt,
      updatedAt,
      phoneNumber,
      financeProfile);

  @override
  String toString() {
    return 'UserData(id: $id, fullName: $fullName, age: $age, balance: $balance, username: $username, email: $email, profilePicture: $profilePicture, university: $university, gender: $gender, birthDate: $birthDate, createdAt: $createdAt, updatedAt: $updatedAt, phoneNumber: $phoneNumber, financeProfile: $financeProfile)';
  }
}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) =
      __$UserDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'full_name') String fullName,
      int? age,
      String balance,
      String username,
      String email,
      String? profilePicture,
      String? university,
      String? gender,
      @JsonKey(name: 'birth_date') String? birthDate,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      @JsonKey(name: 'finance_profile', fromJson: _financeProfileFromJson)
      FinanceProfile? financeProfile});

  @override
  $FinanceProfileCopyWith<$Res>? get financeProfile;
}

/// @nodoc
class __$UserDataCopyWithImpl<$Res> implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? age = freezed,
    Object? balance = null,
    Object? username = null,
    Object? email = null,
    Object? profilePicture = freezed,
    Object? university = freezed,
    Object? gender = freezed,
    Object? birthDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? phoneNumber = freezed,
    Object? financeProfile = freezed,
  }) {
    return _then(_UserData(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: freezed == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      university: freezed == university
          ? _self.university
          : university // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      financeProfile: freezed == financeProfile
          ? _self.financeProfile
          : financeProfile // ignore: cast_nullable_to_non_nullable
              as FinanceProfile?,
    ));
  }

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FinanceProfileCopyWith<$Res>? get financeProfile {
    if (_self.financeProfile == null) {
      return null;
    }

    return $FinanceProfileCopyWith<$Res>(_self.financeProfile!, (value) {
      return _then(_self.copyWith(financeProfile: value));
    });
  }
}

/// @nodoc
mixin _$FinanceProfile {
  @JsonKey(name: 'monthly_income')
  double? get monthlyIncome;
  @JsonKey(name: 'current_savings')
  String get currentSavings;
  String get debt;
  @JsonKey(name: 'financial_goals')
  String get financialGoals;
  @JsonKey(name: 'total_income')
  String get totalIncome;
  @JsonKey(name: 'total_outcome')
  String get totalOutcome;
  @JsonKey(name: 'risk_management')
  String get riskManagement;
  @JsonKey(name: 'this_month_income')
  String
      get thisMonthIncome; // Tambahkan field yang mungkin terlewat dari respons
  @JsonKey(name: 'this_month_outcome')
  String get thisMonthOutcome;

  /// Create a copy of FinanceProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FinanceProfileCopyWith<FinanceProfile> get copyWith =>
      _$FinanceProfileCopyWithImpl<FinanceProfile>(
          this as FinanceProfile, _$identity);

  /// Serializes this FinanceProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FinanceProfile &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome) &&
            (identical(other.currentSavings, currentSavings) ||
                other.currentSavings == currentSavings) &&
            (identical(other.debt, debt) || other.debt == debt) &&
            (identical(other.financialGoals, financialGoals) ||
                other.financialGoals == financialGoals) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalOutcome, totalOutcome) ||
                other.totalOutcome == totalOutcome) &&
            (identical(other.riskManagement, riskManagement) ||
                other.riskManagement == riskManagement) &&
            (identical(other.thisMonthIncome, thisMonthIncome) ||
                other.thisMonthIncome == thisMonthIncome) &&
            (identical(other.thisMonthOutcome, thisMonthOutcome) ||
                other.thisMonthOutcome == thisMonthOutcome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      monthlyIncome,
      currentSavings,
      debt,
      financialGoals,
      totalIncome,
      totalOutcome,
      riskManagement,
      thisMonthIncome,
      thisMonthOutcome);

  @override
  String toString() {
    return 'FinanceProfile(monthlyIncome: $monthlyIncome, currentSavings: $currentSavings, debt: $debt, financialGoals: $financialGoals, totalIncome: $totalIncome, totalOutcome: $totalOutcome, riskManagement: $riskManagement, thisMonthIncome: $thisMonthIncome, thisMonthOutcome: $thisMonthOutcome)';
  }
}

/// @nodoc
abstract mixin class $FinanceProfileCopyWith<$Res> {
  factory $FinanceProfileCopyWith(
          FinanceProfile value, $Res Function(FinanceProfile) _then) =
      _$FinanceProfileCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'monthly_income') double? monthlyIncome,
      @JsonKey(name: 'current_savings') String currentSavings,
      String debt,
      @JsonKey(name: 'financial_goals') String financialGoals,
      @JsonKey(name: 'total_income') String totalIncome,
      @JsonKey(name: 'total_outcome') String totalOutcome,
      @JsonKey(name: 'risk_management') String riskManagement,
      @JsonKey(name: 'this_month_income') String thisMonthIncome,
      @JsonKey(name: 'this_month_outcome') String thisMonthOutcome});
}

/// @nodoc
class _$FinanceProfileCopyWithImpl<$Res>
    implements $FinanceProfileCopyWith<$Res> {
  _$FinanceProfileCopyWithImpl(this._self, this._then);

  final FinanceProfile _self;
  final $Res Function(FinanceProfile) _then;

  /// Create a copy of FinanceProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthlyIncome = freezed,
    Object? currentSavings = null,
    Object? debt = null,
    Object? financialGoals = null,
    Object? totalIncome = null,
    Object? totalOutcome = null,
    Object? riskManagement = null,
    Object? thisMonthIncome = null,
    Object? thisMonthOutcome = null,
  }) {
    return _then(_self.copyWith(
      monthlyIncome: freezed == monthlyIncome
          ? _self.monthlyIncome
          : monthlyIncome // ignore: cast_nullable_to_non_nullable
              as double?,
      currentSavings: null == currentSavings
          ? _self.currentSavings
          : currentSavings // ignore: cast_nullable_to_non_nullable
              as String,
      debt: null == debt
          ? _self.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as String,
      financialGoals: null == financialGoals
          ? _self.financialGoals
          : financialGoals // ignore: cast_nullable_to_non_nullable
              as String,
      totalIncome: null == totalIncome
          ? _self.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as String,
      totalOutcome: null == totalOutcome
          ? _self.totalOutcome
          : totalOutcome // ignore: cast_nullable_to_non_nullable
              as String,
      riskManagement: null == riskManagement
          ? _self.riskManagement
          : riskManagement // ignore: cast_nullable_to_non_nullable
              as String,
      thisMonthIncome: null == thisMonthIncome
          ? _self.thisMonthIncome
          : thisMonthIncome // ignore: cast_nullable_to_non_nullable
              as String,
      thisMonthOutcome: null == thisMonthOutcome
          ? _self.thisMonthOutcome
          : thisMonthOutcome // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [FinanceProfile].
extension FinanceProfilePatterns on FinanceProfile {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FinanceProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FinanceProfile() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FinanceProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FinanceProfile():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FinanceProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FinanceProfile() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'monthly_income') double? monthlyIncome,
            @JsonKey(name: 'current_savings') String currentSavings,
            String debt,
            @JsonKey(name: 'financial_goals') String financialGoals,
            @JsonKey(name: 'total_income') String totalIncome,
            @JsonKey(name: 'total_outcome') String totalOutcome,
            @JsonKey(name: 'risk_management') String riskManagement,
            @JsonKey(name: 'this_month_income') String thisMonthIncome,
            @JsonKey(name: 'this_month_outcome') String thisMonthOutcome)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FinanceProfile() when $default != null:
        return $default(
            _that.monthlyIncome,
            _that.currentSavings,
            _that.debt,
            _that.financialGoals,
            _that.totalIncome,
            _that.totalOutcome,
            _that.riskManagement,
            _that.thisMonthIncome,
            _that.thisMonthOutcome);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'monthly_income') double? monthlyIncome,
            @JsonKey(name: 'current_savings') String currentSavings,
            String debt,
            @JsonKey(name: 'financial_goals') String financialGoals,
            @JsonKey(name: 'total_income') String totalIncome,
            @JsonKey(name: 'total_outcome') String totalOutcome,
            @JsonKey(name: 'risk_management') String riskManagement,
            @JsonKey(name: 'this_month_income') String thisMonthIncome,
            @JsonKey(name: 'this_month_outcome') String thisMonthOutcome)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FinanceProfile():
        return $default(
            _that.monthlyIncome,
            _that.currentSavings,
            _that.debt,
            _that.financialGoals,
            _that.totalIncome,
            _that.totalOutcome,
            _that.riskManagement,
            _that.thisMonthIncome,
            _that.thisMonthOutcome);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'monthly_income') double? monthlyIncome,
            @JsonKey(name: 'current_savings') String currentSavings,
            String debt,
            @JsonKey(name: 'financial_goals') String financialGoals,
            @JsonKey(name: 'total_income') String totalIncome,
            @JsonKey(name: 'total_outcome') String totalOutcome,
            @JsonKey(name: 'risk_management') String riskManagement,
            @JsonKey(name: 'this_month_income') String thisMonthIncome,
            @JsonKey(name: 'this_month_outcome') String thisMonthOutcome)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FinanceProfile() when $default != null:
        return $default(
            _that.monthlyIncome,
            _that.currentSavings,
            _that.debt,
            _that.financialGoals,
            _that.totalIncome,
            _that.totalOutcome,
            _that.riskManagement,
            _that.thisMonthIncome,
            _that.thisMonthOutcome);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FinanceProfile implements FinanceProfile {
  _FinanceProfile(
      {@JsonKey(name: 'monthly_income') this.monthlyIncome,
      @JsonKey(name: 'current_savings') this.currentSavings = '0.00',
      this.debt = '0.00',
      @JsonKey(name: 'financial_goals') this.financialGoals = '',
      @JsonKey(name: 'total_income') this.totalIncome = '0',
      @JsonKey(name: 'total_outcome') this.totalOutcome = '0',
      @JsonKey(name: 'risk_management') this.riskManagement = '',
      @JsonKey(name: 'this_month_income') this.thisMonthIncome = '0',
      @JsonKey(name: 'this_month_outcome') this.thisMonthOutcome = '0'});
  factory _FinanceProfile.fromJson(Map<String, dynamic> json) =>
      _$FinanceProfileFromJson(json);

  @override
  @JsonKey(name: 'monthly_income')
  final double? monthlyIncome;
  @override
  @JsonKey(name: 'current_savings')
  final String currentSavings;
  @override
  @JsonKey()
  final String debt;
  @override
  @JsonKey(name: 'financial_goals')
  final String financialGoals;
  @override
  @JsonKey(name: 'total_income')
  final String totalIncome;
  @override
  @JsonKey(name: 'total_outcome')
  final String totalOutcome;
  @override
  @JsonKey(name: 'risk_management')
  final String riskManagement;
  @override
  @JsonKey(name: 'this_month_income')
  final String thisMonthIncome;
// Tambahkan field yang mungkin terlewat dari respons
  @override
  @JsonKey(name: 'this_month_outcome')
  final String thisMonthOutcome;

  /// Create a copy of FinanceProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FinanceProfileCopyWith<_FinanceProfile> get copyWith =>
      __$FinanceProfileCopyWithImpl<_FinanceProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FinanceProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FinanceProfile &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome) &&
            (identical(other.currentSavings, currentSavings) ||
                other.currentSavings == currentSavings) &&
            (identical(other.debt, debt) || other.debt == debt) &&
            (identical(other.financialGoals, financialGoals) ||
                other.financialGoals == financialGoals) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalOutcome, totalOutcome) ||
                other.totalOutcome == totalOutcome) &&
            (identical(other.riskManagement, riskManagement) ||
                other.riskManagement == riskManagement) &&
            (identical(other.thisMonthIncome, thisMonthIncome) ||
                other.thisMonthIncome == thisMonthIncome) &&
            (identical(other.thisMonthOutcome, thisMonthOutcome) ||
                other.thisMonthOutcome == thisMonthOutcome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      monthlyIncome,
      currentSavings,
      debt,
      financialGoals,
      totalIncome,
      totalOutcome,
      riskManagement,
      thisMonthIncome,
      thisMonthOutcome);

  @override
  String toString() {
    return 'FinanceProfile(monthlyIncome: $monthlyIncome, currentSavings: $currentSavings, debt: $debt, financialGoals: $financialGoals, totalIncome: $totalIncome, totalOutcome: $totalOutcome, riskManagement: $riskManagement, thisMonthIncome: $thisMonthIncome, thisMonthOutcome: $thisMonthOutcome)';
  }
}

/// @nodoc
abstract mixin class _$FinanceProfileCopyWith<$Res>
    implements $FinanceProfileCopyWith<$Res> {
  factory _$FinanceProfileCopyWith(
          _FinanceProfile value, $Res Function(_FinanceProfile) _then) =
      __$FinanceProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'monthly_income') double? monthlyIncome,
      @JsonKey(name: 'current_savings') String currentSavings,
      String debt,
      @JsonKey(name: 'financial_goals') String financialGoals,
      @JsonKey(name: 'total_income') String totalIncome,
      @JsonKey(name: 'total_outcome') String totalOutcome,
      @JsonKey(name: 'risk_management') String riskManagement,
      @JsonKey(name: 'this_month_income') String thisMonthIncome,
      @JsonKey(name: 'this_month_outcome') String thisMonthOutcome});
}

/// @nodoc
class __$FinanceProfileCopyWithImpl<$Res>
    implements _$FinanceProfileCopyWith<$Res> {
  __$FinanceProfileCopyWithImpl(this._self, this._then);

  final _FinanceProfile _self;
  final $Res Function(_FinanceProfile) _then;

  /// Create a copy of FinanceProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? monthlyIncome = freezed,
    Object? currentSavings = null,
    Object? debt = null,
    Object? financialGoals = null,
    Object? totalIncome = null,
    Object? totalOutcome = null,
    Object? riskManagement = null,
    Object? thisMonthIncome = null,
    Object? thisMonthOutcome = null,
  }) {
    return _then(_FinanceProfile(
      monthlyIncome: freezed == monthlyIncome
          ? _self.monthlyIncome
          : monthlyIncome // ignore: cast_nullable_to_non_nullable
              as double?,
      currentSavings: null == currentSavings
          ? _self.currentSavings
          : currentSavings // ignore: cast_nullable_to_non_nullable
              as String,
      debt: null == debt
          ? _self.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as String,
      financialGoals: null == financialGoals
          ? _self.financialGoals
          : financialGoals // ignore: cast_nullable_to_non_nullable
              as String,
      totalIncome: null == totalIncome
          ? _self.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as String,
      totalOutcome: null == totalOutcome
          ? _self.totalOutcome
          : totalOutcome // ignore: cast_nullable_to_non_nullable
              as String,
      riskManagement: null == riskManagement
          ? _self.riskManagement
          : riskManagement // ignore: cast_nullable_to_non_nullable
              as String,
      thisMonthIncome: null == thisMonthIncome
          ? _self.thisMonthIncome
          : thisMonthIncome // ignore: cast_nullable_to_non_nullable
              as String,
      thisMonthOutcome: null == thisMonthOutcome
          ? _self.thisMonthOutcome
          : thisMonthOutcome // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
