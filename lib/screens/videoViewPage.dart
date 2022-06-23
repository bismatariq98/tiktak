import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tik_tak/main.dart';
import 'package:tik_tak/providers/authProvider/authProvider.dart';
import 'package:tik_tak/theme/tik_tak_theme.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:tik_tak/models/homeModels/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({Key key, this.path}) : super(key: key);
  final String path;

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  VideoPlayerController _controller;
  TextEditingController videoDescriptionController = TextEditingController();
  userModel userDetails = userModel();
  @override
  void initState() {
    super.initState();
    AuthProvider auth = context.read<AuthProvider>();
    userDetails = auth.userDataID;
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Future<void> postVideo(context) async {
    var postUri =
        Uri.parse("https://flutterapp.5techsol.com/api/insert_data.php");
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    request.fields['video_description'] = videoDescriptionController.text;
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('video_file', widget.path);
    request.fields['user'] = userDetails.data.userId;
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video uploaded !',
            style: TikTakTheme.subtitle2.override(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: TikTakTheme.primaryColor,
        ),
      );
      await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 400),
          child: NavBarPage(initialPage: 'HomePage'),
        ),
      );
    }
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              //height: 600,
              height: MediaQuery.of(context).size.height,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: videoDescriptionController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      hintText: "Add Caption....",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // uploadFile(widget.path);
                          postVideo(context);
                        },
                        child: CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
