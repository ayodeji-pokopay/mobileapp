import 'package:json_annotation/json_annotation.dart';

/// The backend promises numbers and booleans, but a stringly-typed field
/// from a new build must degrade to null, not crash the whole feed.
/// Applied at class level so every `num?`, `int?` and `bool?` field uses it.
class LenientNum implements JsonConverter<num?, Object?> {
  const LenientNum();
  @override
  num? fromJson(Object? json) => switch (json) {
    num n => n,
    String s => num.tryParse(s.replaceAll(',', '').trim()),
    bool b => b ? 1 : 0,
    _ => null,
  };
  @override
  Object? toJson(num? object) => object;
}

class LenientInt implements JsonConverter<int?, Object?> {
  const LenientInt();
  @override
  int? fromJson(Object? json) => switch (json) {
    int i => i,
    num n => n.isFinite ? n.round() : null,
    String s => int.tryParse(s.trim()) ?? num.tryParse(s.trim())?.round(),
    _ => null,
  };
  @override
  Object? toJson(int? object) => object;
}

class LenientBool implements JsonConverter<bool?, Object?> {
  const LenientBool();
  @override
  bool? fromJson(Object? json) => switch (json) {
    bool b => b,
    num n => n != 0,
    String s => switch (s.trim().toLowerCase()) {
      'true' || 'yes' || '1' || 'y' => true,
      'false' || 'no' || '0' || 'n' || '' => false,
      _ => null,
    },
    _ => null,
  };
  @override
  Object? toJson(bool? object) => object;
}

/// Non-nullable flags with a default: anything unreadable becomes false.
class LenientFlag implements JsonConverter<bool, Object?> {
  const LenientFlag();
  @override
  bool fromJson(Object? json) => const LenientBool().fromJson(json) ?? false;
  @override
  Object? toJson(bool object) => object;
}

/// Optional nested objects: a non-map value is treated as absent.
class LenientMap implements JsonConverter<Map<String, dynamic>?, Object?> {
  const LenientMap();
  @override
  Map<String, dynamic>? fromJson(Object? json) =>
      json is Map ? json.cast<String, dynamic>() : null;
  @override
  Object? toJson(Map<String, dynamic>? object) => object;
}
