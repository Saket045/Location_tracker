import 'package:flutter/material.dart';
import 'attendance_page.dart';
import '../widgets/drawer_item.dart';
import '../screens/attendance_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Fixed Navigation Drawer
          NavigationDrawer(),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome to Workstatus!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(96, 125, 139, 1),
                      ),
                    ),
                  ),
                  // Example scrollable content
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20, // Simulating 20 items for content
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          child: ListTile(
                            title: Text('Item ${index + 1}'),
                            subtitle: Text('Details about item ${index + 1}'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(),
          Expanded(
            child: Center(
              child: Text(
                'Welcome to Workstatus!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(96, 125, 139, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Navigation Drawer - Positioned to the left
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: 250,
            child: Container(
              color: Colors.blueGrey.shade50,
              child: NavigationDrawer(),
            ),
          ),
          // Main Content Area - Positioned to fill the remaining space
          Positioned(
            top: 0,
            bottom: 0,
            left: 250,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to Workstatus!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(96, 125, 139, 1),
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Manage your work effortlessly with our tools.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color.fromRGBO(74, 59, 131, 1),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: const Color.fromARGB(255, 65, 46, 137),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'workstatus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369988.png'),
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