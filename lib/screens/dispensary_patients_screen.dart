import 'package:flutter/material.dart';
import 'package:myapp/providers/dispensary.dart';
import 'package:myapp/providers/hospitals.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/patients_list_tile.dart';
import '../widgets/list_headings_widget.dart';
import './hospital_patient_screen.dart';

class HospitalPatientsDonorsScreen extends StatefulWidget {
  static const routeName = '/dispensary-patients-screen';

  const HospitalPatientsDonorsScreen({super.key});

  @override
  State<HospitalPatientsDonorsScreen> createState() =>
      _HospitalOperationsScreenState();
}

class _HospitalOperationsScreenState
    extends State<HospitalPatientsDonorsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<DispensaryOperations>(context).fetchDonorsList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var donors = Provider.of<DispensaryOperations>(context).donorsList;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya patient/donor',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesDispensary,
            sideBarListIcons: sideBarListIconsDispensary,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesDispensary,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(title: 'Donors List'),
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
                        itemCount: donors.length,
                        itemBuilder: (context, index) {
                          return PatientsListTile(
                            name: donors[index].donorId!.userId!.fullName ??
                                "Default Name",
                            diagnosisTitle:
                                donors[index].donorId!.address ?? "",
                            diagnosisSubtitle:
                                donors[index].donorId!.city ?? '',
                            hospitalName:
                                donors[index].donorId!.phoneNumber ?? '',
                            city: donors[index].donorId!.birthday ?? ' ',
                            date: donors[index].donorId!.userId!.role ?? '',
                            subDate: '',
                            status: donors[index].donorId!.donationPrice != null
                                ? "${donors[index].donorId!.donationPrice}"
                                : "for free",
                            navigateFunc: () {},
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
