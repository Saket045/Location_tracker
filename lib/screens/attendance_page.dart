import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/member.dart';
import '../screens/page1.dart';
import '../screens/page2.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late Future<List<Member>> _membersFuture;

  @override
  void initState() {
    super.initState();
    _membersFuture = _loadMembers();
  }

  Future<List<Member>> _loadMembers() async {
    String jsonString = await rootBundle.loadString('assets/members.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Member.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size information
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C3DC2),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'ATTENDANCE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // All Members Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, 
              vertical: screenWidth * 0.03
            ),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(
                  Icons.group_outlined,
                  color: Color(0xFF5C3DC2),
                  size: 24,
                ),
                SizedBox(width: screenWidth * 0.02),
                const Text(
                  'All Members',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1F36),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      color: Color(0xFF5C3DC2),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Date Selector
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {},
                ),
                const Text(
                  'Tue, Aug 31 2022',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1A1F36),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Member List
          Expanded(
            child: FutureBuilder<List<Member>>(
              future: _membersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No members found'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final Member member = snapshot.data![index];
                    return _buildMemberTile(member, screenWidth);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberTile(Member member, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: screenWidth * 0.08,
            backgroundImage: NetworkImage(member.avatarUrl),
          ),
          SizedBox(width: screenWidth * 0.03),
          // Member Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1F36),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (member.loginTime != null) ...[
                      Transform.rotate(
                        angle: -0.785398, // 45 degrees
                        child: Icon(Icons.arrow_upward,
                            size: screenWidth * 0.04, color: Colors.green[400]),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        member.loginTime!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                    if (member.logoutTime != null) ...[
                      const SizedBox(width: 16),
                      Transform.rotate(
                        angle: -0.785398, // 45 degrees
                        child: Icon(Icons.arrow_downward,
                            size: screenWidth * 0.04, color: Colors.red[400]),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        member.logoutTime!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                    if (member.status == "WORKING") ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'WORKING',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    if (member.status == "NOT LOGGED IN YET") ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'NOT LOGGED-IN YET',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Right Icons
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoogleMapScreen(member: member)),
                  );
                },
                color: const Color(0xFF5C3DC2),
              ),
              IconButton(
                icon: const Icon(Icons.location_on_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page2()),
                  );
                },
                color: const Color(0xFF5C3DC2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
