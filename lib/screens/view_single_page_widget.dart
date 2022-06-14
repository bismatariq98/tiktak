import 'package:flutter/material.dart';
import 'package:tik_tak/screens/user_public_profle_widget.dart';

import '../components/single_video_slides_widget.dart';
import '../theme/tik_tak_icon_button.dart';
import '../theme/tik_tak_util.dart';

class ViewSinglePageWidget extends StatefulWidget {
  const ViewSinglePageWidget({Key key}) : super(key: key);

  @override
  _ViewSinglePageWidgetState createState() => _ViewSinglePageWidgetState();
}

class _ViewSinglePageWidgetState extends State<ViewSinglePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleVideoSlidesWidget(),
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, -2.38),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 40, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TikTakIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 10,
                              borderWidth: 1,
                              buttonSize: 45,
                              fillColor: Color(0x33FFFFFF),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.bottomCenter,
                                    duration: Duration(milliseconds: 400),
                                    reverseDuration:
                                        Duration(milliseconds: 400),
                                    child: UserPublicProfleWidget(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
