import 'package:flutter/material.dart';

import '../constants/contants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/step_widget.dart';
import '../widgets/heading_widget.dart';

class DonorHomeScreen extends StatefulWidget {
  static const routeName = '/donor-home-screen';

  const DonorHomeScreen({super.key});

  @override
  State<DonorHomeScreen> createState() => _DonorHomeScreenState();
}

class _DonorHomeScreenState extends State<DonorHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  void _onSearchChanged() {
    print("Search text: ${_searchController.text}");
    // Implement your search logic here
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
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
                  children: <Widget>[
                    HeadingWidget(title: 'How it works'),
                    const SizedBox(height: 80),
                    const StepWidget(
                      stepNumber: '1',
                      title: 'Welcome',
                      content:
                          'Welcome to Donor aid, you registered as donor and play a vital role for changing lives of people. You should proceed to next steps to continue your work.',
                    ),
                    const SizedBox(height: 70),
                    const StepWidget(
                      stepNumber: '2',
                      title: 'Donor Evaluation',
                      content:
                          ' Conduct a series of health checks and tests to determine the donor\'s suitability for organ donation. This might include blood tests, imaging, and other relevant health screenings.',
                    ),
                    const SizedBox(height: 70),
                    const StepWidget(
                      stepNumber: '3',
                      title: 'Hospital and Organ Information',
                      content:
                          'Organ information in medical card can be viewed after your approval by dispensary, you can check your status in your “donor evaluation” page. After approval you can apply for multiple hospitals where you want to donate',
                    ),
                    const SizedBox(height: 80),
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
