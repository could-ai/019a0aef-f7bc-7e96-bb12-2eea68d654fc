import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final bool isArabic;

  const LeaderboardScreen({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    // Mock leaderboard
    final leaders = [
      {'name': 'User1', 'score': 500},
      {'name': 'User2', 'score': 450},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(isArabic ? 'قائمة الصدارة' : 'Leaderboard')),
      body: ListView.builder(
        itemCount: leaders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(leaders[index]['name'] as String),
            trailing: Text('${leaders[index]['score']}'),
          );
        },
      ),
    );
  }
}