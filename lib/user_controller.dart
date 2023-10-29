import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var selectedUser = User(id: 0, name: '', email: '');

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        userList.assignAll(data.map<User>((json) => User.fromJson(json)));
      }
    } catch (error) {
      print('Failed to fetch data: $error');
    }
  }

  Future<void> addUser(String name, String email, String firstName, String lastName) async {
    try {
      if (name.isEmpty) {
        print('Name and email are required.');
        return;
      }

      final response = await http.post(
        Uri.parse('https://reqres.in/api/users'),
        body: {
          'name': name,
          'email': email,
          'first_name': firstName, 
          'last_name': lastName,   
        },
      );

      if (response.statusCode == 201) {
        final userData = json.decode(response.body);
        final newUserId = int.parse(userData['id']);

        if (userList.any((user) => user.id == newUserId)) {
          print('User with ID $newUserId already exists in the list.');
        } else {
          final newUser = User(
            id: newUserId,
            name: userData['name'],
            email: userData['email'],
            firstName: firstName,
            lastName: lastName,
            createdAt: DateTime.now(),
          );
          userList.add(newUser);
          nameController.clear();
          emailController.clear();
          Get.back();
        }
      } else {
        print('Failed to add user. Unexpected response status: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to add user: $error');
    }
  }

  Future<void> updateUser(int id, String name, String email, String firstName, String lastName) async {
    try {
      final response = await http.put(
        Uri.parse('https://reqres.in/api/users/$id'),
        body: {
          'name': name,
          'email': email,
          'first_name': firstName, 
          'last_name': lastName,   
        },
      );

      if (response.statusCode == 200) {
        final updatedUserIndex = userList.indexWhere((user) => user.id == id);
        if (updatedUserIndex != -1) {
          final originalUser = userList[updatedUserIndex];

          userList[updatedUserIndex] = User(
            id: id,
            name: name,
            email: email,
            firstName: firstName,
            lastName: lastName,
            avatar: originalUser.avatar,
          );

          userList[updatedUserIndex].updatedAt = DateTime.now();
          Get.back();
        } else {
          print('Failed to update user. User not found in the list.');
        }
      } else if (response.statusCode == 404) {
        print('User not found (404): Please check the user ID.');
      } else {
        print('Failed to update user. Unexpected response status: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to update user: $error');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('https://reqres.in/api/users/$id'),
      );

      if (response.statusCode == 204) {
        userList.removeWhere((user) => user.id == id);
      } else if (response.statusCode == 404) {
        print('User not found (404): Please check the user ID.');
      } else {
        print('Failed to delete user. Unexpected response status: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to delete user: $error');
    }
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? firstName; 
  final String? lastName;  
  final String? avatar;    
  DateTime? updatedAt;
  DateTime? createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.updatedAt,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['first_name'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
}