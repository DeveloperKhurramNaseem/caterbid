// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = "https://api.cater-bid.com";

//   Future<Map<String, dynamic>> postRequest(String endpoint, Map<String, dynamic> body) async {
//     final url = Uri.parse('$baseUrl$endpoint');

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(body),
//     );

//     final responseData = jsonDecode(response.body);

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return responseData;
//     } else {
//       throw Exception(responseData['message'] ?? 'Something went wrong');
//     }
//   }
// }