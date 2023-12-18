import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../widgets/hospital_card.dart';
import '../providers/donor.dart';

class DonorHospitalsScreen extends StatefulWidget {
  static const routeName = '/donor-hospitals-screen';

  const DonorHospitalsScreen({super.key});

  @override
  State<DonorHospitalsScreen> createState() => _DonorHospitalsScreenState();
}

class _DonorHospitalsScreenState extends State<DonorHospitalsScreen> {
  final List<String> _items = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow1 = 3;

  void _showMore1() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow1 = _itemsToShow1 == _items.length ? 3 : _items.length;
    });
  }

  final List<String> _items2 = List<String>.generate(20, (i) => "Item $i");
  int _itemsToShow2 = 3;

  void _showMore2() {
    setState(() {
      // If _itemsToShow is less than total items, show all items, else show initial count
      _itemsToShow2 = _itemsToShow2 == _items2.length ? 3 : _items2.length;
    });
  }

  int smth = 1;

  void _submitData() async {
    var workingDirectory =
        '~/Desktop/myapp/home/sardorchik/Desktop/myapp/lib/screens/';

    // Change to the working directory and run the C program
    var loginResult = await Process.run(
      'bash',
      [
        '-c',
        'cd $workingDirectory && ./client localhost applyToHospital $extractedToken $smth'
      ],
    );

    // After running the C program
    if (loginResult.exitCode == 0) {
      // Success logic
      print('C program output: ${loginResult.stdout}');

      // Extracting the JWT token
      String output = loginResult.stdout;
      String tokenPrefix = "server message: ";
      int startIndex = output.indexOf(tokenPrefix);
      if (startIndex != -1) {
        startIndex += tokenPrefix.length;
        String jwtToken = output.substring(startIndex).trim();

        // Assign to a new variable and print
        extractedToken = jwtToken;
        print('Extracted JWT Token: $extractedToken');

        var infoResult = await Process.run(
          'bash',
          [
            '-c',
            'cd $workingDirectory && ./client localhost getMyInfo "$extractedToken"'
          ],
        );

        if (infoResult.exitCode == 0) {
          print('C program output: ${infoResult.stdout}');

          // Regular expression to find the role
          RegExp regExp = RegExp(r'"role":"([^"]+)"');
          var matches = regExp.allMatches(infoResult.stdout);

          if (matches.isNotEmpty) {
            // Extract the role
            extractedRole = matches.first.group(1)!;
            print('Extracted Role: $extractedRole');
          }
        } else {
          print('C program error: ${infoResult.stderr}');
        }
      } else {
        // Error handling
        print('C program error: ${loginResult.stderr}');
      }
    } else {
      // Error handling
      print('C program error: ${loginResult.stderr}');
    }
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Donors>(context).fetchAllHospitals();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final hospitals = Provider.of<Donors>(context).donorH;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Drawer)
          SidebarTemplate(
            title: 'Nigina Roziya',
            email: 'nigina@roziya.com',
            sideBarTitles: sideBarTitlesDonor,
            sideBarListIcons: sideBarListIconsDonor,
            sideBarTitlesBottom: sideBarTitlesBottomDonor,
            sideBarListIconsBottom: sideBarListIconsBottomDonor,
            routeNames: routeNamesDonor,
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingWidget(
                          title: 'Hospital List',
                          subtitle:
                              'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
                        ),
                      ],
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
                                  '${hospitals.length}',
                                  style: listHeadingTitleTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              children: [
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeadingWidget(
                              title: 'Gastroenterology',
                              subtitle:
                                  'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
                            ),
                            InkWell(
                              onTap: _showMore1,
                              child: Row(
                                children: [
                                  Text(
                                    'Show more',
                                    style: listTitleTextStyle,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: patientListCol,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 0,
                          ),
                          itemCount: _itemsToShow1,
                          itemBuilder: (context, index) {
                            return HospitalCard(
                              title: hospitalTitles[index],
                              description: hospitalDescriptions[index],
                              onTap: _submitData,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeadingWidget(
                              title: 'Gastroenterology',
                              subtitle:
                                  'You can safely start treatment, which we carry out as quickly and efficiently as possible in Tashkent.',
                            ),
                            InkWell(
                              onTap: _showMore2,
                              child: Row(
                                children: [
                                  Text(
                                    'Show more',
                                    style: listTitleTextStyle,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: patientListCol,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 0,
                          ),
                          itemCount: _itemsToShow2,
                          itemBuilder: (_, index) {
                            return HospitalCard(
                              title: hospitalTitles[index],
                              description: hospitalDescriptions[index],
                              onTap: _submitData,
                            );
                          },
                        ),
                      ],
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
