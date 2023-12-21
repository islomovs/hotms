import 'package:flutter/material.dart';
import 'package:myapp/providers/hospitals.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/list_headings_widget.dart';
import './hospital_patient_screen.dart';

class HospitalOperationsScreen extends StatefulWidget {
  static const routeName = '/hospital-operations-screen';
  const HospitalOperationsScreen({super.key});

  @override
  State<HospitalOperationsScreen> createState() =>
      _HospitalOperationsScreenState();
}

class _HospitalOperationsScreenState extends State<HospitalOperationsScreen> {
  bool _isFetched = false;
  @override
  void didChangeDependencies() {
    if (!_isFetched) {
      Provider.of<Hospitals>(context).fetchAllOperations();
      _isFetched = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var operations = Provider.of<Hospitals>(context).allOperations;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya operation',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesHospital,
            sideBarListIcons: sideBarListIconsHospital,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
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
                            name:
                                operations[index].donorId!.userId!.fullName! ??
                                    ' ',
                            subtitle:
                                operations[index].donorId!.birthday ?? ' ',
                            diagnosisTitle:
                                operations[index].patientId!.diagnosis! ?? ' ',
                            diagnosisSubtitle: ' ',
                            hospitalName:
                                operations[index].hospitalId!.name! ?? ' ',
                            city: operations[index].donorId!.city! ?? ' ',
                            date: operations[index].operationTime! ?? ' ',
                            subDate: ' ',
                            status: operations[index]
                                    .patientId!
                                    .urgencyRate
                                    .toString() ??
                                ' ',
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
