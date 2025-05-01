// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
//
// class ApiServices {
//   final box = GetStorage();
//   final String payslipApi = "https://esstest.mscorpres.net/payslip?period=2024-12";
//   Future<Payslip> fetchPayslipData() async {
//     String? token = box.read('token');
//     if (token == null || token.isEmpty) {
//       throw Exception('Token not found. Please log in first.');
//     }
//     final response = await http.get(Uri.parse(payslipApi),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       return Payslip.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load payslip data');
//     }
//   }
//
//   Future<BirthdayBashModel?> fetchBirthdayData() async {
//     try {
//       String? token = box.read('token');
//       if (token == null || token.isEmpty) {
//         throw Exception('Token not found. Please log in first.');
//       }
//       final response = await http.get(
//         Uri.parse(birthdayBashApi),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       debugPrint('BirthdayResponse : ${response.body}');
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return BirthdayBashModel.fromJson(data);
//       } else {
//         throw Exception('Failed to load birthday data');
//       }
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//       return null;
//     }
//   }
//
//   Future<NewHireListModel?> fetchNewHireListData() async {
//     try {
//       String? token = box.read('token');
//       if (token == null || token.isEmpty) {
//         throw Exception('Token not found. Please log in first.');
//       }
//       final response = await http.get(
//         Uri.parse(newHireListApi),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       debugPrint('New Hire List Response : ${response.body}');
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return NewHireListModel.fromJson(data);
//       } else {
//         throw Exception('Failed to load New Hire List data');
//       }
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//       return null;
//     }
//   }
//
//   Future<WorkAnniversaryModel?> fetchWAData() async {
//     try {
//       String? token = box.read('token');
//       if (token == null || token.isEmpty) {
//         throw Exception('Token not found. Please log in first.');
//       }
//       final response = await http.get(
//         Uri.parse(workAnnApi),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );
//       debugPrint('Work Anniversary Response : ${response.body}');
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return WorkAnniversaryModel.fromJson(data);
//       } else {
//         throw Exception('Failed to load New Hire List data');
//       }
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//       return null;
//     }
//   }
//
//
//   //  Punch In Api
//
//   Future<AttendanceResponse> fetchAttendanceData(String startDate, String endDate) async {
//     String? token = box.read('token');
//     if (token == null || token.isEmpty) {
//       throw Exception('Token not found. Please log in first.');
//     }
//     final response = await http.post(
//       Uri.parse('$apiUrlPunch?start=$startDate&end=$endDate'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     debugPrint('API Response: ${response.body}');
//
//     if (response.statusCode == 200) {
//       return AttendanceResponse.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load attendance data');
//     }
//   }
//
//
// }
//
