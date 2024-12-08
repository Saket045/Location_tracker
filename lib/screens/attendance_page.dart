import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/member.dart';
import '../widgets/member_tile.dart';

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
    final String response = await DefaultAssetBundle.of(context).loadString('../../assets/members.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Member.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today))],
      ),
      body: FutureBuilder<List<Member>>(
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
    );
  }
}
