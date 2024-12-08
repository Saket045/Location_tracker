import 'package:flutter/material.dart';
import 'drawer_item.dart';
import '../screens/attendance_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF5E42A6),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: Colors.purple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.purple, size: 40),
                ),
                const SizedBox(height: 10),
                Text(
                  'Cameron Williamson',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'cameronwilliamson@gmail.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DrawerItem(
                  icon: Icons.timer,
                  title: 'Timer',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Timer Selected')),
                    );
                  },
                ),
                DrawerItem(
                  icon: Icons.check_circle_outline,
                  title: 'Attendance',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendancePage()),
                    );
                  },
                ),
                DrawerItem(icon: Icons.trending_up, title: 'Activity'),
                DrawerItem(icon: Icons.access_time_filled, title: 'Timesheet'),
                DrawerItem(icon: Icons.bar_chart, title: 'Report'),
                DrawerItem(icon: Icons.place, title: 'Jobsite'),
                DrawerItem(icon: Icons.group, title: 'Team'),
                DrawerItem(icon: Icons.beach_access, title: 'Time Off'),
                DrawerItem(icon: Icons.schedule, title: 'Schedules'),
                DrawerItem(icon: Icons.person_add, title: 'Request to Join Organization'),
                DrawerItem(icon: Icons.lock, title: 'Change Password'),
                DrawerItem(icon: Icons.logout, title: 'Logout'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
