import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_tak/constants/globals.dart';
import 'package:tik_tak/models/homeModels/loginResponseModel.dart';
import 'package:tik_tak/providers/authProvider/authProvider.dart';
import 'package:tik_tak/providers/currentUSer/currentUserProvider.dart';
import 'package:tik_tak/providers/homeProviders/videosProvider.dart';
import 'package:tik_tak/providers/likeProvider/likeProvider.dart';
import 'package:tik_tak/providers/sharedPreference.dart';

import '../screens/chat_request_widget.dart';
import '../screens/review_info_page_widget.dart';
import '../screens/user_public_profle_widget.dart';
import '../theme/tik_tak_theme.dart';
import '../theme/tik_tak_util.dart';
import '../theme/tik_tak_video_player.dart';

class VideoSlidesWidget extends StatefulWidget {
  VideoSlidesWidget(
      {this.url,
      this.posIid,
      this.videoDescription,
      this.user,
      this.likerIds,
      this.createdAt,
      Key key})
      : super(key: key);
  String url;
  String posIid;
  String videoDescription;
  String user;
  DateTime createdAt;
  List<String> likerIds;

  @override
  _VideoSlidesWidgetState createState() => _VideoSlidesWidgetState();
}

class _VideoSlidesWidgetState extends State<VideoSlidesWidget> {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  String userId;
  bool isLiked = false;

  getInfo() {
    setState(() async {
      userId = await sharedPreferenceHelper.getCurrentUserID();
      print("I am your1 ${userId}");
    });
  }

  @override
  initState() {
    super.initState();
    getInfo();
    int b = 0;
    //checkAlreadyLiked();
    //readAllLikes();
  }

  // Future<void> readAllLikes() async {
  //   try {
  //     await Provider.of<LikeProvider>(context, listen: false)
  //         .getLikes(context, widget.posIid);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> likeMeButton() async {
  //   try {
  //     await Provider.of<LikeProvider>(context, listen: false).dolike(
  //         context, widget.posIid, currentUserID);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // checkAlreadyLiked() {
  //   for (int i = 0; i < widget.likerIds.length; i++) {
  //     if (widget.likerIds[0] == currentUserID) {
  //       setState(() {
  //         return isLiked = true;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: TikTakVideoPlayer(
            path: '$baseURl${widget.url}',
            videoType: VideoType.network,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            autoPlay: true,
            looping: true,
            showControls: true,
            allowFullScreen: false,
            allowPlaybackSpeedMenu: false,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 430,
                  decoration: BoxDecoration(
                    color: Color(0x4DC4C4C4),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(0),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // if (isLiked == true) {
                                    //   try {
                                    //     await Provider.of<LikeProvider>(context,
                                    //             listen: false)
                                    //         .deleteLike(context, widget.posIid,
                                    //             userData.read('count'));
                                    //   } catch (error) {
                                    //     throw error;
                                    //   }
                                    // } else {
                                    //   try {
                                    //     await Provider.of<LikeProvider>(context,
                                    //             listen: false)
                                    //         .dolike(context, widget.posIid,
                                    //             userData.read('count'));
                                    //   } catch (error) {
                                    //     throw error;
                                    //   }
                                    // }
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0x69EEEEEE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        color:
                                            isLiked ? Colors.red : Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "12.3k",
                                  // "${widget.likerIds.length}",
                                  style: TikTakTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 110, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.scale,
                                          alignment: Alignment.bottomCenter,
                                          duration: Duration(milliseconds: 400),
                                          reverseDuration:
                                              Duration(milliseconds: 400),
                                          child: ReviewInfoPageWidget(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0x69EEEEEE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.bar_chart_rounded,
                                        color: Colors.white,
                                        size: 34,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '+8.5',
                                  style: TikTakTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 210, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.scale,
                                          alignment: Alignment.bottomCenter,
                                          duration: Duration(milliseconds: 400),
                                          reverseDuration:
                                              Duration(milliseconds: 400),
                                          child: ChatRequestWidget(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0x69EEEEEE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.chat_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Chat',
                                  style: TikTakTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 310, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Share.share('Share Now');
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0x69EEEEEE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.share_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Share',
                                  style: TikTakTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFDFDFD),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 90),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.bottomCenter,
                      duration: Duration(milliseconds: 400),
                      reverseDuration: Duration(milliseconds: 400),
                      child: UserPublicProfleWidget(),
                    ),
                  );
                },
                child: Container(
                  width: 45,
                  height: 45,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/avater.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(60, 0, 0, 90),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TikTakTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.videoDescription,
                      textAlign: TextAlign.start,
                      style: TikTakTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' #thaiadvanture',
                      textAlign: TextAlign.start,
                      style: TikTakTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF33A34A),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
