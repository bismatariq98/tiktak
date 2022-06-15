import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_tak/models/homeModels/videosModel.dart';
import 'package:tik_tak/providers/homeProviders/videosProvider.dart';
import 'package:tik_tak/providers/likeProvider/likeProvider.dart';

import '../screens/chat_request_widget.dart';
import '../screens/review_info_page_widget.dart';
import '../screens/user_public_profle_widget.dart';
import '../theme/tik_tak_theme.dart';
import '../theme/tik_tak_util.dart';
import '../theme/tik_tak_video_player.dart';

class SingleVideoSlidesWidget extends StatefulWidget {
  const SingleVideoSlidesWidget({Key key}) : super(key: key);

  @override
  _SingleVideoSlidesWidgetState createState() =>
      _SingleVideoSlidesWidgetState();
}

class _SingleVideoSlidesWidgetState extends State<SingleVideoSlidesWidget> {
  initState() {
    super.initState();
    final videoData=context.read<VideosProvider>().getVideosModel;//ya ks liyay use bhla
  }
  //iska kehrien..??
  //nh aik orth

  @override
  Widget build(BuildContext context) {
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
            path: 'assets/videos/1639549105301.mp4',
            videoType: VideoType.asset,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            autoPlay: true,
            looping: true,
            showControls: false,
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Heart Clicked");
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0x69EEEEEE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '121.9k',
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
                                      await Share.share('Share Me');
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
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 150),
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
          padding: EdgeInsetsDirectional.fromSTEB(60, 0, 0, 150),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emanuel ',
                style: TikTakTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Watson',
                style: TikTakTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16,
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thailans capital is a fast, buzziing city of over\neight million people.',
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
