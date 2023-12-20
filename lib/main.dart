import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:myapp/data/HospitalOperation.dart';
import 'package:myapp/screens/patient_home_inner_screen.dart';
import 'package:provider/provider.dart';

import './providers/donor.dart';
import './providers/patient.dart' as patient;
import './providers/dispensary.dart';
import './providers/hospitals.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './screens/forgot_password_screen.dart';
import './screens/verification_code_screen.dart';
import './screens/reset_password_screen.dart';
import './screens/donor_home_screen.dart';
import './screens/donor_evaluation_screen.dart';
import './screens/donor_organ_info_screen.dart';
import './screens/donor_hospitals_screen.dart';
import './screens/dispensary_home_screen.dart';
import './screens/dispensary_donor_info_screen.dart';
import './screens/dispensary_patient_info_screen.dart';
import './screens/patient_home_screen.dart';
import './screens/patient_appointment_screen.dart';
import './screens/patient_info_screen.dart';
import './screens/patient_hospitals_screen.dart';
import './screens/hospital_patients_donors_screen.dart';
import './screens/hospital_operations_screen.dart';
import './screens/hospital_patient_screen.dart';
import './screens/hospital_donor_screen.dart';
import './screens/hospital_assign_operation_screen.dart';
import './screens/hospital_info_screen.dart';
import './screens/admin_patients_list_screen.dart';
import './screens/admin_donors_list_screen.dart';
import './screens/admin_dispenser_list_screen.dart';
import './screens/admin_add_dispenser_screen.dart';
import './screens/admin_hospitals_list_screen.dart';
import './screens/admin_organs_list_screen.dart';
import './screens/admin_add_patient_screen.dart';
import './screens/admin_add_hospital_screen.dart';
import './screens/admin_add_donor_screen.dart';
import './screens/admin_add_organ_screen.dart';
import './screens/admin_edit_dispenser_screen.dart';
import './screens/admin_edit_donor_screen.dart';
import './screens/admin_edit_hospital_screen.dart';
import './screens/admin_edit_organ_screen.dart';
import './screens/admin_edit_patient_screen.dart';
import './screens/admin_edit_region_screen.dart';
import './screens/admin_add_region_screen.dart';
import './screens/admin_regions_list_screen.dart';
import './screens/hospital_doctors_screen.dart';
import './screens/hospital_add_doctor_screen.dart';
import './screens/hospital_edit_doctor_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Donors(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => patient.Patients(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Hospitals(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DispensaryOperations(),
        ),
      ],
      child: MaterialApp(
        title: 'Donor Aid Login',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => const LoginScreen(),
          RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
          ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
          VerificationCodeScreen.routeName: (ctx) => VerificationCodeScreen(),
          ResetPasswordScreen.routeName: (ctx) => ResetPasswordScreen(),
          DonorHomeScreen.routeName: (ctx) => DonorHomeScreen(),
          DonorEvaluationScreen.routeName: (ctx) => DonorEvaluationScreen(),
          DonorOrganInfoScreen.routeName: (ctx) => DonorOrganInfoScreen(),
          DonorHospitalsScreen.routeName: (ctx) => DonorHospitalsScreen(),
          DispensaryHomeScreen.routeName: (ctx) => DispensaryHomeScreen(),
          DispensaryOrganInfoScreen.routeName: (ctx) =>
              DispensaryOrganInfoScreen(id: 0),
          DispenserPatientInfoScreen.routeName: (ctx) =>
              DispenserPatientInfoScreen(id: 0),
          PatientHomeScreen.routeName: (ctx) => PatientHomeScreen(),
          PatientAppointmentScreen.routeName: (ctx) =>
              PatientAppointmentScreen(),
          PatientInfoScreen.routeName: (ctx) => PatientInfoScreen(),
          PatientHospitalsScreen.routeName: (ctx) => PatientHospitalsScreen(),
          HospitalPatientsDonorsScreen.routeName: (ctx) =>
              HospitalPatientsDonorsScreen(),
          HospitalOperationsScreen.routeName: (ctx) =>
              HospitalOperationsScreen(),
          HospitalPatientScreen.routeName: (ctx) => HospitalPatientScreen(
                model: HospitalOperation(),
              ),
          HospitalDonorScreen.routeName: (ctx) => HospitalDonorScreen(),
          HospitalAssignOperationScreen.routeName: (ctx) =>
              HospitalAssignOperationScreen(),
          // HospitalOrgansScreen.routeName: (ctx) => HospitalOrgansScreen(),
          HospitalInfoScreen.routeName: (ctx) => HospitalInfoScreen(),
          AdminPatientsListScreen.routeName: (ctx) => AdminPatientsListScreen(),
          AdminDonorsListScreen.routeName: (ctx) => AdminDonorsListScreen(),
          AdminHospitalsListScreen.routeName: (ctx) =>
              AdminHospitalsListScreen(),
          AdminOrgansListScreen.routeName: (ctx) => AdminOrgansListScreen(),
          AdminAddPatientScreen.routeName: (ctx) => AdminAddPatientScreen(),
          AdminAddHospitalScreen.routeName: (ctx) => AdminAddHospitalScreen(),
          AdminAddDonorScreen.routeName: (ctx) => AdminAddDonorScreen(),
          AdminDispensersListScreen.routeName: (ctx) =>
              AdminDispensersListScreen(),
          AdminAddDispensersScreen.routeName: (ctx) =>
              AdminAddDispensersScreen(),
          AdminAddOrganScreen.routeName: (ctx) => AdminAddOrganScreen(),
          AdminEditHospitalScreen.routeName: (ctx) => AdminEditHospitalScreen(),
          AdminEditDonorScreen.routeName: (ctx) => AdminEditDonorScreen(),
          AdminEditDispenserScreen.routeName: (ctx) =>
              AdminEditDispenserScreen(),
          AdminEditOrganScreen.routeName: (ctx) => AdminEditOrganScreen(),
          AdminEditPatientScreen.routeName: (ctx) => AdminEditPatientScreen(),
          PatientHomeInnerScreen.routeName: (ctx) => PatientHomeInnerScreen(),
          HospitalDoctorsListScreen.routeName: (ctx) =>
              HospitalDoctorsListScreen(),
          HospitalAddDoctorScreen.routeName: (ctx) => HospitalAddDoctorScreen(),
          HospitalEditDoctorScreen.routeName: (ctx) =>
              HospitalEditDoctorScreen(),
          AdminRegionsListScreen.routeName: (ctx) => AdminRegionsListScreen(),
          AdminAddRegionScreen.routeName: (ctx) => AdminAddRegionScreen(),
          AdminEditRegionScreen.routeName: (ctx) => AdminEditRegionScreen(),
        },
      ),
    );
  }
}

// ignore: must_be_immutable
