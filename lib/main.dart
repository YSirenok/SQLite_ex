import 'package:flutter/material.dart';
import 'package:sqllight/database_helper.dart';

import 'package:sqllight/my_app.dart';
import 'package:sqllight/user.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());

    await DatabaseHelper.initDatabase();

    User user1 = User(id: 1, name: 'John Doe', age: 30);
    await DatabaseHelper.insertUser(user1);

    User user2 = User(id: 2, name: 'Jane Doe', age: 20);
    await DatabaseHelper.insertUser(user2);

    List<User> users = await DatabaseHelper.getUsers();
    for (var user in users) {
      debugPrint('User: $user');
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
}
