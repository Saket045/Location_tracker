class Member {
  final String name;
  final String id;
  final String status;
  final String loginTime;
  final String logoutTime;
  final String avatarUrl;

  Member({
    required this.name,
    required this.id,
    required this.status,
    required this.loginTime,
    required this.logoutTime,
    required this.avatarUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      id: json['id'],
      status: json['status'],
      loginTime: json['login_time'],
      logoutTime: json['logout_time'],
      avatarUrl: json['avatar_url'],
    );
  }
}
