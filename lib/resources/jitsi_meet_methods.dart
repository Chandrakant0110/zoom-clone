import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:whatsapp_ui/resources/auth_methods.dart';
import 'package:whatsapp_ui/resources/firestore_methods.dart';

class JistiMeetMethods{
  final FireStoreMethods _fireStoreMethods =  FireStoreMethods();
  final AuthMethods _authMethods = AuthMethods();
  
  void createMeeting({
    required String roomName ,
    required bool isAudioMuted ,
    required isVideoMuted,
    String username = '',
  }) async{

    try {
	  FeatureFlag featureFlag = FeatureFlag();
	  featureFlag.welcomePageEnabled = false;
	  featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p
      
      String name;

      if(username.isEmpty){
        name = _authMethods.user.displayName! ;
      }else{
        name = username;
      }

      var options = JitsiMeetingOptions(
        room: roomName
      )
        ..userDisplayName = _authMethods.user.displayName
        ..userEmail = _authMethods.user.email
        ..userAvatarURL = _authMethods.user.photoURL 
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
      _fireStoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print ("error: $error");
    }
  }
}