class AppUser {
  final String userId;
  final String userName;
  final String userUrl;
  final String userMail;

  AppUser({this.userId, this.userName, this.userUrl, this.userMail});

  factory AppUser.fromMap(Map<String, dynamic> userData) {
    return AppUser(
      userId: userData["userId"],
      userName: userData["userName"],
      userMail: userData["userMail"],
      userUrl: userData["userUrl"],
    );
  }
}
