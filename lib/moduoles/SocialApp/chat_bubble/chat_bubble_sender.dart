import 'package:flutter/material.dart';

class ChatBubble1 extends StatelessWidget {
  final String message ;
  const ChatBubble1({
    super.key ,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width * 0.5,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
              color: Colors.green[400],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style:const TextStyle(fontSize: 16.0 , color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
