import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/screens/patient_home_inner_screen.dart';
import 'package:provider/provider.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/status_widget.dart';
import '../widgets/application_status_widget.dart';
import '../providers/patient.dart';

class PatientHomeScreen extends StatefulWidget {
  static const routeName = '/patient-home-screen';

  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  bool? operationDate = true;

  bool? operationTime = true;

  bool? doctorsName = true;

  @override
  void didChangeDependencies() {
    Provider.of<Patients>(context)
      ..fetchOperations()
      ..fetchPatientApplied();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var operations = Provider.of<Patients>(context).patientO;
    var applied = Provider.of<Patients>(context).patientApplied;
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
                          title: operations.operationTime != null
                              ? 'Your operation date: ${(operations.operationTime ?? '').split(' ')[0].split('-')[2]}.${(operations.operationTime ?? '').split(' ')[0].split('-')[1]}.${(operations.operationTime ?? '').split(' ')[0].split('-')[0]}'
                              : 'Your operation date: --.--.----',
                          appStatusWidget: ApplicationStatusWidget(
                            status: operationDate!,
                          ),
                          status: operationDate!,
                        ),
                        StatusWidget(
                          title: operations.operationTime != null
                              ? 'Your operation time: ${(operations.operationTime ?? '').split(' ')[1]}'
                              : 'Your operation time: --:--',
                          appStatusWidget: ApplicationStatusWidget(
                            status: operationTime!,
                          ),
                          status: operationTime!,
                        ),
                        StatusWidget(
                          title:
                              'Your doctor: ${operations.doctorName ?? 'N/A'}',
                          appStatusWidget: ApplicationStatusWidget(
                            status: doctorsName!,
                          ),
                          status: doctorsName!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
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
                            Text(
                              'Hospital',
                              style: listTitleTextStyle,
                            ),
                            Text(
                              'Address',
                              style: listTitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ListHeadingsWidget(
                    //   column3: Container(
                    //     alignment: Alignment.topLeft,
                    //     width: (MediaQuery.of(context).size.width - 720) / 4,
                    //     child: Text(
                    //       'Address',
                    //       style: listTitleTextStyle,
                    //     ),
                    //   ),
                    //   column4: Container(
                    //     alignment: Alignment.topLeft,
                    //     width: (MediaQuery.of(context).size.width - 720) / 4,
                    //     child: Text(
                    //       'Date of operation',
                    //       style: listTitleTextStyle,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: applied.length,
                      itemBuilder: (_, index) {
                        var apply = applied[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PatientHomeInnerScreen(
                                  id: apply.hospitalId?.id ?? 0,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        minRadius: 20,
                                        backgroundImage: AssetImage(
                                          './assets/images/profile.png',
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      Text(
                                        apply.hospitalId?.name ?? 'N/A',
                                        style: listTileTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  apply.hospitalId?.address ?? 'N/A',
                                  style: listTileTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
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
