// home_page.dart

import 'package:flutter/material.dart';
import 'package:sqllight/user.dart';
import 'user_input_fields.dart';
import 'database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    DatabaseHelper.initDatabase();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final loadedUsers = await DatabaseHelper.getUsers();
    setState(() {
      users = loadedUsers;
    });
  }

  void _addUser() async {
    final name = nameController.text;
    final age = int.tryParse(ageController.text) ?? 0;

    final newUser = User(id: users.length + 1, name: name, age: age);
    users.add(newUser);

    await DatabaseHelper.insertUser(newUser);

    _clearTextFields();
    setState(() {});
  }

  void _deleteUser(int id) async {
    await DatabaseHelper.deleteUser(id);
    setState(() {
      users.removeWhere((user) => user.id == id);
    });
  }

  void _clearTextFields() {
    nameController.clear();
    ageController.clear();
  }

  void _saveUser() {
    // Logic for saving user (if different from adding user)
    // You can customize this based on your requirements
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserInputFields(
              nameController: nameController,
              ageController: ageController,
              onAddUser: _addUser,
              onSaveUser: _saveUser, // Pass the onSaveUser callback
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text('${user.name}, ${user.age}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteUser(user.id),
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
