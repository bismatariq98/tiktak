import 'package:provider/provider.dart';
import 'package:tik_tak/providers/homeProviders/videosProvider.dart';

import '../components/video_slides_widget.dart';
import 'package:flutter/material.dart';
import '../theme/tik_tak_theme.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
    final data = Provider.of<VideosProvider>(context, listen: false);
    data.getPostData(context);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<VideosProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: data.loading
          ? CircularProgressIndicator.adaptive()
          : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  child: PageView.builder(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                    scrollDirection: Axis.vertical,
                    itemCount: data.getVideosModel.data.length,
                    itemBuilder: (context, index) {
                      //ab  VideoSlidesWidget is page p pass kruga
                      return VideoSlidesWidget(
                        url: data.getVideosModel.data[index].videoFile,
                        posIid: data.getVideosModel.data[index].id,
                        videoDescription:
                            data.getVideosModel.data[index].videoDescription,
                        user: data.getVideosModel.data[index].user,
                        createdAt: data.getVideosModel.data[index].createdAt,
                        likerIds: data.getVideosModel.data[index].likerIds,
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -0.22),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'TikTak',
                                  textAlign: TextAlign.start,
                                  style: TikTakTheme.subtitle1.override(
                                    fontFamily: 'Carter One',
                                    color: Color(0xFFE4E4E6),
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
