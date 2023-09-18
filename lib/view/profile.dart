import 'package:flutter/material.dart';
import 'package:abseni/view/login_view.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                'images/ammar-bilek.jpg',
              ), 
            ),
            SizedBox(height: 20),
            Text(
              'Ammar Karim',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Siswa SMK Taruna Bhakti Depok, 2023',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginView()), // Ganti dengan halaman login Anda
              );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
