import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../screens/donor_home_screen.dart';
import '../screens/donor_evaluation_screen.dart';
import '../screens/donor_organ_info_screen.dart';
import '../screens/donor_hospitals_screen.dart';
import '../screens/dispensary_home_screen.dart';
import '../screens/patient_home_screen.dart';
import '../screens/patient_appointment_screen.dart';
import '../screens/patient_info_screen.dart';
import '../screens/patient_hospitals_screen.dart';
import '../screens/hospital_patients_donors_screen.dart';
import '../screens/hospital_operations_screen.dart';
import '../screens/hospital_info_screen.dart';
import '../screens/admin_patients_list_screen.dart';
import '../screens/admin_donors_list_screen.dart';
import '../screens/admin_hospitals_list_screen.dart';
import '../screens/admin_organs_list_screen.dart';
import '../screens/admin_dispenser_list_screen.dart';
import '../screens/admin_regions_list_screen.dart';

// const token =
//     "eyJhbGciOiJIUzUxMiJ9.eyJpZCI6MywiZW1haWwiOiJkaXNwZW5zYXJ5QG1haWwucnUiLCJyb2xlIjoiRElTUEVOU0FSWSIsInVzZXIiOnsiaWQiOjMsImVtYWlsIjoiZGlzcGVuc2FyeUBtYWlsLnJ1IiwicGFzc3dvcmQiOiJkaXNwZW5zYXJ5Iiwicm9sZSI6IkRJU1BFTlNBUlkiLCJmdWxsTmFtZSI6IkRpc3BlbnNhcnkiLCJpbWFnZUxpbmsiOm51bGx9LCJleHAiOjE3MDM0OTc3OTl9.1Zc_3XO5a8LdGwfaigOdLZffrx0NlaLU90PzqMHQoDqBPMOvEYGZ2JOP_HNuN2FdxKzrnx8oNuDRNhKl7uJGKw";
// const hospitalToken =
//     "eyJhbGciOiJIUzUxMiJ9.eyJpZCI6NiwiZW1haWwiOiJhemlrb0BtYWlsLnJ1Iiwicm9sZSI6IkhPU1BJVEFMIiwidXNlciI6eyJpZCI6NiwiZW1haWwiOiJhemlrb0BtYWlsLnJ1IiwicGFzc3dvcmQiOiJhemlrbyIsInJvbGUiOiJIT1NQSVRBTCIsImZ1bGxOYW1lIjoiQXppa28iLCJpbWFnZUxpbmsiOm51bGx9LCJleHAiOjE3MDM0NTIzMzJ9.j7IAv4a5vQixkncIumNLB14Pc04Lwwx5pHxyYVSpn4debJeEAJJjTqjAm0M37MPWWKCKIccMFyzoI61hHvv8sA";
var ip = 'http://161.35.75.184:1234';
// var donorDefaultToken =
//     'eyJhbGciOiJIUzUxMiJ9.eyJpZCI6NCwiZW1haWwiOiJkb25vckBtYWlsLnJ1Iiwicm9sZSI6IkFQUFJPVkVEX0RPTk9SIiwidXNlciI6eyJpZCI6NCwiZW1haWwiOiJkb25vckBtYWlsLnJ1IiwicGFzc3dvcmQiOiJkb25vciIsInJvbGUiOiJBUFBST1ZFRF9ET05PUiIsImZ1bGxOYW1lIjoiRG9ub3IgRG9ub3JvdiIsImltYWdlTGluayI6bnVsbH0sImV4cCI6MTcwMzUxOTI2Nn0.El9l4cA-L-pVkwEmgZCH0RyGb9B35Uz8nYUiYW8B3HBMz0SjXC3AMvyoLcfAsbfJz0_fJc-ziUWvDjPfWA0pUQ';
String? extractedRole;
String? extractedToken;
String? localhost = '127.0.0.1';

var workingDirectory = '~/Desktop/myapp/lib/socket/';

final dio = Dio()
  ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));

var mainColor = const Color(0xFF235068);
var secondaryColor = const Color(0xFF9E9E9E);
var containerBgCol = const Color(0xFFDDF2FD);
var containerTxtCol = const Color(0xFF9E9E9E);
var blackCol = const Color(0xFF000000);
var patientListCol = const Color(0xFFADB1B5);
var statusIconCol = const Color(0xFF9BBEC8);
var listHeadingBgCOl = const Color(0xFFF3F6F9);

var listHeadingTitleTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: blackCol,
);

var listTitleTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: patientListCol,
);

var listTileTitle = TextStyle(
  fontSize: 14,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
  color: blackCol,
);

var listTileSubTitle = TextStyle(
  fontSize: 13,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
  color: patientListCol,
);

// constants for sidebar of donor screens
List<String> sideBarTitlesDonor = [
  'Home',
  'Donor Evaluation',
  'Organ Information',
  'Hospitals',
];
List<IconData> sideBarListIconsDonor = [
  Icons.home_outlined,
  Icons.event_available_outlined,
  Icons.library_books_outlined,
  Icons.local_hospital_sharp,
];
List<String> sideBarTitlesBottom = [
  'Support',
  'Settings',
];
List<IconData> sideBarListIconsBottom = [
  Icons.contact_support_outlined,
  Icons.settings_outlined,
];
List<String> routeNamesDonor = [
  DonorHomeScreen.routeName,
  DonorEvaluationScreen.routeName,
  DonorOrganInfoScreen.routeName,
  DonorHospitalsScreen.routeName,
];

// constants for sidebar of dispensary screens
List<String> sideBarTitlesDispensary = [
  'Home',
  'Patients',
  'Donors',
];
List<IconData> sideBarListIconsDispensary = [
  Icons.home_outlined,
  Icons.event_available_outlined,
  Icons.library_books_outlined,
];
List<String> routeNamesDispensary = [
  DispensaryHomeScreen.routeName,
  DispensaryHomeScreen.routeName,
  DispensaryHomeScreen.routeName,
];

// constants for sidebar of patient screens
List<String> sideBarTitlesPatient = [
  'Queue System',
  'Patient Info',
  'Hospitals',
  'Appointments',
];
List<IconData> sideBarListIconsPatient = [
  Icons.home_outlined,
  Icons.event_available_outlined,
  Icons.library_books_outlined,
  Icons.library_books_outlined,
];
List<String> routeNamesPatient = [
  PatientHomeScreen.routeName,
  PatientInfoScreen.routeName,
  PatientHospitalsScreen.routeName,
  PatientAppointmentScreen.routeName,
];

// constants for sidebar of patient screens
List<String> sideBarTitlesHospital = [
  'Setup profile',
  'Patients/Donors',
  'Operations',
];
List<IconData> sideBarListIconsHospital = [
  Icons.home_outlined,
  Icons.event_available_outlined,
  Icons.library_books_outlined,
];
List<String> routeNamesHospital = [
  HospitalInfoScreen.routeName,
  HospitalPatientsDonorsScreen.routeName,
  HospitalOperationsScreen.routeName,
];

// constants for sidebar of patient screens
List<String> sideBarTitlesAdmin = [
  'Patients',
  'Donors',
  'Hospitals',
  'Dispensaries',
  'Organs',
  'Regions',
];
List<IconData> sideBarListIconsAdmin = [
  Icons.home_outlined,
  Icons.event_available_outlined,
  Icons.library_books_outlined,
  Icons.library_books_outlined,
  Icons.library_books_outlined,
  Icons.library_books_outlined,
];
List<String> routeNamesAdmin = [
  AdminPatientsListScreen.routeName,
  AdminDonorsListScreen.routeName,
  AdminHospitalsListScreen.routeName,
  AdminDispensersListScreen.routeName,
  AdminOrgansListScreen.routeName,
  AdminRegionsListScreen.routeName,
];

var sideBarListTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w600,
  color: secondaryColor,
);

List<String> hospitalTitles = [
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
  'CareMed Clinic',
];
List<String> hospitalDescriptions = [
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
  'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
];
