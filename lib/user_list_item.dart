// user_list_item.dart

import 'package:flutter/material.dart';
import 'user.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final void Function(int) onDeleteUser;

  const UserListItem({
    Key? key,
    required this.user,
    required this.onDeleteUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${user.name}, ${user.age}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          onDeleteUser(user.id);
        },
      ),
    );
  }
}
