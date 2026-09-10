import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/biometric/biometric_service.dart';
import 'package:pokopay/core/storage/secure_storage.dart';
import 'package:pokopay/core/theme/app_theme.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';
import 'package:pokopay/features/auth/presentation/login_screen.dart';
import 'package:pokopay/l10n/generated/app_localizations.dart';

import '../helpers/fakes.dart';

class LoginRepoStub extends AuthRepository {
  LoginRepoStub() : super(fakeApi((_) async => json({})), FakeSecureStorage());
  String? error;
  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    throw AuthException(error ?? 'Invalid email or password');
  }
}

Widget harness(LoginRepoStub repo) {
  return ProviderScope(
    overrides: [
      secureStorageProvider.overrideWithValue(FakeSecureStorage()),
      authRepositoryProvider.overrideWithValue(repo),
      biometricAvailableProvider.overrideWith((ref) async => false),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoginScreen(),
    ),
  );
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('renders the welcome copy and fields', (tester) async {
    await tester.pumpWidget(harness(LoginRepoStub()));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in to your merchant account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('validates empty fields before calling the API', (tester) async {
    await tester.pumpWidget(harness(LoginRepoStub()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Email required'), findsOneWidget);
    expect(find.text('Password required'), findsOneWidget);
  });

  testWidgets('rejects an email without @', (tester) async {
    await tester.pumpWidget(harness(LoginRepoStub()));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'notanemail');
    await tester.enterText(find.byType(TextFormField).last, 'secret');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  testWidgets('shows the backend error in a snackbar', (tester) async {
    final repo = LoginRepoStub()..error = 'Account locked';
    await tester.pumpWidget(harness(repo));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'a@b.com');
    await tester.enterText(find.byType(TextFormField).last, 'secret');
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Account locked'), findsOneWidget);
  });

  testWidgets('toggles password visibility', (tester) async {
    await tester.pumpWidget(harness(LoginRepoStub()));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Show password'), findsOneWidget);
    await tester.tap(find.byTooltip('Show password'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Hide password'), findsOneWidget);
  });
}
