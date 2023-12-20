import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../widgets/sidebar_template.dart';
import '../widgets/heading_widget.dart';
import '../constants/registration_constants.dart';
import '../providers/hospitals.dart';

class HospitalInfoScreen extends StatefulWidget {
  static const routeName = '/hospital-info-screen';

  const HospitalInfoScreen({super.key});

  @override
  State<HospitalInfoScreen> createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _enteredLocation;
  String? _enteredAddress;
  String? _chosenCategory;
  String? _enteredDescription;

  double _opacity = 1.0;
  bool _isHovering = false;

  File? _image;
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  var hospitalName;

  void _submitData() async {
    var workingDirectory =
        '~/Desktop/myapp/home/sardorchik/Desktop/myapp/lib/screens/';

    hospitalName =
        Provider.of<Hospitals>(context).allOperations[0].hospitalId!.name!;
    // Change to the working directory and run the C program
    var loginResult = await Process.run(
      'bash',
      [
        '-c',
        'cd $workingDirectory && ./client $localhost createQueue $extractedToken $hospitalName'
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
            sideBarTitles: sideBarTitlesHospital,
            sideBarListIcons: sideBarListIconsHospital,
            sideBarTitlesBottom: sideBarTitlesBottom,
            sideBarListIconsBottom: sideBarListIconsBottom,
            routeNames: routeNamesHospital,
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      title: 'Fill out Hospital Information',
                    ),
                    const SizedBox(height: 20),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Location Name',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _enteredLocation = value,
                            validator: validateDistrict,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _enteredAddress = value,
                            validator: validateAddress,
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                            value: _chosenCategory,
                            style: originalTextStyle,
                            // focusColor: Color(0x802B2B2B),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Choose category';
                              }
                              return null;
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            items: ['A', 'B', 'AB', 'O'].map((String category) {
                              return DropdownMenuItem(
                                  value: category,
                                  child: Row(
                                    children: <Widget>[
                                      Text(category),
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _chosenCategory = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Category',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: originalTextStyle,
                            cursorColor: const Color(0xFF2B2B2B),
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: labelTextStyle,
                              enabledBorder: enabledBorderParams,
                              focusedBorder: focusedBorderParams,
                              errorBorder: errorBorderParams,
                              focusedErrorBorder: focusedErrorBorderParams,
                            ),
                            onChanged: (value) => _enteredAddress = value,
                            validator: validateComment,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 20),
                          HeadingWidget(
                            title: 'Add Photo',
                            subtitle:
                                'This photo will be shown on Hospital List for other users',
                          ),
                          const SizedBox(height: 20),
                          Container(
                              width: double.infinity,
                              height: 470,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFD7D7D7),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _image != null
                                  ? MouseRegion(
                                      onEnter: (_) => setState(() {
                                        _opacity = 0.2;
                                        _isHovering = true;
                                      }),
                                      onExit: (_) => setState(() {
                                        _opacity = 1.0;
                                        _isHovering = false;
                                      }),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds: 700),
                                              opacity: _opacity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  _image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 700),
                                            opacity: 1,
                                            child: Visibility(
                                              visible: _isHovering,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                      color: mainColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  onPressed: _pickImage,
                                                  child: Text(
                                                    'SELECT NEW FILE',
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10,
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : buildSelectFileWidget(_pickImage)
                              // : Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Icon(
                              //         Icons.cloud_upload_outlined,
                              //         color: patientListCol,
                              //         size: 80,
                              //       ),
                              //       const SizedBox(
                              //         height: 24,
                              //       ),
                              //       Text(
                              //         'Select a file or drag and drop here',
                              //         style: TextStyle(
                              //           fontSize: 13,
                              //           fontWeight: FontWeight.normal,
                              //           fontFamily: 'Inter',
                              //           color: blackCol,
                              //         ),
                              //       ),
                              //       const SizedBox(height: 12),
                              //       Text(
                              //         'JPG, PNG or PDF, file size no more than 10MB',
                              //         style: TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.normal,
                              //           fontFamily: 'Inter',
                              //           color: patientListCol,
                              //         ),
                              //       ),
                              //       const SizedBox(height: 24),
                              //       OutlinedButton(
                              //           style: OutlinedButton.styleFrom(
                              //             side: BorderSide(
                              //               color: mainColor,
                              //               width: 1,
                              //             ),
                              //           ),
                              //           onPressed: _pickImage,
                              //           child: Text(
                              //             'SELECT FILE',
                              //             style: TextStyle(
                              //               fontFamily: 'Inter',
                              //               fontWeight: FontWeight.w600,
                              //               fontSize: 10,
                              //               color: mainColor,
                              //             ),
                              //           ))
                              //     ],
                              //   ),
                              ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AcceptButton(
                              title: 'Save',
                              onTapFunc: _pickImage,
                            ),
                          ),
                        ],
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

Widget buildSelectFileWidget(Function()? onPressed) {
  // Replace `patientListCol` and `blackCol` with your color values
  // Replace `mainColor` with your color value
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.cloud_upload_outlined,
        color: patientListCol,
        size: 80,
      ),
      const SizedBox(height: 24),
      Text(
        'Select a file or drag and drop here',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          fontFamily: 'Inter',
          color: blackCol,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        'JPG, PNG or PDF, file size no more than 10MB',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontFamily: 'Inter',
          color: patientListCol,
        ),
      ),
      const SizedBox(height: 24),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: mainColor,
            width: 1,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'SELECT FILE',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 10,
            color: mainColor,
          ),
        ),
      ),
    ],
  );
}
