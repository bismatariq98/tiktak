import 'package:tik_tak/models/homeModels/userModel.dart';
import 'package:tik_tak/providers/authProvider/authProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../theme/tik_tak_theme.dart';
import '../theme/tik_tak_util.dart';

import '../main.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/tik_tak_icon_button.dart';

class SinglechatPageWidget extends StatefulWidget {
  SinglechatPageWidget(this.chatDetails, this.otherUserID);
  List chatDetails;
  String otherUserID;
  @override
  _SinglechatPageWidgetState createState() => _SinglechatPageWidgetState();
}

class _SinglechatPageWidgetState extends State<SinglechatPageWidget> {
  TextEditingController messageController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var chat;
  userModel userDetails = userModel();
  @override
  void initState() {
    chat = widget.chatDetails;
    AuthProvider auth = context.read<AuthProvider>();
    userDetails = auth.userDataID;
    messageController = TextEditingController();
    super.initState();
  }

  deleteChat(String currentUSerID, OtherID) async {
    final Map<String, String> body = {
      'user_one_id': currentUSerID,
      'user_two_id': OtherID,
    };
    final response = await http.post(
        Uri.parse('https://flutterapp.5techsol.com/api/delete_chat_by_two.php'),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    if (response.statusCode == 200) {
      await Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.bottomCenter,
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 400),
          child: NavBarPage(initialPage: 'MassagePage'),
        ),
        (r) => false,
      );
    }
  }

  sendmessage(String currentUSerID, OtherID, message) async {
    final Map<String, String> body = {
      'sender_id': currentUSerID,
      'reciever_id': OtherID,
      'message': message
    };
    final response = await http.post(
        Uri.parse('https://flutterapp.5techsol.com/api/create_chat.php'),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    if (response.statusCode == 200) {
      setState(() {
        messageController.text = "";
      });
    }
  }

  Widget chatMessageTile(String message, time, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe
                    ? Color.fromARGB(255, 130, 190, 238)
                    : Colors.white,
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }

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
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              duration: Duration(milliseconds: 400),
                              reverseDuration: Duration(milliseconds: 400),
                              child: NavBarPage(initialPage: 'MassagePage'),
                            ),
                          );
                        },
                      ),
                      Text(
                        'Samantha Jnr',
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
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Delete Chat'),
                                    content: Text('This can not be undone'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(alertDialogContext);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(alertDialogContext);
                                          deleteChat(
                                            userDetails.data.userId,
                                            widget.otherUserID,
                                          );
                                        },
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.delete_rounded,
                              color: Color(0xFFFDFDFD),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  //height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: chat != null
                          ? ListView.builder(
                              padding: EdgeInsets.only(bottom: 70, top: 16),
                              itemCount: chat.length,
                              //reverse: true,
                              itemBuilder: (context, index) {
                                print("I am ${index}");
                                return chatMessageTile(
                                    chat[index].message,
                                    chat[index].createdAt.toString(),
                                    userDetails.data.userId ==
                                        chat[index].sender);
                              })
                          : CircularProgressIndicator()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_file_rounded,
                              color: TikTakTheme.primaryColor,
                              size: 35,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              child: Container(
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDEDEDE),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    obscureText: false,
                                    minLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Type your message',
                                      hintStyle: TikTakTheme.bodyText1,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 0, 0),
                                    ),
                                    style: TikTakTheme.bodyText1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TikTakIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 50,
                              fillColor: TikTakTheme.primaryColor,
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                if (messageController.text != '') {
                                  sendmessage(
                                      userDetails.data.userId,
                                      widget.otherUserID,
                                      messageController.text);
                                }
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
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
