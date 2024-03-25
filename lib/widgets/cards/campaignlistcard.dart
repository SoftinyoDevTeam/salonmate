import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CampaignListCard extends StatefulWidget {
  final double radius;
  final String imageUrl;
  final String heading;
  final String description;
  const CampaignListCard(
      {super.key,
      required this.radius,
      required this.heading,
      required this.description,
      required this.imageUrl});

  @override
  State<CampaignListCard> createState() => _CampaignListCardState();
}

class _CampaignListCardState extends State<CampaignListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        boxShadow: [
          BoxShadow(spreadRadius: 1, color: Colors.grey.withOpacity(0.2))
        ],
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius)),
              child: Container(
                  height: 100.h,
                  width: 400.w,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.heading,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.description),
          )
        ],
      ),
    );
  }
}
