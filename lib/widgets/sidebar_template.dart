import 'dart:io';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:file_picker/file_picker.dart' as fp;

import '../constants/contants.dart';
import '../widgets/hoverable_list_tile.dart';

class SidebarTemplate extends StatefulWidget {
  final String title;
  final String email;
  final List<String> sideBarTitles;
  final List<IconData> sideBarListIcons;
  final List<String> sideBarTitlesBottom;
  final List<IconData> sideBarListIconsBottom;
  final List<String> routeNames;
  final List<String>? unselectedRoutes;
  const SidebarTemplate({
    required this.title,
    required this.email,
    required this.sideBarTitles,
    required this.sideBarListIcons,
    required this.sideBarTitlesBottom,
    required this.sideBarListIconsBottom,
    required this.routeNames,
    this.unselectedRoutes,
    super.key,
  });

  @override
  State<SidebarTemplate> createState() => _SidebarTemplateState();
}

class _SidebarTemplateState extends State<SidebarTemplate> {
  int? selectedTile;
  int? selectedTileBottom;
  List<bool> hoverStates = List.generate(5, (_) => false);
  List<bool> hoverStatesBottom = List.generate(2, (_) => false);

  final TextEditingController _searchController = TextEditingController();
  void _onSearchChanged() {
    print("Search text: ${_searchController.text}");
    // Implement your search logic here
  }

  File? _image;
  Future<void> _pickImage() async {
    fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentRouteName = ModalRoute.of(context)?.settings.name;

    if (widget.unselectedRoutes?.contains(currentRouteName) ?? false) {
      setState(() {
        selectedTile = null;
        selectedTileBottom = null;
      });
    } else {
      selectedTile = 0;
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['selectedTile'] != null) {
        setState(() {
          selectedTile = args['selectedTile'];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Adjust the width as needed
      child: Drawer(
        backgroundColor: const Color(0xFF164863),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                  popupMenuTheme: const PopupMenuThemeData(
                    elevation: 0,
                    color: Colors.transparent,
                  ),
                ),
                child: PopupMenuButton(
                  onSelected: (String value) {
                    // Handle the selection
                    if (value == 'logout') {
                      Navigator.of(context).pop();
                    } else if (value == 'choose photo') {
                      _pickImage();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      CustomMenuItem(
                        title: 'choose photo',
                        iconData: Icons.image,
                        value: 'choose photo',
                        backgroundColor: mainColor,
                      ),
                      CustomMenuItem(
                        title: 'logout',
                        iconData: Icons.logout,
                        value: 'logout',
                        backgroundColor: mainColor,
                      ),
                    ];
                  },
                  offset: const Offset(0, 82),
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Row(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                backgroundImage: FileImage(
                                  _image!,
                                ),
                                radius: 20,
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage('./assets/images/profile.png'),
                                radius: 20,
                              ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                                Text(
                                  widget.email,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                cursorColor: secondaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mainColor,
                  labelText: 'Search',
                  labelStyle: sideBarListTextStyle,
                  hintText: 'Type to search',
                  hintStyle: TextStyle(color: secondaryColor),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 28,
                      top: 0,
                      bottom: 0,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.sideBarListIcons.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() => hoverStates[index] = true);
                        },
                        onExit: (_) =>
                            setState(() => hoverStates[index] = false),
                        child: HoverableListTile(
                          icon: widget.sideBarListIcons[index],
                          title: widget.sideBarTitles[index],
                          onTap: () => setState(() {
                            selectedTile = index;
                            selectedTileBottom = null;
                            Navigator.of(context).popAndPushNamed(
                              widget.routeNames[index],
                              arguments: {'selectedTile': index},
                            );
                          }),
                          isHovered: hoverStates[index],
                          isSelected: selectedTile == index,
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 120,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView.builder(
                            itemCount: hoverStatesBottom.length,
                            itemBuilder: (context, index) {
                              return MouseRegion(
                                onEnter: (_) {
                                  setState(
                                      () => hoverStatesBottom[index] = true);
                                },
                                onExit: (_) => setState(
                                    () => hoverStatesBottom[index] = false),
                                child: HoverableListTile(
                                  icon: widget.sideBarListIconsBottom[index],
                                  title: widget.sideBarTitlesBottom[index],
                                  onTap: () => setState(() {
                                    selectedTileBottom = index;
                                    selectedTile = null;
                                  }),
                                  isHovered: hoverStatesBottom[index],
                                  isSelected: selectedTileBottom == index,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PopupMenuItem<String> CustomMenuItem({
  required String title,
  required IconData iconData,
  required String value,
  required Color backgroundColor,
}) {
  return PopupMenuItem<String>(
    value: value,
    padding: const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 1,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: const Color(0xFF466C80),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8), // Optional border radius
      ),
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 10,
        right: 80,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: const Color(0xFFFFFFFF),
          ),
          const SizedBox(width: 20), // Spacing between icon and text
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: containerTxtCol,
            ),
          ),
        ],
      ),
    ),
  );
}
