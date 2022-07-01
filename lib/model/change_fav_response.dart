class ChangeFavProductResponse {
  ChangeFavProductResponse({
    required this.status,
    required this.message,
  });
  late final bool status;
  late final String message;

  ChangeFavProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}