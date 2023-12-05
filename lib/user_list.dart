// user_list.dart

import 'package:flutter/material.dart';
import 'user.dart';
import 'user_list_item.dart';
import 'database_helper.dart';

class UserList extends StatelessWidget {
  final void Function(int) onDeleteUser;

  const UserList({Key? key, required this.onDeleteUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: DatabaseHelper.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<User>? users = snapshot.data;
          return ListView.builder(
            itemCount: users!.length,
            itemBuilder: (context, index) {
              return UserListItem(
                user: users[index],
                onDeleteUser: onDeleteUser,
              );
            },
          );
        }
      },
    );
  }
}
