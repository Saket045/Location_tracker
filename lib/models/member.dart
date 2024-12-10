class Member {
  final String name;
  final String id;
  final String status;
  final String loginTime;
  final String logoutTime;
  final String avatarUrl;
  final Location location;

  Member({
    required this.name,
    required this.id,
    required this.status,
    required this.loginTime,
    required this.logoutTime,
    required this.avatarUrl,
    required this.location,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      id: json['id'],
      status: json['status'],
      loginTime: json['login_time'],
      logoutTime: json['logout_time'],
      avatarUrl: json['avatar_url'],
      location: Location.fromJson(json['location']),
    );
  }
}

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
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
