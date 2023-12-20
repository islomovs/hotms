import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/list_headings_widget.dart';

class HospitalOrgansScreen extends StatelessWidget {
  static const routeName = '/hospital-organs-screen';
  const HospitalOrgansScreen({super.key});

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
                      title: 'Available Organs',
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
                                  'Total Organs',
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
                                  (MediaQuery.of(context).size.width - 720) / 4,
                              child: Text(
                                'Organ',
                                style: listTitleTextStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width:
                                  (MediaQuery.of(context).size.width - 720) / 4,
                              child: Text(
                                'Name',
                                style: listTitleTextStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width:
                                  (MediaQuery.of(context).size.width - 720) / 4,
                              child: Text(
                                'Blood group',
                                style: listTitleTextStyle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width:
                                  (MediaQuery.of(context).size.width - 1000) /
                                      4,
                              child: Text(
                                'Status',
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
                                  width: 220,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Liver',
                                        style: listTileTitle,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'per annum',
                                        style: listTileSubTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: (MediaQuery.of(context).size.width -
                                          720) /
                                      4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'tite',
                                        style: listTileTitle,
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'diagnosisSubtitle',
                                        style: listTileSubTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: (MediaQuery.of(context).size.width -
                                          720) /
                                      4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'hospitalName',
                                        style: listTileTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'city',
                                        style: listTileSubTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: (MediaQuery.of(context).size.width -
                                          720) /
                                      4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'date',
                                        style: listTileTitle,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'subDate',
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
                                    width: 90,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: containerBgCol,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'urgencyRate',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: mainColor,
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

// // import 'package:flutter/material.dart';

// // import '../constants/contants.dart';
// // import '../widgets/sidebar_template.dart';
// // import '../widgets/heading_widget.dart';
// // import '../widgets/request_button.dart';

// // class HospitalOrgansScreen extends StatefulWidget {
// //   static const routeName = '/hospital-organs-screen';

// //   const HospitalOrgansScreen({super.key});

// //   @override
// //   State<HospitalOrgansScreen> createState() => _HospitalOrgansScreenState();
// // }

// // class _HospitalOrgansScreenState extends State<HospitalOrgansScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   void _onSearchChanged() {
// //     print("Search text: ${_searchController.text}");
// //     // Implement your search logic here
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     _searchController.addListener(_onSearchChanged);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Sidebar (Drawer)
// //           SidebarTemplate(
// //             title: 'Nigina Roziya',
// //             email: 'nigina@roziya.com',
// //             sideBarTitles: sideBarTitlesD,
// //             sideBarListIcons: sideBarListIconsD,
// //             sideBarTitlesBottom: sideBarTitlesBottom,
// //             sideBarListIconsBottom: sideBarListIconsBottom,
// //             routeNames: routeNamesD,
// //           ),
// //           // Main content
// //           Expanded(
// //             child: SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     HeadingWidget(
// //                       title: 'Available Donors',
// //                       subtitle:
// //                           'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
// //                     ),
// //                     const SizedBox(height: 20),
// //                     GridView.builder(
// //                       shrinkWrap: true,
// //                       physics: const NeverScrollableScrollPhysics(),
// //                       gridDelegate:
// //                           const SliverGridDelegateWithFixedCrossAxisCount(
// //                               crossAxisCount: 3,
// //                               crossAxisSpacing: 30,
// //                               mainAxisSpacing: 30),
// //                       itemCount: 10,
// //                       itemBuilder: (context, index) {
// //                         return Container(
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(8),
// //                             border: Border.all(
// //                               color: const Color(0xFFA0AFC4),
// //                               width: 1.0,
// //                             ),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(25),
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   'Kidney',
// //                                   style: TextStyle(
// //                                     fontSize: 26,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontFamily: 'Inter',
// //                                     color: blackCol,
// //                                   ),
// //                                 ),
// //                                 const Text(
// //                                   'Donor: Alex MIchael',
// //                                   style: TextStyle(
// //                                     fontSize: 14,
// //                                     fontWeight: FontWeight.w500,
// //                                     fontFamily: 'Inter',
// //                                     color: Color(0xFFA0AFC4),
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   'Lorem ipsum dolor sit amet consecte turole adipiscing elit semper dalaracc lacus velolte facilisis volutpat est velitolm.',
// //                                   style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.normal,
// //                                     fontFamily: 'Inter',
// //                                     color: blackCol,
// //                                   ),
// //                                 ),
// //                                 RequestButton(
// //                                     btnTitle: 'Request', onTap: () {}),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
