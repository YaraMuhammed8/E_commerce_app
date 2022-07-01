class ChangeCartResponse {
  ChangeCartResponse({
    required this.status,
    required this.message,
  });
  late final bool status;
  late final String message;

  ChangeCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}