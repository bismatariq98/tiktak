import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_tak/constants/globals.dart';
import 'package:tik_tak/models/homeModels/chatModel.dart';
import 'package:tik_tak/models/homeModels/currentUserModel.dart';
import 'package:tik_tak/models/homeModels/userModel.dart';
import 'package:tik_tak/providers/authProvider/authProvider.dart';
import 'package:tik_tak/providers/chatProvider.dart';
import 'package:tik_tak/providers/currentUSer/currentUserProvider.dart';
import 'package:tik_tak/providers/homeProviders/videosProvider.dart';
import 'package:tik_tak/providers/likeProvider/likeProvider.dart';
import 'package:tik_tak/providers/sharedPreference.dart';
import 'package:http/http.dart' as http;
import 'package:tik_tak/screens/singlechat_page_widget.dart';
import '../screens/chat_request_widget.dart';
import '../screens/review_info_page_widget.dart';
import '../screens/user_public_profle_widget.dart';
import '../theme/tik_tak_theme.dart';
import '../theme/tik_tak_util.dart';
import '../theme/tik_tak_video_player.dart';
import 'dart:convert';

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
  bool isLiked = false;
  VideosProvider vidDetails = VideosProvider();
  userModel userDetails = userModel();

  checkAlreadyLiked() {
    for (int i = 0; i < widget.likerIds.length; i++) {
      if (widget.likerIds[i] == userDetails.data.userId) {
        setState(() {
          return isLiked = true;
        });
      } else
        return isLiked = false;
    }
  }

  getMessages() async {
    ChatModel chatDetails = context.read<ChatProvider>().chatDetails;
    await Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: 400),
        reverseDuration: Duration(milliseconds: 400),
        child: SinglechatPageWidget(chatDetails.data, widget.user),
      ),
      (r) => false,
    );
    int b = 9;
  }

  @override
  void initState() {
    AuthProvider auth = context.read<AuthProvider>();
    userDetails = auth.userDataID;
    final loggedUserdata =
        Provider.of<CurrentUserProvider>(context, listen: false);
    loggedUserdata.getData(context, userDetails.data.userId);
    final chatdata = Provider.of<ChatProvider>(context, listen: false);
    chatdata.getChatData(context, userDetails.data.userId, widget.user);
    //checkAlreadyLiked();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(context) {
    VideosProvider vid = context.read<VideosProvider>();
    CurrentUserProvider currentUser = context.read<CurrentUserProvider>();
    int b = 0;
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
                                    if (isLiked == true) {
                                      try {
                                        await Provider.of<LikeProvider>(context,
                                                listen: false)
                                            .deleteLike(context, widget.posIid,
                                                userDetails.data.userId);
                                        setState(() {
                                          isLiked = false;
                                        });
                                      } catch (error) {
                                        throw error;
                                      }
                                    } else {
                                      try {
                                        await Provider.of<LikeProvider>(context,
                                                listen: false)
                                            .dolike(context, widget.posIid,
                                                userDetails.data.userId);
                                        setState(() {
                                          isLiked = true;
                                        });
                                      } catch (error) {
                                        throw error;
                                      }
                                    }
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
                                widget.likerIds != null
                                    ? Text(
                                        "${widget.likerIds.length}",
                                        style: TikTakTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFFFDFDFD),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    : Text(
                                        "0",
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
                                      getMessages();
                                      // await Navigator.push(
                                      //     context,
                                      //     PageTransition(
                                      //       type: PageTransitionType.scale,
                                      //       alignment: Alignment.bottomCenter,
                                      //       duration:
                                      //           Duration(milliseconds: 400),
                                      //       reverseDuration:
                                      //           Duration(milliseconds: 400),
                                      //       child: ChatRequestWidget(
                                      //           // userDetails.data.userId,
                                      //           // widget.user),
                                      //           ),
                                      //     ));
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
