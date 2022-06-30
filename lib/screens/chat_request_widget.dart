import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tik_tak/screens/singlechat_page_widget.dart';
import 'package:tik_tak/screens/view_single_page_widget.dart';
import '../theme/tik_tak_icon_button.dart';
import '../theme/tik_tak_theme.dart';
import '../theme/tik_tak_util.dart';
import '../theme/tik_tak_widgets.dart';

import 'package:provider/provider.dart';

class ChatRequestWidget extends StatefulWidget {
  // ChatRequestWidget(this.currentUserID, this.otherUserID);
  // String currentUserID, otherUserID;
  @override
  _ChatRequestWidgetState createState() => _ChatRequestWidgetState();
}

class _ChatRequestWidgetState extends State<ChatRequestWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: TikTakTheme.tertiaryColor,
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -1),
            child: SvgPicture.asset(
              'assets/images/Pattern-login.svg',
              width: double.infinity,
              height: 275,
              fit: BoxFit.fitWidth,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: Color(0x00EEEEEE),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Chat Request',
                        style: TikTakTheme.subtitle1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: ViewSinglePageWidget(),
                                ),
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/avater.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.schedule_send,
                                              color: TikTakTheme.primaryColor,
                                              size: 80,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 4, 16, 12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: AutoSizeText(
                                                  'To start a conversation yu need to send @smanatan chat request',
                                                  textAlign: TextAlign.center,
                                                  style: TikTakTheme.subtitle2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: Text('Comfirm'),
                                                        content: Text(
                                                            'Send Chat Request '),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              // Navigator.pop(
                                                              //     alertDialogContext);
                                                              // await Navigator
                                                              //     .pushAndRemoveUntil(
                                                              //   context,
                                                              //   PageTransition(
                                                              //     type:
                                                              //         PageTransitionType
                                                              //             .scale,
                                                              //     alignment:
                                                              //         Alignment
                                                              //             .bottomCenter,
                                                              //     duration: Duration(
                                                              //         milliseconds:
                                                              //             400),
                                                              //     reverseDuration:
                                                              //         Duration(
                                                              //             milliseconds:
                                                              //                 400),
                                                              //     child:
                                                              //         SinglechatPageWidget(),
                                                              //   ),
                                                              //   (r) => false,
                                                              // );
                                                            },
                                                            child:
                                                                Text('Confirm'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                text: 'Send Chat Request',
                                                options: FFButtonOptions(
                                                  width: 220,
                                                  height: 50,
                                                  color:
                                                      TikTakTheme.primaryColor,
                                                  textStyle: TikTakTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius: 5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
