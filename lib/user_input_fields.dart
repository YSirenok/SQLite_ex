import 'package:flutter/material.dart';

class UserInputFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final VoidCallback onAddUser;
  final VoidCallback onSaveUser;

  const UserInputFields({
    Key? key,
    required this.nameController,
    required this.ageController,
    required this.onAddUser,
    required this.onSaveUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              hintText: 'Enter your age',
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                final int age = int.tryParse(ageController.text) ?? 0;

                if (name.isNotEmpty && age >= 0) {
                  onAddUser();
                } else {
                  // Show an error message or handle invalid input
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Input'),
                        content: Text('Please enter a valid name and age.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Add User'),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: onSaveUser,
              child: const Text('Save User'),
            ),
          ],
        ),
      ],
    );
  }
}
