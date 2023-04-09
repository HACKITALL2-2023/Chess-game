class UserLogIn{
  late String token;
  late String? name;
  late String? imageUrl;
  late String? email;
  String gameId = '';
  bool player1 = true;

  UserLogIn(
    this.token,
    this.name,
    this.imageUrl,
    this.email
  );

}