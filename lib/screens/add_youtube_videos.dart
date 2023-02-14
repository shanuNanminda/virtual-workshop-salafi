import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:virtual_workshop/constants.dart';
import 'package:virtual_workshop/services/http_services.dart';

class AddYoutubeVideo extends StatefulWidget {
  AddYoutubeVideo({super.key});

  static String routeName = 'video page';

  @override
  State<AddYoutubeVideo> createState() => _AddYoutubeVideoState();
}

class _AddYoutubeVideoState extends State<AddYoutubeVideo> {
  TextEditingController urlController = TextEditingController();

  TextEditingController videoNameController = TextEditingController();

  GlobalKey<FormState> fkey = GlobalKey<FormState>();

  bool isImageValid = false;

  Future<void> ifImageValid(String uurl) async {
    Response res = await get(Uri.parse(uurl));
    setState(() {
      if (res.statusCode < 300 && res.statusCode > 199) {
        isImageValid = true;
      } else {
        isImageValid = false;
      }
    });
  }


  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SizedBox(
                child:
                    Image.network(isImageValid ?HttpServices. convertVideoLinkToImage(urlController.text) :Constants. imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: urlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (url) {
                  ifImageValid(url);
                },
                validator: (V) {
                  if (V!.isEmpty) {
                    return 'Enter url';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: videoNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (V) {
                  if (V!.isEmpty) {
                    return 'Enter name';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            ElevatedButton(onPressed: null, child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
