import 'package:flutter/material.dart';
import 'package:abseni/view/login_view.dart'; // Pastikan mengimpor login_view.dart atau sesuaikan dengan path yang benar

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginView(),
      ));
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green], // Sesuaikan warna latar belakang sesuai tema absensi
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo-sekolah.PNG',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
