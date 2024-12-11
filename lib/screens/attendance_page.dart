import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location_tracker/screens/showMap.dart';
import '../models/member.dart';
import '../widgets/member_tile.dart';
import 'all_members_page.dart'; 
class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late Future<List<Member>> members;

  @override
  void initState() {
    super.initState();
    members = fetchMembers();
  }

  Future<List<Member>> fetchMembers() async {
    final String response = await DefaultAssetBundle.of(context).loadString('../assets/members.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Member.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllMembersPage()),
                );
              },
              child: Text("All Members"),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Member>>(
              future: members,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading members'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No members found'));
                }

                final List<Member> members = snapshot.data!;
                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final Member member = members[index];
                    return MemberTile(member: member);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembersMapPage()),
                );
              },
              child: Text("Show Map View"),
            ),
          ),
        ],
      ),
    );
  }
}
