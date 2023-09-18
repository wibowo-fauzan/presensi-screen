import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:abseni/view/profile.dart'; // Impor halaman profil
import 'package:abseni/view/crud.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  bool isAbsentInfoVisible = false;
  bool isButtonPressed = false;
  String status = 'Masuk';
  String statusText = 'Masuk';
  List<Student> students = [
    Student(
      name: 'Ammar',
      teacher: 'Bu Shinta',
      studentNumber: '2',
      className: 'XII PPLG 1',
    ),
    // Tambahkan data siswa lainnya sesuai kebutuhan
  ];

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final studentsData = prefs.getString('students');

    if (studentsData != null) {
      final List<dynamic> studentsList = jsonDecode(studentsData);
      setState(() {
        students.clear();
        students.addAll(
          studentsList.map((studentJson) => Student.fromJson(studentJson)),
        );
      });
    }
  }

  String getStatusBasedOnTime(DateTime now) {
    // Tambahkan logika untuk menentukan status berdasarkan waktu saat ini
    if (now.isBefore(DateTime(now.year, now.month, now.day, 7, 30))) {
      return 'Masuk';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 17, 50))) {
      return 'Pulang';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String tanggalPresensi = DateFormat('dd MMMM yyyy').format(now);
    String waktuSekarang = DateFormat('hh:mm:ss a').format(now);
    String jamMasukSekolah =
        DateFormat('hh:mm a').format(DateTime(now.year, now.month, now.day, 7, 30));
    String jamPulang = DateFormat('hh:mm a').format(DateTime(now.year, now.month, now.day, 17, 50));
    status = getStatusBasedOnTime(now); // Perbarui status berdasarkan waktu saat ini

    return Scaffold(
      appBar: AppBar(
      title: Text(
          'Ammar',
          style: TextStyle(
            color: Colors.white, // Mengatur warna teks menjadi putih
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            constraints: BoxConstraints(maxHeight: 220),
            child: Card(
              margin: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Informasi Presensi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$tanggalPresensi',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 5),
                      StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          now = DateTime.now();
                          waktuSekarang = DateFormat('hh:mm:ss a').format(now);
                          return Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$waktuSekarang',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isAbsentInfoVisible = !isAbsentInfoVisible;
                                statusText = isAbsentInfoVisible ? 'Masuk' : 'Izin';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            child: Text(
                              isAbsentInfoVisible ? 'Tutup Info' : 'Informasi Masuk Dan Pulang',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isAbsentInfoVisible,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Jam Masuk Sekolah: $jamMasukSekolah',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Jam Pulang Sekolah: $jamPulang',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 2560,
            child: Card(
              color: Colors.brown[200],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: students.map((student) {
                    return ListTile(
                      tileColor: Colors.brown[400],
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      ),
                      title: Text(
                        '${student.name}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guru: ${student.teacher}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            'No Absen: ${student.studentNumber}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            'Kelas: ${student.className}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            isButtonPressed ? status : '',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    status = status == 'Masuk' ? 'Keluar' : 'Masuk';
                                    isButtonPressed = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                child: Text(
                                  'Absen Masuk Dan Pulang',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          // Tambahkan logika ketika tombol info diklik
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Tambahkan currentIndex
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Ganti ikon menjadi Icons.person atau ikon lain yang sesuai
            label: 'Profile',
          ),
        ],
        onTap: (index) {
        if (index == 1) {
          // Pindah ke halaman profil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()), // Sesuaikan dengan lokasi halaman profil Anda
          );
        }
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CrudApp(),
            ),
          );

          if (result != null && result is List<Student>) {
            setState(() {
              students.clear();
              students.addAll(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
