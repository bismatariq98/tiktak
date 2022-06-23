import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:tik_tak/screens/videoViewPage.dart';
import 'package:video_player/video_player.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../theme/tik_tak_icon_button.dart';
import '../theme/tik_tak_theme.dart';
import '../theme/tik_tak_util.dart';

List<CameraDescription> cameras;

class UploadStatusPageWidget extends StatefulWidget {
  const UploadStatusPageWidget({Key key}) : super(key: key);

  @override
  _UploadStatusPageWidgetState createState() => _UploadStatusPageWidgetState();
}

class _UploadStatusPageWidgetState extends State<UploadStatusPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CameraController _cameraController;
  Future<void> cameraValue;
  bool isRecording = false, flash = false, isCameraFront = false;
  double transform = 0;
  File _video;
  final picker = ImagePicker();

  VideoPlayerController _videoPlayerController;
// This funcion will helps you to pick a Video File
  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      backgroundColor: Color.fromARGB(100, 22, 44, 33),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: cameraValue,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return CameraPreview(_cameraController);
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                })),
          ),
          Positioned(
              bottom: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                color: Color.fromARGB(100, 22, 44, 33),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: flash
                              ? Icon(Icons.flash_on)
                              : Icon(Icons.flash_off),
                          color: Colors.white,
                          iconSize: 28,
                        ),
                        GestureDetector(
                            onLongPress: () async {
                              await _cameraController.startVideoRecording();
                              setState(() {
                                isRecording = true;
                              });
                            },
                            onLongPressUp: () async {
                              XFile videopath =
                                  await _cameraController.stopVideoRecording();
                              setState(() {
                                isRecording = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => VideoViewPage(
                                            path: videopath.path,
                                          )));
                            },
                            child: isRecording
                                ? Icon(
                                    Icons.radio_button_on,
                                    color: Colors.red,
                                    size: 50,
                                  )
                                : Icon(
                                    Icons.panorama_fish_eye,
                                    color: Colors.white,
                                    size: 50,
                                  )),
                        IconButton(
                          onPressed: () async {
                            await _pickVideo();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        VideoViewPage(path: _video.path)));
                          },
                          icon: Icon(Icons.video_library),
                          color: Colors.white,
                        )
                      ],
                    ),
                    Text(
                      "Hold for Video",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            duration: Duration(milliseconds: 400),
                            reverseDuration: Duration(milliseconds: 400),
                            child: NavBarPage(initialPage: 'HomePage'),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () async {
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
                      },
                      child: Text(
                        'Done',
                        style: TikTakTheme.subtitle1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 70, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 45, 0, 5),
                      child: TikTakIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Color(0x52FFFFFF),
                        icon: Icon(
                          Icons.color_lens_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TikTakIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Color(0x51FFFFFF),
                        icon: Icon(
                          Icons.layers_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TikTakIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Color(0x52FFFFFF),
                        icon: Icon(
                          Icons.mic_none_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TikTakIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Color(0x52FFFFFF),
                        icon: Icon(
                          Icons.filter_tilt_shift_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TikTakIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Color(0x52FFFFFF),
                        icon: IconButton(
                          onPressed: () async {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + pi;
                            });
                            int cameraPos = !isCameraFront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          },
                          icon: Transform.rotate(
                              angle: transform,
                              child: Icon(Icons.flip_camera_ios)),
                          color: Colors.white,
                          iconSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
