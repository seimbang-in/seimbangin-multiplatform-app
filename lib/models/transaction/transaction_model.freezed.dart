// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionResponse {
  bool get success;
  String get message;
  List<TransactionData> get data;
  Meta? get meta;

  /// Create a copy of TransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionResponseCopyWith<TransactionResponse> get copyWith =>
      _$TransactionResponseCopyWithImpl<TransactionResponse>(
          this as TransactionResponse, _$identity);

  /// Serializes this TransactionResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(data), meta);

  @override
  String toString() {
    return 'TransactionResponse(success: $success, message: $message, data: $data, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $TransactionResponseCopyWith<$Res> {
  factory $TransactionResponseCopyWith(
          TransactionResponse value, $Res Function(TransactionResponse) _then) =
      _$TransactionResponseCopyWithImpl;
  @useResult
  $Res call(
      {bool success, String message, List<TransactionData> data, Meta? meta});

  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$TransactionResponseCopyWithImpl<$Res>
    implements $TransactionResponseCopyWith<$Res> {
  _$TransactionResponseCopyWithImpl(this._self, this._then);

  final TransactionResponse _self;
  final $Res Function(TransactionResponse) _then;

  /// Create a copy of TransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? meta = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TransactionData>,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
    ));
  }

  /// Create a copy of TransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $MetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [TransactionResponse].
extension TransactionResponsePatterns on TransactionResponse {
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
    TResult Function(_TransactionResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionResponse() when $default != null:
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
    TResult Function(_TransactionResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionResponse():
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
    TResult? Function(_TransactionResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionResponse() when $default != null:
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
    TResult Function(bool success, String message, List<TransactionData> data,
            Meta? meta)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionResponse() when $default != null:
        return $default(_that.success, _that.message, _that.data, _that.meta);
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
    TResult Function(bool success, String message, List<TransactionData> data,
            Meta? meta)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionResponse():
        return $default(_that.success, _that.message, _that.data, _that.meta);
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
    TResult? Function(bool success, String message, List<TransactionData> data,
            Meta? meta)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionResponse() when $default != null:
        return $default(_that.success, _that.message, _that.data, _that.meta);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionResponse implements TransactionResponse {
  _TransactionResponse(
      {this.success = false,
      this.message = '',
      final List<TransactionData> data = const [],
      this.meta})
      : _data = data;
  factory _TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  final List<TransactionData> _data;
  @override
  @JsonKey()
  List<TransactionData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Meta? meta;

  /// Create a copy of TransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionResponseCopyWith<_TransactionResponse> get copyWith =>
      __$TransactionResponseCopyWithImpl<_TransactionResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionResponse &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data), meta);

  @override
  String toString() {
    return 'TransactionResponse(success: $success, message: $message, data: $data, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class _$TransactionResponseCopyWith<$Res>
    implements $TransactionResponseCopyWith<$Res> {
  factory _$TransactionResponseCopyWith(_TransactionResponse value,
          $Res Function(_TransactionResponse) _then) =
      __$TransactionResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool success, String message, List<TransactionData> data, Meta? meta});

  @override
  $MetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$TransactionResponseCopyWithImpl<$Res>
    implements _$TransactionResponseCopyWith<$Res> {
  __$TransactionResponseCopyWithImpl(this._self, this._then);

  final _TransactionResponse _self;
  final $Res Function(_TransactionResponse) _then;

  /// Create a copy of TransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? meta = freezed,
  }) {
    return _then(_TransactionResponse(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TransactionData>,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Meta?,
    ));
  }

  /// Create a copy of TransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $MetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
mixin _$TransactionData {
  int get id;
  @JsonKey(name: 'user_id')
  int get userId;
  String get name;
  int get type;
  String get amount;
  String get category;
  String get description;
  String? get createdAt;
  String? get updatedAt;
  List<TransactionItem> get items;

  /// Create a copy of TransactionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionDataCopyWith<TransactionData> get copyWith =>
      _$TransactionDataCopyWithImpl<TransactionData>(
          this as TransactionData, _$identity);

  /// Serializes this TransactionData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      type,
      amount,
      category,
      description,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'TransactionData(id: $id, userId: $userId, name: $name, type: $type, amount: $amount, category: $category, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, items: $items)';
  }
}

/// @nodoc
abstract mixin class $TransactionDataCopyWith<$Res> {
  factory $TransactionDataCopyWith(
          TransactionData value, $Res Function(TransactionData) _then) =
      _$TransactionDataCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      String name,
      int type,
      String amount,
      String category,
      String description,
      String? createdAt,
      String? updatedAt,
      List<TransactionItem> items});
}

/// @nodoc
class _$TransactionDataCopyWithImpl<$Res>
    implements $TransactionDataCopyWith<$Res> {
  _$TransactionDataCopyWithImpl(this._self, this._then);

  final TransactionData _self;
  final $Res Function(TransactionData) _then;

  /// Create a copy of TransactionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? type = null,
    Object? amount = null,
    Object? category = null,
    Object? description = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TransactionItem>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TransactionData].
extension TransactionDataPatterns on TransactionData {
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
    TResult Function(_TransactionData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionData() when $default != null:
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
    TResult Function(_TransactionData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionData():
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
    TResult? Function(_TransactionData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionData() when $default != null:
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
            @JsonKey(name: 'user_id') int userId,
            String name,
            int type,
            String amount,
            String category,
            String description,
            String? createdAt,
            String? updatedAt,
            List<TransactionItem> items)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionData() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.type,
            _that.amount,
            _that.category,
            _that.description,
            _that.createdAt,
            _that.updatedAt,
            _that.items);
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
            @JsonKey(name: 'user_id') int userId,
            String name,
            int type,
            String amount,
            String category,
            String description,
            String? createdAt,
            String? updatedAt,
            List<TransactionItem> items)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionData():
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.type,
            _that.amount,
            _that.category,
            _that.description,
            _that.createdAt,
            _that.updatedAt,
            _that.items);
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
            @JsonKey(name: 'user_id') int userId,
            String name,
            int type,
            String amount,
            String category,
            String description,
            String? createdAt,
            String? updatedAt,
            List<TransactionItem> items)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionData() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.name,
            _that.type,
            _that.amount,
            _that.category,
            _that.description,
            _that.createdAt,
            _that.updatedAt,
            _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionData implements TransactionData {
  _TransactionData(
      {this.id = 0,
      @JsonKey(name: 'user_id') this.userId = 0,
      this.name = '',
      this.type = 0,
      this.amount = '0',
      this.category = 'others',
      this.description = '',
      this.createdAt,
      this.updatedAt,
      final List<TransactionItem> items = const []})
      : _items = items;
  factory _TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int type;
  @override
  @JsonKey()
  final String amount;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String description;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  final List<TransactionItem> _items;
  @override
  @JsonKey()
  List<TransactionItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of TransactionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionDataCopyWith<_TransactionData> get copyWith =>
      __$TransactionDataCopyWithImpl<_TransactionData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      type,
      amount,
      category,
      description,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'TransactionData(id: $id, userId: $userId, name: $name, type: $type, amount: $amount, category: $category, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$TransactionDataCopyWith<$Res>
    implements $TransactionDataCopyWith<$Res> {
  factory _$TransactionDataCopyWith(
          _TransactionData value, $Res Function(_TransactionData) _then) =
      __$TransactionDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      String name,
      int type,
      String amount,
      String category,
      String description,
      String? createdAt,
      String? updatedAt,
      List<TransactionItem> items});
}

/// @nodoc
class __$TransactionDataCopyWithImpl<$Res>
    implements _$TransactionDataCopyWith<$Res> {
  __$TransactionDataCopyWithImpl(this._self, this._then);

  final _TransactionData _self;
  final $Res Function(_TransactionData) _then;

  /// Create a copy of TransactionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? type = null,
    Object? amount = null,
    Object? category = null,
    Object? description = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? items = null,
  }) {
    return _then(_TransactionData(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TransactionItem>,
    ));
  }
}

/// @nodoc
mixin _$TransactionPreviewData {
  String get transactionName;
  int get transactionType; // 0 for Income, 1 for Outcome
  double get totalAmount;
  DateTime get transactionDate;
  List<TransactionItem> get items;

  /// Create a copy of TransactionPreviewData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionPreviewDataCopyWith<TransactionPreviewData> get copyWith =>
      _$TransactionPreviewDataCopyWithImpl<TransactionPreviewData>(
          this as TransactionPreviewData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionPreviewData &&
            (identical(other.transactionName, transactionName) ||
                other.transactionName == transactionName) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionName, transactionType,
      totalAmount, transactionDate, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'TransactionPreviewData(transactionName: $transactionName, transactionType: $transactionType, totalAmount: $totalAmount, transactionDate: $transactionDate, items: $items)';
  }
}

/// @nodoc
abstract mixin class $TransactionPreviewDataCopyWith<$Res> {
  factory $TransactionPreviewDataCopyWith(TransactionPreviewData value,
          $Res Function(TransactionPreviewData) _then) =
      _$TransactionPreviewDataCopyWithImpl;
  @useResult
  $Res call(
      {String transactionName,
      int transactionType,
      double totalAmount,
      DateTime transactionDate,
      List<TransactionItem> items});
}

/// @nodoc
class _$TransactionPreviewDataCopyWithImpl<$Res>
    implements $TransactionPreviewDataCopyWith<$Res> {
  _$TransactionPreviewDataCopyWithImpl(this._self, this._then);

  final TransactionPreviewData _self;
  final $Res Function(TransactionPreviewData) _then;

  /// Create a copy of TransactionPreviewData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionName = null,
    Object? transactionType = null,
    Object? totalAmount = null,
    Object? transactionDate = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      transactionName: null == transactionName
          ? _self.transactionName
          : transactionName // ignore: cast_nullable_to_non_nullable
              as String,
      transactionType: null == transactionType
          ? _self.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _self.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TransactionItem>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TransactionPreviewData].
extension TransactionPreviewDataPatterns on TransactionPreviewData {
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
    TResult Function(_TransactionPreviewData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionPreviewData() when $default != null:
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
    TResult Function(_TransactionPreviewData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionPreviewData():
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
    TResult? Function(_TransactionPreviewData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionPreviewData() when $default != null:
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
            String transactionName,
            int transactionType,
            double totalAmount,
            DateTime transactionDate,
            List<TransactionItem> items)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionPreviewData() when $default != null:
        return $default(_that.transactionName, _that.transactionType,
            _that.totalAmount, _that.transactionDate, _that.items);
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
            String transactionName,
            int transactionType,
            double totalAmount,
            DateTime transactionDate,
            List<TransactionItem> items)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionPreviewData():
        return $default(_that.transactionName, _that.transactionType,
            _that.totalAmount, _that.transactionDate, _that.items);
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
            String transactionName,
            int transactionType,
            double totalAmount,
            DateTime transactionDate,
            List<TransactionItem> items)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionPreviewData() when $default != null:
        return $default(_that.transactionName, _that.transactionType,
            _that.totalAmount, _that.transactionDate, _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TransactionPreviewData implements TransactionPreviewData {
  _TransactionPreviewData(
      {required this.transactionName,
      required this.transactionType,
      required this.totalAmount,
      required this.transactionDate,
      final List<TransactionItem> items = const []})
      : _items = items;

  @override
  final String transactionName;
  @override
  final int transactionType;
// 0 for Income, 1 for Outcome
  @override
  final double totalAmount;
  @override
  final DateTime transactionDate;
  final List<TransactionItem> _items;
  @override
  @JsonKey()
  List<TransactionItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of TransactionPreviewData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionPreviewDataCopyWith<_TransactionPreviewData> get copyWith =>
      __$TransactionPreviewDataCopyWithImpl<_TransactionPreviewData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionPreviewData &&
            (identical(other.transactionName, transactionName) ||
                other.transactionName == transactionName) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionName,
      transactionType,
      totalAmount,
      transactionDate,
      const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'TransactionPreviewData(transactionName: $transactionName, transactionType: $transactionType, totalAmount: $totalAmount, transactionDate: $transactionDate, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$TransactionPreviewDataCopyWith<$Res>
    implements $TransactionPreviewDataCopyWith<$Res> {
  factory _$TransactionPreviewDataCopyWith(_TransactionPreviewData value,
          $Res Function(_TransactionPreviewData) _then) =
      __$TransactionPreviewDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String transactionName,
      int transactionType,
      double totalAmount,
      DateTime transactionDate,
      List<TransactionItem> items});
}

/// @nodoc
class __$TransactionPreviewDataCopyWithImpl<$Res>
    implements _$TransactionPreviewDataCopyWith<$Res> {
  __$TransactionPreviewDataCopyWithImpl(this._self, this._then);

  final _TransactionPreviewData _self;
  final $Res Function(_TransactionPreviewData) _then;

  /// Create a copy of TransactionPreviewData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transactionName = null,
    Object? transactionType = null,
    Object? totalAmount = null,
    Object? transactionDate = null,
    Object? items = null,
  }) {
    return _then(_TransactionPreviewData(
      transactionName: null == transactionName
          ? _self.transactionName
          : transactionName // ignore: cast_nullable_to_non_nullable
              as String,
      transactionType: null == transactionType
          ? _self.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _self.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _self.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TransactionItem>,
    ));
  }
}

/// @nodoc
mixin _$TransactionItem {
  int get id;
  @JsonKey(name: 'transaction_id')
  int get transactionId;
  @JsonKey(name: 'item_name')
  String get itemName;
  String get category;
  String get price;
  int get quantity;
  String get subtotal;
  String? get createdAt;
  String? get updatedAt;

  /// Create a copy of TransactionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionItemCopyWith<TransactionItem> get copyWith =>
      _$TransactionItemCopyWithImpl<TransactionItem>(
          this as TransactionItem, _$identity);

  /// Serializes this TransactionItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, transactionId, itemName,
      category, price, quantity, subtotal, createdAt, updatedAt);

  @override
  String toString() {
    return 'TransactionItem(id: $id, transactionId: $transactionId, itemName: $itemName, category: $category, price: $price, quantity: $quantity, subtotal: $subtotal, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $TransactionItemCopyWith<$Res> {
  factory $TransactionItemCopyWith(
          TransactionItem value, $Res Function(TransactionItem) _then) =
      _$TransactionItemCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'transaction_id') int transactionId,
      @JsonKey(name: 'item_name') String itemName,
      String category,
      String price,
      int quantity,
      String subtotal,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class _$TransactionItemCopyWithImpl<$Res>
    implements $TransactionItemCopyWith<$Res> {
  _$TransactionItemCopyWithImpl(this._self, this._then);

  final TransactionItem _self;
  final $Res Function(TransactionItem) _then;

  /// Create a copy of TransactionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = null,
    Object? itemName = null,
    Object? category = null,
    Object? price = null,
    Object? quantity = null,
    Object? subtotal = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: null == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      itemName: null == itemName
          ? _self.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _self.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TransactionItem].
extension TransactionItemPatterns on TransactionItem {
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
    TResult Function(_TransactionItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionItem() when $default != null:
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
    TResult Function(_TransactionItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionItem():
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
    TResult? Function(_TransactionItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionItem() when $default != null:
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
            @JsonKey(name: 'transaction_id') int transactionId,
            @JsonKey(name: 'item_name') String itemName,
            String category,
            String price,
            int quantity,
            String subtotal,
            String? createdAt,
            String? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionItem() when $default != null:
        return $default(
            _that.id,
            _that.transactionId,
            _that.itemName,
            _that.category,
            _that.price,
            _that.quantity,
            _that.subtotal,
            _that.createdAt,
            _that.updatedAt);
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
            @JsonKey(name: 'transaction_id') int transactionId,
            @JsonKey(name: 'item_name') String itemName,
            String category,
            String price,
            int quantity,
            String subtotal,
            String? createdAt,
            String? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionItem():
        return $default(
            _that.id,
            _that.transactionId,
            _that.itemName,
            _that.category,
            _that.price,
            _that.quantity,
            _that.subtotal,
            _that.createdAt,
            _that.updatedAt);
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
            @JsonKey(name: 'transaction_id') int transactionId,
            @JsonKey(name: 'item_name') String itemName,
            String category,
            String price,
            int quantity,
            String subtotal,
            String? createdAt,
            String? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionItem() when $default != null:
        return $default(
            _that.id,
            _that.transactionId,
            _that.itemName,
            _that.category,
            _that.price,
            _that.quantity,
            _that.subtotal,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionItem implements TransactionItem {
  _TransactionItem(
      {this.id = 0,
      @JsonKey(name: 'transaction_id') this.transactionId = 0,
      @JsonKey(name: 'item_name') this.itemName = '',
      this.category = 'others',
      this.price = '0',
      this.quantity = 0,
      this.subtotal = '0',
      this.createdAt,
      this.updatedAt});
  factory _TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: 'transaction_id')
  final int transactionId;
  @override
  @JsonKey(name: 'item_name')
  final String itemName;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String price;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final String subtotal;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  /// Create a copy of TransactionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionItemCopyWith<_TransactionItem> get copyWith =>
      __$TransactionItemCopyWithImpl<_TransactionItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, transactionId, itemName,
      category, price, quantity, subtotal, createdAt, updatedAt);

  @override
  String toString() {
    return 'TransactionItem(id: $id, transactionId: $transactionId, itemName: $itemName, category: $category, price: $price, quantity: $quantity, subtotal: $subtotal, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$TransactionItemCopyWith<$Res>
    implements $TransactionItemCopyWith<$Res> {
  factory _$TransactionItemCopyWith(
          _TransactionItem value, $Res Function(_TransactionItem) _then) =
      __$TransactionItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'transaction_id') int transactionId,
      @JsonKey(name: 'item_name') String itemName,
      String category,
      String price,
      int quantity,
      String subtotal,
      String? createdAt,
      String? updatedAt});
}

/// @nodoc
class __$TransactionItemCopyWithImpl<$Res>
    implements _$TransactionItemCopyWith<$Res> {
  __$TransactionItemCopyWithImpl(this._self, this._then);

  final _TransactionItem _self;
  final $Res Function(_TransactionItem) _then;

  /// Create a copy of TransactionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? transactionId = null,
    Object? itemName = null,
    Object? category = null,
    Object? price = null,
    Object? quantity = null,
    Object? subtotal = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_TransactionItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      transactionId: null == transactionId
          ? _self.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      itemName: null == itemName
          ? _self.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _self.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Meta {
  @JsonKey(name: 'currentPage')
  int get currentPage;
  int get limit;
  @JsonKey(name: 'totalPages')
  int get totalPages;
  @JsonKey(name: 'totalItems')
  int get totalItems;
  @JsonKey(name: 'hasNextPage')
  bool get hasNextPage;
  @JsonKey(name: 'hasPreviousPage')
  bool get hasPreviousPage;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MetaCopyWith<Meta> get copyWith =>
      _$MetaCopyWithImpl<Meta>(this as Meta, _$identity);

  /// Serializes this Meta to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Meta &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPage, limit, totalPages,
      totalItems, hasNextPage, hasPreviousPage);

  @override
  String toString() {
    return 'Meta(currentPage: $currentPage, limit: $limit, totalPages: $totalPages, totalItems: $totalItems, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
  }
}

/// @nodoc
abstract mixin class $MetaCopyWith<$Res> {
  factory $MetaCopyWith(Meta value, $Res Function(Meta) _then) =
      _$MetaCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'currentPage') int currentPage,
      int limit,
      @JsonKey(name: 'totalPages') int totalPages,
      @JsonKey(name: 'totalItems') int totalItems,
      @JsonKey(name: 'hasNextPage') bool hasNextPage,
      @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage});
}

/// @nodoc
class _$MetaCopyWithImpl<$Res> implements $MetaCopyWith<$Res> {
  _$MetaCopyWithImpl(this._self, this._then);

  final Meta _self;
  final $Res Function(Meta) _then;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? limit = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? hasNextPage = null,
    Object? hasPreviousPage = null,
  }) {
    return _then(_self.copyWith(
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPreviousPage: null == hasPreviousPage
          ? _self.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Meta].
extension MetaPatterns on Meta {
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
    TResult Function(_Meta value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Meta() when $default != null:
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
    TResult Function(_Meta value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Meta():
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
    TResult? Function(_Meta value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Meta() when $default != null:
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
            @JsonKey(name: 'currentPage') int currentPage,
            int limit,
            @JsonKey(name: 'totalPages') int totalPages,
            @JsonKey(name: 'totalItems') int totalItems,
            @JsonKey(name: 'hasNextPage') bool hasNextPage,
            @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Meta() when $default != null:
        return $default(_that.currentPage, _that.limit, _that.totalPages,
            _that.totalItems, _that.hasNextPage, _that.hasPreviousPage);
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
            @JsonKey(name: 'currentPage') int currentPage,
            int limit,
            @JsonKey(name: 'totalPages') int totalPages,
            @JsonKey(name: 'totalItems') int totalItems,
            @JsonKey(name: 'hasNextPage') bool hasNextPage,
            @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Meta():
        return $default(_that.currentPage, _that.limit, _that.totalPages,
            _that.totalItems, _that.hasNextPage, _that.hasPreviousPage);
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
            @JsonKey(name: 'currentPage') int currentPage,
            int limit,
            @JsonKey(name: 'totalPages') int totalPages,
            @JsonKey(name: 'totalItems') int totalItems,
            @JsonKey(name: 'hasNextPage') bool hasNextPage,
            @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Meta() when $default != null:
        return $default(_that.currentPage, _that.limit, _that.totalPages,
            _that.totalItems, _that.hasNextPage, _that.hasPreviousPage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Meta implements Meta {
  _Meta(
      {@JsonKey(name: 'currentPage') this.currentPage = 0,
      this.limit = 0,
      @JsonKey(name: 'totalPages') this.totalPages = 0,
      @JsonKey(name: 'totalItems') this.totalItems = 0,
      @JsonKey(name: 'hasNextPage') this.hasNextPage = false,
      @JsonKey(name: 'hasPreviousPage') this.hasPreviousPage = false});
  factory _Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  @override
  @JsonKey(name: 'currentPage')
  final int currentPage;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey(name: 'totalPages')
  final int totalPages;
  @override
  @JsonKey(name: 'totalItems')
  final int totalItems;
  @override
  @JsonKey(name: 'hasNextPage')
  final bool hasNextPage;
  @override
  @JsonKey(name: 'hasPreviousPage')
  final bool hasPreviousPage;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MetaCopyWith<_Meta> get copyWith =>
      __$MetaCopyWithImpl<_Meta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MetaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Meta &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPage, limit, totalPages,
      totalItems, hasNextPage, hasPreviousPage);

  @override
  String toString() {
    return 'Meta(currentPage: $currentPage, limit: $limit, totalPages: $totalPages, totalItems: $totalItems, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
  }
}

/// @nodoc
abstract mixin class _$MetaCopyWith<$Res> implements $MetaCopyWith<$Res> {
  factory _$MetaCopyWith(_Meta value, $Res Function(_Meta) _then) =
      __$MetaCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currentPage') int currentPage,
      int limit,
      @JsonKey(name: 'totalPages') int totalPages,
      @JsonKey(name: 'totalItems') int totalItems,
      @JsonKey(name: 'hasNextPage') bool hasNextPage,
      @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage});
}

/// @nodoc
class __$MetaCopyWithImpl<$Res> implements _$MetaCopyWith<$Res> {
  __$MetaCopyWithImpl(this._self, this._then);

  final _Meta _self;
  final $Res Function(_Meta) _then;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentPage = null,
    Object? limit = null,
    Object? totalPages = null,
    Object? totalItems = null,
    Object? hasNextPage = null,
    Object? hasPreviousPage = null,
  }) {
    return _then(_Meta(
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _self.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPreviousPage: null == hasPreviousPage
          ? _self.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
