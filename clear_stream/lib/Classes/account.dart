// ignore: file_names
class Account {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final bool isEmailVerified;
  final String password;
  String? employer; // Using "?" to make employer optional

  Account({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    required this.password,
    this.employer, // Make employer optional
  });
}
