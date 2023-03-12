import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    User user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投票アプリ'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ようこそ、${_user.displayName}さん！',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'あなたが選択した項目は、',
            ),
            Text(
              _selectedOptionIndex != null
                  ? '$_selectedOptionIndex 番目の項目です。'
                  : 'まだ選択されていません。',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '投票してください。',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleOptionSelect(0),
              child: Text('項目 1'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _handleOptionSelect(1),
              child: Text('項目 2'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _handleOptionSelect(2),
              child: Text('項目 3'),
            ),
          ],
        ),
      ),
    );
  }
}

