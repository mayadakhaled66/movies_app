import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:movies_app/components/app_page.dart';
import 'package:movies_app/features/home/model/person_details_model.dart';
import 'package:movies_app/utilities/app_constants.dart';
import 'package:image_downloader/image_downloader.dart';

class PersonDetailScreen extends StatelessWidget {
  final PersonDetailsResponseModel personData;

  const PersonDetailScreen({required this.personData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppMainPage(
      isPageWithAppbar: true,
      appBarTitle: "${personData.name}",
      pageBody: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                personData.profilePath != null
                    ? Column(
                        children: [
                          FullScreenWidget(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                AppConstants.imageApiPath +
                                    (personData.profilePath ?? ""),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                downloadImage(
                                    context,
                                    AppConstants.imageApiPath +
                                        (personData.profilePath ?? ""));
                              },
                              icon: const Icon(Icons.download)),
                        ],
                      )
                    : const Text("No Photo"),
                ListTile(
                  title: personData.birthday != null
                      ? Text("BirthDay: ${personData.birthday}")
                      : const Text("No BirthDay"),
                  subtitle: personData.placeOfBirth != null
                      ? Text("place Of Birth: ${personData.placeOfBirth}")
                      : const Text("No place Of Birth"),
                ),
                personData.alsoKnownAs != null
                    ? Text("Known as : ${personData.alsoKnownAs.toString()}")
                    : const Text("No Names"),
                Text(personData.biography ?? "No Data"),
                Container()
              ],
            )),
      ),
    );
  }

  void downloadImage(BuildContext context, String imagePath) async {
    try {
      var imageId = await ImageDownloader.downloadImage(imagePath,
          outputMimeType: "image/png");
      if (imageId == null) {
        return;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image downloaded.')));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString() ?? '')));
    }
  }
}
