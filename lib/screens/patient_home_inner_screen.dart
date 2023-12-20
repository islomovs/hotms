import 'package:flutter/material.dart';
import 'package:myapp/screens/patient_home_screen.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/patient.dart';
import '../widgets/list_headings_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/sidebar_template.dart';

class PatientHomeInnerScreen extends StatefulWidget {
  static const routeName = '/patient-home-inner-screen';
  final int? id;

  const PatientHomeInnerScreen({
    super.key,
    this.id,
  });

  @override
  State<PatientHomeInnerScreen> createState() => _PatientHomeInnerScreenState();
}

class _PatientHomeInnerScreenState extends State<PatientHomeInnerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Patients>(context).fetchPatientAppliedUser(widget.id ?? 0);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var applied = Provider.of<Patients>(context).patientAppliedUser;
    var patientInfo = Provider.of<Patients>(context).patientInfo.userId!;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: patientInfo.fullName! ?? 'Default Name',
            email: patientInfo.email! ?? 'default@email.com',
            sideBarTitles: sideBarTitlesPatient,
            sideBarListIcons: sideBarListIconsPatient,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesPatient,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: applied.length,
                      itemBuilder: (_, index) {
                        return PatientsListTile(
                          name: applied[index].patientId?.userId?.fullName ??
                              'N/A',
                          subtitle: 'N/A',
                          diagnosisTitle: 'Cancer',
                          diagnosisSubtitle: 'per annum',
                          hospitalName: 'CareMed Clinic',
                          city: 'Tashkent',
                          date: '21 / 10 / 2024',
                          subDate: 'Something...',
                          urgencyRate: 'Emergency',
                          navigateFunc: () {},
                        );
                      },
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
