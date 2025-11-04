class ApiEndpoints {
  static const String baseUrl = "https://api.cater-bid.com/api";
  static const String serverUrl = 'https://api.cater-bid.com';
  // static const String localHost = "http://localhost:5001";

  // Auth
  static const String signUp = "$baseUrl/auth/signup";
  static const String verifyOtp = "$baseUrl/auth/verify";
  static const String login = "$baseUrl/auth/login";
  static const String resentEmailOtp = "$baseUrl/auth/resend-otp";


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
  static const String requesteeDeleteAccount = "$baseUrl/requestee/me";
    static String acceptBidForRequest(String requestId, String bidId) =>
      "$baseUrl/requestee/my-requests/$requestId/bids/$bidId/accept";




  

  //Provider
  static const String bussinessProfileSetup = "$baseUrl/provider/profile";
  static const String providerRequests = "$baseUrl/provider/requests";
  static const String getMybids = "$baseUrl/provider/bids";

  static const String placeBid = "$baseUrl/provider/bids";
  static const String getProviderProfileDetails = "$baseUrl/provider/profile-details";
  static const String providerChangePassword = "$baseUrl/provider/change-password";
  static const String providerDeleteAccount = "$baseUrl/provider/me";
  static const String providerOnboarding = "$baseUrl/provider/connect/onboarding-link";
  static const String getAccountStatus = "$baseUrl/provider/connect/status";

  
}
