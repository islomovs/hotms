import 'package:flutter/material.dart';
import 'package:myapp/constants/constants.dart';

class StatusWidget extends StatelessWidget {
  final String title;
  final Widget appStatusWidget;
  bool status;
  StatusWidget({
    required this.title,
    required this.appStatusWidget,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 300 - 80 - 40) / 3,
      height: 130,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: containerBgCol,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your application status',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: containerTxtCol,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: status == true ? blackCol : patientListCol,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          appStatusWidget,
        ],
      ),
    );
  }
}
