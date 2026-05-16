import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to auth state changes
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = result.user;

      // Block access if email is not verified
      if (user != null && !user.emailVerified) {
        await _auth.signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email first. Check your inbox (or spam folder).',
        );
      }
      return result;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Register with email and password using a temporary app instance to avoid auto-login flicker
  Future<UserCredential?> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    FirebaseApp? tempApp;
    try {
      tempApp = await Firebase.initializeApp(
        name: 'TempRegisterApp',
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FirebaseAuth tempAuth = FirebaseAuth.instanceFor(app: tempApp);

      final result = await tempAuth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      await result.user?.updateDisplayName(fullName);

      // ✅ SEND EMAIL VERIFICATION
      await result.user?.sendEmailVerification();

      return result;
    } on FirebaseAuthException {
      rethrow;
    } finally {
      if (tempApp != null) {
        await tempApp.delete();
      }
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
