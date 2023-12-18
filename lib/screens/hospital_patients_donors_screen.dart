import 'package:flutter/material.dart';

import './hospital_donor_screen.dart';
import './hospital_patient_screen.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/list_headings_widget.dart';
import './hospital_patient_screen.dart';

class HospitalPatientsDonorsScreen extends StatelessWidget {
  static const routeName = '/hospital-patients-donors-screen';
  const HospitalPatientsDonorsScreen({super.key});

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
            unselectedRoutes: [
              HospitalPatientScreen.routeName,
              HospitalDonorScreen.routeName,
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Patient/Donor List',
                      subtitle:
                          'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: listHeadingBgCOl,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Patients/Donors',
                                  style: listHeadingTitleTextStyle,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '(144)',
                                  style: listHeadingTitleTextStyle,
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.search),
                                Icon(Icons.analytics_outlined),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          'Date of application',
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
