class AppUser {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;

  AppUser({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
  });

  factory AppUser.fromSupabaseUser(Map<String, dynamic> user) {
    return AppUser(
      id: user['id'],
      email: user['email'],
      name: user['user_metadata']?['name'],
      avatarUrl: user['user_metadata']?['avatar_url'],
    );
  }
}
