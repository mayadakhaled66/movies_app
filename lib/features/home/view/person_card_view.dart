import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/features/home/model/home_response_model.dart';
import 'package:movies_app/utilities/app_constants.dart';

class PersonCardView extends StatelessWidget {
 final Result currentPersonData;

  PersonCardView({Key? key, required this.currentPersonData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: Text(currentPersonData.name ?? "No Name"),
            leading: currentPersonData.profilePath != null
                ? Image.network(
                    AppConstants.imageApiPath + currentPersonData.profilePath!,
                    errorBuilder: (_, cony, dd) {
                      return const SizedBox();
                    },
                  )
                : const SizedBox(),
            subtitle:
                Text("Known for: ${currentPersonData.knownForDepartment}"),
            trailing: Text("${currentPersonData.popularity} %"),
            isThreeLine: true,
          ),
        ));
  }
}
