import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import './admin_add_region_screen.dart';
import './admin_edit_region_screen.dart';

class AdminRegionsListScreen extends StatelessWidget {
  static const routeName = '/admin-regions-list-screen';
  const AdminRegionsListScreen({super.key});

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
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesAdmin,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(title: 'Regions List'),
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
                                  'Total Regions',
                                  style: listHeadingTitleTextStyle,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '(4)',
                                  style: listHeadingTitleTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AdminAddRegionScreen.routeName);
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
                                'Region',
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
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            minRadius: 20,
                                            backgroundImage: AssetImage(
                                                './assets/images/profile.png'),
                                          ),
                                          const SizedBox(width: 25),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Saidova Saida',
                                                style: listTileTitle,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Uzbekistan',
                                                style: listTileSubTitle,
                                              ),
                                            ],
                                          ),
                                        ],
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
                                            AdminEditRegionScreen.routeName);
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
