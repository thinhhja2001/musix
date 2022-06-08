
import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:readmore/readmore.dart';

class ArtistDesc extends StatefulWidget {
  const ArtistDesc({Key? key, required this.description}) : super(key: key);
  final String description;

  @override
  State<ArtistDesc> createState() => _ArtistDescState();
}

class _ArtistDescState extends State<ArtistDesc> {
  void ToggleRead() {
    setState(() {
      readMore = !readMore;
    });
  }

  bool readMore = false;
  Widget overMultiLine() {
    return (widget.description.trim()).split(" ").length > 35
        ? GestureDetector(
            onTap: ToggleRead,
            child: Text(
              readMore ? "Rút ngắn" : "Đọc thêm",
              style: TextStyle(color: kPrimaryColor),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Description: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ReadMoreText(
              widget.description,
              trimLines: 3,
              colorClickableText: kPrimaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: kPrimaryColor),
              lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
