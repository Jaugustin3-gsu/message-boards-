import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  // Hardcoded list of message boards
  final List<MessageBoard> messageBoards = [
    MessageBoard(name: 'Technology', icon: Icons.computer),
    MessageBoard(name: 'Sports', icon: Icons.sports),
    MessageBoard(name: 'Entertainment', icon: Icons.movie),
    MessageBoard(name: 'Science', icon: Icons.science),
    MessageBoard(name: 'Health', icon: Icons.health_and_safety),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Message Boards'),
      ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Message Boards'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Already on Home, so no navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user?.email}!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Select a Message Board:',
              style: TextStyle(fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messageBoards.length,
                itemBuilder: (context, index) {
                  final board = messageBoards[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(board.icon, size: 40, color: Colors.blue),
                      title: Text(
                        board.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(boardName: board.name),
                            )
                          );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MessageBoard model
class MessageBoard {
  final String name;
  final IconData icon;

  MessageBoard({required this.name, required this.icon});
}
