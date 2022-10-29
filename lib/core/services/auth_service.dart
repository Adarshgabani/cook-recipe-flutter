import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final User? _user = FirebaseAuth.instance.currentUser;
  static User? get currentUser => _user;
}
