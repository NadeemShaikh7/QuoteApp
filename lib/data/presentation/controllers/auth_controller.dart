import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/app_user.dart';
import '../../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  final Rx<AppUser?> user = Rx<AppUser?>(null);
  final RxBool isLoading = false.obs;

  bool get isLoggedIn => user.value != null;

  @override
  void onInit() {
    _loadInitialUser();
    super.onInit();
  }

  void _loadInitialUser() {
    user.value = _repo.getCurrentUser();
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading(true);
      await _repo.signUp(email, password);
      Get.snackbar(
        "Info:",
        "Account created successfully",
        // duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading(false);
      await Future.delayed(Duration(seconds: 3));
      user.value = _repo.getCurrentUser();
      Get.offAllNamed('/login');
    } on AuthWeakPasswordException catch (e) {
      final errorMessage = e.message;
      isLoading(false);
      print(errorMessage);
      Get.snackbar('Error', e.message);
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
      isLoading(false);
    } catch (e) {
      Get.snackbar('Unexpected error:',e.toString());
      isLoading(false);
    }finally {
      isLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      await _repo.login(email, password);
      user.value = _repo.getCurrentUser();
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    user.value = null;
    Get.offAllNamed('/login');
  }

  Future<void> resetPassword(String email) async {
    await _repo.resetPassword(email);
    Get.snackbar(
      'Password Reset',
      'Check your email for reset instructions',
    );
  }

  Future<void> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {
    await _repo.updateProfile(
      name: name,
      avatarUrl: avatarUrl,
    );
    user.value = _repo.getCurrentUser();
  }
}
