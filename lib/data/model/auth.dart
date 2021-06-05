class Auth {
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;
  String username;
  String name;
  String email;
  String image;

  Auth(
      {this.tokenType,
      this.expiresIn,
      this.accessToken,
      this.refreshToken,
      this.username,
      this.name,
      this.email,
      this.image});

  Auth.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    return data;
  }
}
