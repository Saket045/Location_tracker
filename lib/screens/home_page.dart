import 'package:flutter/material.dart';
import '../widgets/navigation_drawer.dart';
import 'attendance_page.dart';

class HomePage extends StatelessWidget {
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
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
