import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/features/auth/password_policy.dart';

void main() {
  test('password complexity follows the 30 Sep 2026 policy', () {
    expect(meetsPasswordComplexity('Pokopay#2026x'), isTrue);
    expect(meetsPasswordComplexity('pokopay#2026x'), isFalse); // no upper
    expect(meetsPasswordComplexity('POKOPAY#2026X'), isFalse); // no lower
    expect(meetsPasswordComplexity('Pokopay#merch'), isFalse); // no digit
    expect(meetsPasswordComplexity('Pokopay2026xy'), isFalse); // no symbol
    expect(minPasswordLength, 12);
  });
}
