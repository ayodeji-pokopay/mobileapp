/// Remote app configuration from `GET /api/v1/app/config`.
///
/// Every field has a safe default so the app behaves normally when the
/// endpoint does not exist yet or the device is offline.
class AppConfig {
  const AppConfig({
    this.minSupportedVersion,
    this.latestVersion,
    this.forceUpdate = false,
    this.storeUrl,
    this.maintenance = const MaintenanceInfo(),
    this.support = const SupportInfo(),
    this.features = const FeatureFlags(),
    this.currency = const CurrencyInfo(),
    this.dialCode = '234',
  });

  final String? minSupportedVersion;
  final String? latestVersion;
  final bool forceUpdate;
  final String? storeUrl;
  final MaintenanceInfo maintenance;
  final SupportInfo support;

  /// Country calling code used to normalise customer phone numbers
  /// (`region.dialCode` in remote config; Nigeria by default).
  final String dialCode;
  final FeatureFlags features;
  final CurrencyInfo currency;

  static const defaults = AppConfig();

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> obj(String k) => (json[k] is Map<String, dynamic>)
        ? json[k] as Map<String, dynamic>
        : const {};
    return AppConfig(
      minSupportedVersion: json['minSupportedVersion']?.toString(),
      latestVersion: json['latestVersion']?.toString(),
      forceUpdate: json['forceUpdate'] == true,
      storeUrl: json['storeUrl']?.toString(),
      maintenance: MaintenanceInfo.fromJson(obj('maintenance')),
      support: SupportInfo.fromJson(obj('support')),
      dialCode: (obj('region')['dialCode'] ?? json['dialCode'] ?? '234')
          .toString()
          .replaceAll(RegExp(r'\D'), ''),
      features: FeatureFlags.fromJson(obj('features')),
      currency: CurrencyInfo.fromJson(obj('currency')),
    );
  }

  /// True when [currentVersion] is older than [minSupportedVersion], or the
  /// backend has explicitly demanded an update.
  bool requiresUpdate(String currentVersion) {
    if (forceUpdate) return true;
    final min = minSupportedVersion;
    if (min == null || min.isEmpty) return false;
    return compareVersions(currentVersion, min) < 0;
  }
}

class MaintenanceInfo {
  const MaintenanceInfo({this.enabled = false, this.message, this.until});
  final bool enabled;
  final String? message;
  final DateTime? until;

  factory MaintenanceInfo.fromJson(Map<String, dynamic> json) =>
      MaintenanceInfo(
        enabled: json['enabled'] == true,
        message: json['message']?.toString(),
        until: DateTime.tryParse(json['until']?.toString() ?? ''),
      );
}

class SupportInfo {
  const SupportInfo({
    this.email = 'support@pokopayng.com',
    this.phone,
    this.whatsapp,
  });
  final String email;
  final String? phone;
  final String? whatsapp;

  factory SupportInfo.fromJson(Map<String, dynamic> json) => SupportInfo(
    email: (json['email']?.toString() ?? '').isEmpty
        ? 'support@pokopayng.com'
        : json['email'].toString(),
    phone: json['phone']?.toString(),
    whatsapp: json['whatsapp']?.toString(),
  );
}

class FeatureFlags {
  const FeatureFlags({
    this.paymentLinks = false,
    this.instantSettlement = true,
    this.invoices = false,
  });
  final bool paymentLinks;
  final bool instantSettlement;
  final bool invoices;

  factory FeatureFlags.fromJson(Map<String, dynamic> json) => FeatureFlags(
    paymentLinks: json['paymentLinks'] == true,
    instantSettlement: json['instantSettlement'] != false,
    invoices: json['invoices'] == true,
  );
}

class CurrencyInfo {
  const CurrencyInfo({
    this.code = 'NGN',
    this.symbol = '₦',
    this.locale = 'en_NG',
  });
  final String code;
  final String symbol;
  final String locale;

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) => CurrencyInfo(
    code: (json['code']?.toString() ?? '').isEmpty
        ? 'NGN'
        : json['code'].toString(),
    symbol: (json['symbol']?.toString() ?? '').isEmpty
        ? '₦'
        : json['symbol'].toString(),
    locale: (json['locale']?.toString() ?? '').isEmpty
        ? 'en_NG'
        : json['locale'].toString(),
  );
}

/// Compares dotted version strings numerically: "1.2.10" > "1.2.9".
/// Returns negative when [a] < [b], zero when equal, positive when greater.
int compareVersions(String a, String b) {
  List<int> parse(String v) => v
      .split('+')
      .first
      .split('.')
      .map((p) => int.tryParse(p.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0)
      .toList();
  final pa = parse(a);
  final pb = parse(b);
  final n = pa.length > pb.length ? pa.length : pb.length;
  for (var i = 0; i < n; i++) {
    final x = i < pa.length ? pa[i] : 0;
    final y = i < pb.length ? pb[i] : 0;
    if (x != y) return x.compareTo(y);
  }
  return 0;
}
