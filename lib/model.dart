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

