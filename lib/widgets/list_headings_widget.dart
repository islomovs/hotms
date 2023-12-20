import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ListHeadingsWidget extends StatelessWidget {
  Widget? column3;
  Widget? column4;
  ListHeadingsWidget({
    required this.column3,
    required this.column4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: 220,
              child: Text(
                'Patients/Donors',
                style: listTitleTextStyle,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Text(
                'Diagnosis',
                style: listTitleTextStyle,
              ),
            ),
            column3!,
            column4!,
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 1000) / 4,
              child: Text(
                'Status',
                style: listTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationsListHeadingsWidget extends StatelessWidget {
  const OperationsListHeadingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: 220,
              child: Text(
                'Patients/Donors',
                style: listTitleTextStyle,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Text(
                'Diagnosis',
                style: listTitleTextStyle,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Text(
                'Doctor',
                style: listTitleTextStyle,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 720) / 4,
              child: Text(
                'Date of operation',
                style: listTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: (MediaQuery.of(context).size.width - 1000) / 4,
              child: Text(
                'Status',
                style: listTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
