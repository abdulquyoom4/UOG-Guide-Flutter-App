import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream to listen to auth state changes
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password without auto-logging in the main app
  Future<UserCredential?> register(String email, String password, String fullName) async {
    FirebaseApp? tempApp;
    try {
      // Create a temporary Firebase app instance for registration
      tempApp = await Firebase.initializeApp(
        name: 'TempRegisterApp',
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FirebaseAuth tempAuth = FirebaseAuth.instanceFor(app: tempApp);
      
      UserCredential result = await tempAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      // Update display name
      await result.user?.updateDisplayName(fullName);
      
      return result;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      // Always delete the temporary app to clean up resources
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
