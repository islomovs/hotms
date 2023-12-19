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

class PatientHomeScreen extends StatefulWidget {
  static const routeName = '/patient-home-screen';

  PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  bool? operationDate = true;

  bool? operationTime = true;

  bool? doctorsName = true;

  @override
  void didChangeDependencies() {
    Provider.of<Patients>(context).fetchPatientInfo();
    Provider.of<Patients>(context).fetchOperations();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var operations = Provider.of<Patients>(context).patientO;
    var patientInfo = Provider.of<Patients>(context).patientInfo;
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
                          title:
                              'Your operation date: ${(operations.operationTime ?? '').split(' ')[0].split('-')[2]}.${(operations.operationTime ?? '').split(' ')[0].split('-')[1]}.${(operations.operationTime ?? '').split(' ')[0].split('-')[0]}',
                          appStatusWidget: ApplicationStatusWidget(
                            status: operationDate!,
                          ),
                          status: operationDate!,
                        ),
                        StatusWidget(
                          title: 'Your operation time: ${(operations.operationTime ?? '').split(' ')[1]}',
                          appStatusWidget: ApplicationStatusWidget(
                            status: operationTime!,
                          ),
                          status: operationTime!,
                        ),
                        StatusWidget(
                          title: 'Your doctor: ${operations.doctorName ?? 'N/A'}',
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
