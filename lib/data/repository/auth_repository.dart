import '../../core/services/auth_service.dart';
import '../models/app_user.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  AppUser? getCurrentUser() {
    final user = _authService.currentUser;
    if (user == null) return null;
    return AppUser.fromSupabaseUser(user.toJson());
  }

  Future<void> signUp(String email, String password) async {
    final response =
    await _authService.signUp(email: email, password: password);

    if (response.user == null) {
      throw Exception('Sign up failed');
    }
  }

  Future<void> login(String email, String password) async {
    final response =
    await _authService.signIn(email: email, password: password);

    if (response.user == null) {
      throw Exception('Login failed');
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  Future<void> updateProfile({
    String? name,
    String? avatarUrl,
  }) async {
    await _authService.updateProfile(
      name: name,
      avatarUrl: avatarUrl,
    );
  }
}
