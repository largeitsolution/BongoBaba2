import 'package:flutter/material.dart';

import '../my_theme.dart';
import 'common_webview_screen.dart';

class LiveChat extends StatefulWidget {
  int position=250;
  LiveChat({this.position=250});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        Positioned(
                  top: widget.position.toDouble(),
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CommonWebviewScreen(
                            url:
                                // 'https://bongobaba.com/privacy-policy-page',
                                'https://tawk.to/chat/6259340e7b967b11798add85/1g0m76mod');
                      }));
                    },
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: MyTheme.blue_color,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, top: 0),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                // text: 'Chat  ',
                                // style: TextStyle(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.w600,
                                //     color: Colors.black),
                                children: [
                                  WidgetSpan(
                                    child: RotatedBox(
                                        quarterTurns: -2,
                                        child: Text(
                                          '  Chat',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )

                                        //  Icon(
                                        //   Icons.message,
                                        //   color: Colors.green,
                                        //   size: 20,
                                        // )
                                        ),
                                  ),
                                  WidgetSpan(
                                    child: RotatedBox(
                                        quarterTurns: -1,
                                        child:
                                        Container(width: 23,
                                          height: 23,padding: EdgeInsets.only(right: 00),
                                          // color: Colors.amber,
                                          child: Image.asset('assets/live_chat.png')) 
                                        
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    ],
      
    );
  }
}