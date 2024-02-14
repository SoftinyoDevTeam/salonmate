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
          borderRadius: BorderRadius.circular(widget.radius),
          color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius)),
              child: Image.network(widget.imageUrl),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(widget.heading),
          SizedBox(
            height: 10.h,
          ),
          Text(widget.description)
        ],
      ),
    );
  }
}
