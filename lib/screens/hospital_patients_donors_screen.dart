import 'package:flutter/material.dart';
import 'package:myapp/providers/hospitals.dart';
import 'package:provider/provider.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/list_headings_widget.dart';
import './hospital_patient_screen.dart';

class HospitalPatientsDonorsScreen extends StatefulWidget {
  static const routeName = '/hospital-patient-donor-screen';

  const HospitalPatientsDonorsScreen({super.key});

  @override
  State<HospitalPatientsDonorsScreen> createState() =>
      _HospitalOperationsScreenState();
}

class _HospitalOperationsScreenState
    extends State<HospitalPatientsDonorsScreen> {


  @override
  void initState() {
    print("all operation -1");
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    print("all operation1");
    await Provider.of<Hospitals>(context).fetchAllOperations();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("all operation");
    final rxAllOperations = Provider.of<Hospitals>(context).allOperations;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya patient/donor',
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
                    const OperationsListHeadingsWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: rxAllOperations.length,
                        itemBuilder: (context, index) {
                          return PatientsListTile(
                            name: rxAllOperations[index]
                                    .patientId
                                    ?.userId
                                    ?.fullName ??
                                rxAllOperations[index]
                                    .donorId
                                    ?.userId
                                    ?.fullName ??
                                "",
                            subtitle: rxAllOperations[index]
                                    .patientId
                                    ?.userId
                                    ?.email ??
                                rxAllOperations[index].donorId?.userId?.email ??
                                "",
                            diagnosisTitle:
                                rxAllOperations[index].organId?.name ?? "",
                            diagnosisSubtitle: '',
                            hospitalName:
                                rxAllOperations[index].hospitalId?.name ?? '',
                            city: 'Toshkent',
                            date: rxAllOperations[index].operationTime ?? '',
                            subDate: '',
                            urgencyRate: rxAllOperations[index]
                                    .patientId
                                    ?.urgencyRate
                                    .toString() ??
                                "",
                            navigateFunc: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HospitalPatientScreen(
                                      id: rxAllOperations[index]
                                              .hospitalId
                                              ?.id
                                              .toString() ??
                                          '0',
                                    ),
                                  ));
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
