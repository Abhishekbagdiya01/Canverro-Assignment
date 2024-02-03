import 'package:canverro_task/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomPopUpDialog extends StatelessWidget {
  CustomPopUpDialog({required this.imageData, super.key});
  ImageModel imageData;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          // width: MediaQuery.sizeOf(context).width * 0.9,
          child: FlipCard(
            front: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: imageData.downloadUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                )),
            back: Column(
              children: <Widget>[
                Text(
                  "Author : ${imageData.author!}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Size : ${imageData.height} x ${imageData.width}",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CachedNetworkImage(
                  imageUrl: imageData.downloadUrl!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          launchUrlString(imageData.url!);
                        },
                        child: Text("Open in browser")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Back"))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
