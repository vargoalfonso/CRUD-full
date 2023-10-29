import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'create_user_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserController userController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final RxList<User> filteredUsers = <User>[].obs;

  void searchUsers(String query) {
    final userList = userController.userList;
    final filtered = userList.where((user) {
      final name = user.name.toLowerCase();
      final lowerCaseQuery = query.toLowerCase();
      return name.contains(lowerCaseQuery);
    }).toList();
    filteredUsers.assignAll(filtered);
  }

  void clearSearch() {
    searchController.clear();
    searchUsers('');
  }

  void deleteUser(User user) {
    userController.deleteUser(user.id);
    filteredUsers.remove(user);
  }

  void updateUser(User user) {
    Get.to(createuserscreen(), arguments: user);
  }

  void addUser() {
    Get.toNamed('/create');
  }

  @override
  Widget build(BuildContext context) {
    filteredUsers.assignAll(userController.userList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    searchUsers(query);
                  } else {
                    clearSearch();
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search User...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (filteredUsers.isEmpty) {
                  return const Center(child: Text('User Not Found'));
                }
                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return ListTile(
                      leading: user.avatar != null
                          ? Image.network(
                              user.avatar!,
                              width: 40,
                              height: 40,
                            )
                          : const SizedBox.shrink(),
                      title: Row(
                        children: [
                          Text(user.name),
                        ],
                      ),
                      subtitle: Text(user.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              updateUser(user);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteUser(user);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        userController.selectedUser = user;
                        Get.toNamed('/userDetail');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}