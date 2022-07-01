class UserDataResponse {
  UserDataResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String? message;
  late UserData? data;

  UserDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json["data"] != null) ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });
  late final int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int? points;
  late int? credit;
  late final String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
