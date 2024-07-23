import 'package:notesmanager/services/auth/auth_exceptions.dart';
import 'package:notesmanager/services/auth/auth_provider.dart';
import 'package:notesmanager/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authenication', () {
    final provider = MockAuthProvider();
    test('Should not be intialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initalized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitialziedException>()),
      );
    });

    test('Should be able initalized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test('Should be able to initalized in less than 2 second', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test('Create user should delegate to logIn function', () async {
      final badEmailUser =
          provider.createUser(email: 'test@test.com', password: 'test1234');
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));
    });

    test('Create user should delegate to logIn function', () async {
      final badEmailUser =
          provider.createUser(email: 'adas@test.com', password: 'test1234');
      expect(badEmailUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));
    });
  });
}

class NotInitialziedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!isInitialized) throw NotInitialziedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    if (!isInitialized) throw NotInitialziedException();
    if (email == 'test@test.com') throw UserNotFoundAuthException();
    if (password == 'test1234') throw WrongPasswordAuthException();
    const user =
        AuthUser(id: '1', email: 'good@test.com', isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitialziedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitialziedException();
    if (_user == null) throw UserNotFoundAuthException();
    const newUser =
        AuthUser(id: '1', email: 'good@test.com', isEmailVerified: true);
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    // TODO: implement sendPasswordReset
    if (!isInitialized) throw NotInitialziedException();
    if (_user == null) throw UserNotFoundAuthException();
  }
}
