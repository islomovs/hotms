import 'package:flutter/material.dart';

import '../constants/contants.dart';

class PatientsListTile extends StatelessWidget {
  final String name;
  final String? subtitle;
  final String diagnosisTitle;
  final String diagnosisSubtitle;
  final String hospitalName;
  final String city;
  final String date;
  final String subDate;
  final String status;
  VoidCallback navigateFunc;

  PatientsListTile({
    required this.name,
    this.subtitle,
    required this.diagnosisTitle,
    required this.diagnosisSubtitle,
    required this.hospitalName,
    required this.city,
    required this.date,
    required this.subDate,
    required this.status,
    required this.navigateFunc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateFunc,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        minRadius: 20,
                        backgroundImage:
                            AssetImage('./assets/images/profile.png'),
                      ),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: listTileTitle,
                          ),
                          if (subtitle != null) const SizedBox(height: 5),
                          if (subtitle != null)
                            Text(
                              subtitle!,
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
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diagnosisTitle,
                    style: listTileTitle,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    diagnosisSubtitle,
                    style: listTileSubTitle,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospitalName,
                    style: listTileTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    city,
                    style: listTileSubTitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: listTileTitle,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subDate,
                    style: listTileSubTitle,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 1000) / 4,
              child: Container(
                alignment: Alignment.center,
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                  color: containerBgCol,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
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
      ),
    );
  }
}
