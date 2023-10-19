import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:whatsapp_ui/resources/auth_methods.dart';
import 'package:whatsapp_ui/resources/jitsi_meet_methods.dart';
import 'package:whatsapp_ui/utils/colors.dart';
import 'package:whatsapp_ui/widgets/meeting_options.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JistiMeetMethods _jitsiMeetMethods = JistiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;
  
  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners(); 
  }

  _joinMeeting() async{
    _jitsiMeetMethods.createMeeting(
        roomName: meetingIdController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted ,
        username:nameController.text,
     );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text('Join a Meeting' , 
          style: TextStyle(fontSize: 18),
        ),
      ),

      body: Column(
        children: [

          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController ,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room ID',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0), 
              ),
            ),
          ),

          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController ,
              maxLines: 1,
              textAlign: TextAlign.center,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0), 
              ),
            ),
          ),

          const SizedBox(height: 20,),

         Padding(
           padding: const EdgeInsets.fromLTRB(16, 2, 16,2),
           child: ElevatedButton(
            onPressed: (() {
              
            }),
            style: ElevatedButton.styleFrom(
            primary: buttonColor,
            minimumSize: const Size(
              double.infinity,
              50,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: buttonColor),
            ),
        ),
            //  color: buttonColor,
             child: InkWell(
                  onTap: _joinMeeting,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Join ' , style: TextStyle(fontSize: 16,),textAlign: TextAlign.left,),
                  ),
                ),
                
           ),
         ),

          const SizedBox(height: 50,),
          const Text('JOIN OPTIONS' ,style: TextStyle(color: Colors.grey),),
          const SizedBox(height: 10,),
          MeetingOption(text: 'Don\'t Connect To Audio',isMute: isAudioMuted ,onChange: onAudioMuted),
          MeetingOption(text: 'Turn Off My Video',isMute: isVideoMuted ,onChange: onVideoMuted),

        ],
      ),
    );
  }
onAudioMuted(bool val){
  setState(() {
    isAudioMuted = val ;
  });
} 
onVideoMuted(bool val){
  setState(() {
    isVideoMuted = val ;
  });
}

}