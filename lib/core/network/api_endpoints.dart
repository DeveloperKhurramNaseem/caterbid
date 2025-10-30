class ApiEndpoints {
  static const String baseUrl = "https://api.cater-bid.com/api";
  static const String serverUrl = 'https://api.cater-bid.com';

  // Auth
  static const String signUp = "$baseUrl/auth/signup";
  static const String verifyOtp = "$baseUrl/auth/verify";
  static const String login = "$baseUrl/auth/login";

  // Forget Password
  static const String forgotPassword = "$baseUrl/auth/forgot-password";
  static const String verifyResetOtp = "$baseUrl/auth/verify-reset-otp";
  static const String changePasswordRequest = "$baseUrl/auth/set-new-password";

  //Settings
  static const String settingsChangePassword = "$baseUrl/requestee/change-password";


  // Producer(Requestee)
  static const String createCateringRequest = "$baseUrl/requestee/requests";
  static const String getMyRequests = "$baseUrl/requestee/my-requests";
  static String getActiveRequestBids(String requestId) =>
      "$baseUrl/requestee/my-requests/$requestId/bids";
  static const String getRequesteeProfile = "$baseUrl/requestee/profile-details";
  static const String updateRequesteeProfileDetails = "$baseUrl/requestee/profile";
  static const String requesteeChangePassword = "$baseUrl/requestee/change-password";


  



  //Provider
  static const String bussinessProfileSetup = "$baseUrl/provider/profile";
  static const String providerRequests = "$baseUrl/provider/requests";
  static const String getMybids = "$baseUrl/provider/bids";

  static const String placeBid = "$baseUrl/provider/bids";
  static const String getProviderProfileDetails = "$baseUrl/provider/profile-details";
  static const String providerChangePassword = "$baseUrl/provider/change-password";



  
}
