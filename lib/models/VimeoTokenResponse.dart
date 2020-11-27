class VimeoTokenResponse {
  final String accessToken;
  final String scope;

  VimeoTokenResponse({this.accessToken, this.scope});

  factory VimeoTokenResponse.fromJson(Map<String, dynamic> json) {
    return VimeoTokenResponse(
      accessToken: json['access_token'],
      scope: json['scope'],
    );
  }
}
