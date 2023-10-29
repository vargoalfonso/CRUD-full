import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class UserDetailScreen extends StatelessWidget {
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    final User user = userController.selectedUser;
    final bool isExistingUser = user.createdAt != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ID: ${user.id}'),
            if (isExistingUser) Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            if (!isExistingUser) Text('First Name: ${user.firstName ?? "N/A"}'),
            if (!isExistingUser) Text('Last Name: ${user.lastName ?? "N/A"}'),
            if (user.avatar != null) Text('Avatar: ${user.avatar}'),
            if (user.updatedAt != null)
              Text('Updated At: ${user.updatedAt!.toLocal()}'),
            if (user.createdAt != null)
              Text('Created At: ${user.createdAt!.toLocal()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}