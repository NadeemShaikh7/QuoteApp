import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // -----------------------------
  // Current Session & User
  // -----------------------------

  Session? get currentSession => _client.auth.currentSession;

  User? get currentUser => _client.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  // -----------------------------
  // Auth State Stream
  // -----------------------------

  /// Emits auth events like:
  /// SIGNED_IN, SIGNED_OUT, TOKEN_REFRESHED
  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

  // -----------------------------
  // Authentication
  // -----------------------------

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // -----------------------------
  // Password Reset
  // -----------------------------

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
    );
  }

  // -----------------------------
  // User Profile Update
  // -----------------------------

  Future<UserResponse> updateProfile({
    String? name,
    String? avatarUrl,
  }) async {
    return await _client.auth.updateUser(
      UserAttributes(
        data: {
          if (name != null) 'name': name,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
        },
      ),
    );
  }

  // -----------------------------
  // Utility
  // -----------------------------

  /// Converts Supabase user to Map safely
  Map<String, dynamic>? getCurrentUserAsJson() {
    final user = currentUser;
    if (user == null) return null;
    return user.toJson();
  }
}
