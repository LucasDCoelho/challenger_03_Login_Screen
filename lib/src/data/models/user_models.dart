class UserModel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  UserModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory UserModel.fromMap(Map<String, String> map){
    return UserModel(
      username: map['username']!, 
      email: map['email']!, 
      firstName: map['firstName']!, 
      lastName: map['lastName']!, 
      gender: map['gender']!, 
      image: map['image']!,
    );
  }
}
