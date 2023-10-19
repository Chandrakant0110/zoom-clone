import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatsapp_ui/resources/jitsi_meet_methods.dart';
import 'package:whatsapp_ui/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);
  final JistiMeetMethods _jistiMeetMethods = JistiMeetMethods();

  createMeeting() async{
    var random = Random();
    String roomName = (random.nextInt(100000000)+ 1000000).toString();
   _jistiMeetMethods.createMeeting(roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
                onPressed: createMeeting,
                text: 'New meeting',
                icon:  Icons.videocam,  
              ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context), 
              // onPressed: () => const VideoCallScreen(),
              text: 'Join',
              icon:  Icons.add_box_rounded,  
            ),
            HomeMeetingButton(
              onPressed: (){},
              text: 'Schedule',
              icon:  Icons.calendar_today,  
            ),
            HomeMeetingButton(
              onPressed: (){},
              text: 'Share Screen',
              icon:  Icons.arrow_upward,  
            ),
          ],
        ),
        const Expanded(child: Center(child: Text('Create a New Meeting!',style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)))

      ],
    );
  }
}