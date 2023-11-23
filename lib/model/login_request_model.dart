class LoginRequest {
  String name;
  String password;

  LoginRequest({
    required this.name,
    required this.password,
  });

  Map<String,dynamic> toJson(){
    return {
      'username':name,
      'password':password
    };
  }

}