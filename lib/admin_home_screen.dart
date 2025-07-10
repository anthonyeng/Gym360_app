import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'full_screen_camera.dart'; // Make sure this file exists

class AdminHomeScreen extends StatefulWidget {
  final String adminUsername;

  const AdminHomeScreen({super.key, required this.adminUsername});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.group), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabContents = [
      _buildDashboardTab(),
      _buildUsersTab(),
      _buildSettingsTab(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _tabContents[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
            items: _navItems,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Welcome, Admin ${widget.adminUsername}",
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.admin_panel_settings, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _openCameraScreen,
        icon: Icon(Icons.camera_alt),
        label: Text("Open Camera"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildUsersTab() {
    return Center(
      child: Text(
        "Manage Users",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Center(
      child: Text(
        "Admin Settings",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  void _openCameraScreen() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenCamera(camera: firstCamera),
      ),
    );
  }
}
