class UserDataModel {

  UserDataModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.bio,
  });

  late final String uId;
  late final String username;
  late final String email;
  late final String phone;
  late final String image;
  late final String bio;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    image = json['image'] ?? '';
    bio = json['bio'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'image': image,
      'bio' : bio,
    };
  }
}