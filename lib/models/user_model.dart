class UserModel {
  final String firstName;
  final String lastName;
  final String gender;
  final String mobile;
  final String email;
  final String country;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.mobile,
    required this.email,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'mobile': mobile,
      'email': email,
      'country': country,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      mobile: json['mobile'],
      email: json['email'],
      country: json['country'],
    );
  }
}
