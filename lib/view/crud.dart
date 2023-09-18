import 'package:flutter/material.dart';
import 'package:abseni/view/home.dart';

void main() {
  runApp(MyApp());
}

class Student {
  final String name;
  final String teacher;
  final String studentNumber;
  final String className;

  Student({
    required this.name,
    required this.teacher,
    required this.studentNumber,
    required this.className,
  });

  // Mengonversi objek Student menjadi Map JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'teacher': teacher,
      'studentNumber': studentNumber,
      'className': className,
    };
  }

  // Mengonversi Map JSON menjadi objek Student
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      teacher: json['teacher'],
      studentNumber: json['studentNumber'],
      className: json['className'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CrudApp(),
    );
  }
}

class CrudApp extends StatefulWidget {
  @override
  _CrudAppState createState() => _CrudAppState();
}

class _CrudAppState extends State<CrudApp> {
  final List<Student> students = [];

  final TextEditingController nameController =
      TextEditingController(text: 'ammar');
  final TextEditingController teacherController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController classNameController = TextEditingController();

  void addStudent() {
    final name = nameController.text;
    final teacher = teacherController.text;
    final studentNumber = studentNumberController.text;
    final className = classNameController.text;

    if (name.isNotEmpty &&
        teacher.isNotEmpty &&
        studentNumber.isNotEmpty &&
        className.isNotEmpty) {
      setState(() {
        students.add(Student(
          name: name,
          teacher: teacher,
          studentNumber: studentNumber,
          className: className,
        ));

        // Mengosongkan input fields setelah simpan
        nameController.clear();
        teacherController.clear();
        studentNumberController.clear();
        classNameController.clear();
      });

      // Mengembalikan data siswa ke halaman sebelumnya (HomeView)
      Navigator.of(context).pop(students);
    }
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Siswa'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: teacherController,
              decoration: InputDecoration(labelText: 'Guru Pengajar'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: studentNumberController,
              decoration: InputDecoration(labelText: 'No Absen'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: classNameController,
              decoration: InputDecoration(labelText: 'Kelas'),
            ),
          ),
          ElevatedButton(
            onPressed: addStudent,
            child: Text('Simpan'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(
                      'Guru: ${student.teacher}, No Absen: ${student.studentNumber}, Kelas: ${student.className}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteStudent(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
