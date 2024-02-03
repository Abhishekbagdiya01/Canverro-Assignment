import 'package:cached_network_image/cached_network_image.dart';
import 'package:canverro_task/model/image_model.dart';
import 'package:canverro_task/services/service.dart';
import 'package:canverro_task/widgets/custom_popup.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CANVERRO TASK"),
      ),
      body: FutureBuilder(
        future: ApiService().fetchImages(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ImageModel> arrImage = snapshot.data;
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 2),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomPopUpDialog(imageData: arrImage[index]),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: arrImage[index].downloadUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
