import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  addVideo() async {
    final spref=await SharedPreferences.getInstance();
    final res=await HttpServices.postData(params: {
      'user':spref.getString('userId'),
      'description': videoNameController.text,
      'link': urlController.text,
    }, endPoint: 'Ytlink');
    if(res['link']!=null){
      Fluttertoast.showToast(msg: 'video added');
      Navigator.pop(context);
    }
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
                child: Image.network(isImageValid
                    ? HttpServices.convertVideoLinkToImage(urlController.text)
                    : Constants.imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: urlController,
                decoration: const InputDecoration(
                  label: Text('video url'),
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
                  label: Text('video name'),
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
            ElevatedButton(
                onPressed: isImageValid
                    ? () {
                        if (fkey.currentState!.validate()) {
                          addVideo();
                        }
                      }
                    : null,
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
