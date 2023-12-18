import 'package:flutter/material.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import './admin_add_hospital_screen.dart';
import './admin_edit_hospital_screen.dart';

class AdminHospitalsListScreen extends StatelessWidget {
  static const routeName = '/admin-hospitals-list-screen';
  const AdminHospitalsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesAdmin,
            sideBarListIcons: sideBarListIconsAdmin,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesAdmin,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Hospital List',
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
                                  'Total Hospitals',
                                  style: listHeadingTitleTextStyle,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '(144)',
                                  style: listHeadingTitleTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AdminAddHospitalScreen.routeName);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: patientListCol,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Icon(
                                  Icons.search,
                                  color: patientListCol,
                                ),
                                const SizedBox(width: 20),
                                Icon(
                                  Icons.analytics_outlined,
                                  color: patientListCol,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 620) / 4,
                              child: Text(
                                'Hospital',
                                style: listTitleTextStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width:
                                  (MediaQuery.of(context).size.width - 620) / 4,
                              child: Text(
                                'Owner',
                                style: listTitleTextStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width:
                                  (MediaQuery.of(context).size.width - 620) / 4,
                              child: Text(
                                'Address',
                                style: listTitleTextStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width:
                                  (MediaQuery.of(context).size.width - 1000) /
                                      4,
                              child: Text(
                                'View',
                                style: listTitleTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          620) /
                                      4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Medical Care',
                                        style: listTileTitle,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Cardiology Clinic',
                                        style: listTileSubTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: (MediaQuery.of(context).size.width -
                                          620) /
                                      4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Saidova Saida',
                                        style: listTileTitle,
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '21 years',
                                        style: listTileSubTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: (MediaQuery.of(context).size.width -
                                          620) /
                                      4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shifokorlar Street, 22',
                                        style: listTileTitle,
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Almazar district',
                                        style: listTileSubTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: (MediaQuery.of(context).size.width -
                                          1000) /
                                      4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: containerBgCol,
                                        minimumSize: const Size(95, 40),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            AdminEditHospitalScreen.routeName);
                                      },
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
