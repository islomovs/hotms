import 'package:flutter/material.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/list_headings_widget.dart';
import './hospital_patient_screen.dart';

class HospitalOperationsScreen extends StatelessWidget {
  static const routeName = '/hospital-operations-screen';
  const HospitalOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesHospital,
            sideBarListIcons: sideBarListIconsHospital,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesHospital,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Operations List',
                      subtitle:
                          'This list provides an overview of the diverse operations within a hospital.',
                    ),
                    const SizedBox(height: 20),
                    ListHeadingsWidget(
                      column3: Container(
                        alignment: Alignment.topLeft,
                        width: (MediaQuery.of(context).size.width - 720) / 4,
                        child: Text(
                          'Doctor',
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
                            name: 'Saidova Sayka',
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
