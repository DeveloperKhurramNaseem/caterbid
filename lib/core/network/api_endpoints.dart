class ApiEndpoints {
  static const String baseUrl = "https://api.cater-bid.com/api";

  // Auth
  static const String signUp = "$baseUrl/auth/signup";
  static const String verifyOtp = "$baseUrl/auth/verify";
  static const String login = "$baseUrl/auth/login";

  // Forget Password
  static const String forgotPassword = "$baseUrl/auth/forgot-password";
  static const String verifyResetOtp = "$baseUrl/auth/verify-reset-otp";
  static const String changePasswordRequest = "$baseUrl/auth/set-new-password";



  // Producer
  static const String createCateringRequest = "$baseUrl/requestee/requests";
  static const String getMyRequests = "$baseUrl/requestee/my-requests";



}
