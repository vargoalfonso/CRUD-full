import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class createuserscreen extends StatelessWidget {
  final UserController userController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User? user = Get.arguments;
    final isEditing = user != null;

    if (isEditing) {
      nameController.text = user.name;
      emailController.text = user.email;
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Update User' : 'Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            if (isEditing)
              Column(
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final email = emailController.text;
                final firstName = firstNameController.text;
                final lastName = lastNameController.text;
                if (name.isNotEmpty && email.isNotEmpty) {
                  if (isEditing) {
                    userController.updateUser(user.id, name, email, firstName, lastName);
                  } else {
                    userController.addUser(name, email, firstName, lastName);
                  }
                  Get.back();
                }
              },
              child: Text(isEditing ? 'Update User' : 'Add User'),
            ),
          ],
        ),
      ),
    );
  }
}