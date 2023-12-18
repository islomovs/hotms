import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/contants.dart';
import '../widgets/list_headings_widget.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/status_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/application_status_widget.dart';
import './hospital_patient_screen.dart';
import '../providers/patient.dart';

class PatientHomeScreen extends StatelessWidget {
  static const routeName = '/patient-home-screen';
  PatientHomeScreen({super.key});

  bool? operationDate = true;
  bool? operationTime = true;
  bool? doctorsName = true;

  @override
  Widget build(BuildContext context) {
    var operations = Provider.of<Patients>(context).fetchOperations();
    var patientInfo = Provider.of<Patients>(context).fetchPatientInfo();
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesPatient,
            sideBarListIcons: sideBarListIconsPatient,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesPatient,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Hi Nigina Roziya!',
                      subtitle: 'Monitor and adjust your progress',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusWidget(
                          title: 'Your operation date: 32.13.2023',
                          appStatusWidget: ApplicationStatusWidget(
                            status: operationDate!,
                          ),
                          status: operationDate!,
                        ),
                        StatusWidget(
                          title: 'Your operation time: 14:00',
                          appStatusWidget: ApplicationStatusWidget(
                            status: operationTime!,
                          ),
                          status: operationTime!,
                        ),
                        StatusWidget(
                          title: 'Your doctor: Full name',
                          appStatusWidget: ApplicationStatusWidget(
                            status: doctorsName!,
                          ),
                          status: doctorsName!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ListHeadingsWidget(
                      column3: Container(
                        alignment: Alignment.topLeft,
                        width: (MediaQuery.of(context).size.width - 720) / 4,
                        child: Text(
                          'Address',
                          style: listTitleTextStyle,
                        ),
                      ),
                      column4: Container(
                        alignment: Alignment.topLeft,
                        width: (MediaQuery.of(context).size.width - 720) / 4,
                        child: Text(
                          'Date of operation',
                          style: listTitleTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return PatientsListTile(
                            name: 'Saidova Saida',
                            subtitle: '21',
                            diagnosisTitle: 'Cancer',
                            diagnosisSubtitle: 'per annum',
                            hospitalName: 'CareMed Clinic',
                            city: 'Tashkent',
                            date: '21 / 10 / 2024',
                            subDate: 'Something...',
                            urgencyRate: 'Emergency',
                            navigateFunc: () {
                              Navigator.of(context)
                                  .pushNamed(HospitalPatientScreen.routeName);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
