class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}

class Member {
  final String name;
  final String id;
  final String status;
  final String? loginTime;
  final String? logoutTime;
  final String avatarUrl;
  final Location location;

  Member({
    required this.name,
    required this.id,
    required this.status,
    this.loginTime,
    this.logoutTime,
    required this.avatarUrl,
    required this.location,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
      loginTime: json['login_time'] as String?,
      logoutTime: json['logout_time'] as String?,
      avatarUrl: json['avatar_url'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );
  }
}

