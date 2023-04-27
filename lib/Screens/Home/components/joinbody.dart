import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
void main() => runApp(const MyApp2());

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});
    @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Meeting());
  }
}

class Meeting extends StatefulWidget {
  const Meeting ({super.key});
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final _formKey = GlobalKey<FormState>();
  final serverText = TextEditingController();
  final roomText2 = TextEditingController();
  final email = FirebaseAuth.instance.currentUser!.email;
  final nameText = TextEditingController();
 // final FirebaseAuth _auth  = FirebaseAuth.instance;
  bool? isAudioUnMuted = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;
  bool? isVideoUnMuted = true;
  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,

        onError: _onError));
  }
  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              const Spacer(flex: 1),
              Image.asset(
                'assets/images/code.jpg',
                height: size.height * 0.35,
              ),
              const Spacer(flex: 65),
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: const Text(
                  "Join with code",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 65),
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xfff3f3f3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  controller: nameText,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: "Name"),
                ),
              ),
              const Spacer(flex: 58),
    Form(
    key: _formKey,
    child: Column(
    children: [
              Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xfff3f3f3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  key: const ValueKey('roomText'),
                  controller: roomText2,
                  validator: (room) {
                    if (room == null || room.isEmpty) {
                      return 'Please Enter Room Code';
                    }
                    else if (room == math.Random().nextInt(99999).toString()) {
                      return 'Please Enter a Valid Room Code';
                    }
                    return null;
                  },
                  //controller: roomText2,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(Icons.meeting_room_outlined, color: Colors.black),
                      hintText: "Room Code"),
                ),
              ),
      ],
    ),
        ),
              const Spacer(flex: 58),
              Container(
                width: 350,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xfff3f3f3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Email:$email',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(flex: 58),
              const SizedBox(
                width: 350,
                child: Text(
                  "Meet Guidelines -\n1) For privacy reasons you may change your name if you want.\n2) By default They taking your Email id as name.\n3) Enter the room code for joining the video.\n4)If the room code is not available,then it will create a new meeting itself.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff898989),
                  ),
                ),
              ),
              const Spacer(flex: 58),
              Row(
                children: [
                  const Spacer(flex: 32),
                  GestureDetector(
                    onTap: () {
                      _onAudioMutedChanged(!isAudioMuted!);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          color: isAudioMuted!
                              ? const Color(0xffD64467)
                              : const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.06),
                                offset: const Offset(0, 4)),
                          ]),
                      width: 72,
                      height: 52,
                      child: Icon(
                        isAudioMuted!
                            ? Icons.mic_off_sharp
                            : Icons.mic_none_sharp,
                        color: isAudioMuted! ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(flex: 16),
                  GestureDetector(
                    onTap: () {
                      _onVideoMutedChanged(!isVideoMuted!);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          color: isVideoMuted!
                              ? const Color(0xffD64467)
                              : const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.06),
                                offset: const Offset(0, 4)),
                          ]),
                      width: 72,
                      height: 52,
                      child: Icon(
                        isVideoMuted!
                            ? Icons.videocam_off_sharp
                            : Icons.videocam,
                        color: isVideoMuted! ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(flex: 16),
                  GestureDetector(
                    onTap: () async
                    {
                      if (_formKey.currentState!.validate()) {
                     await   _joinMeeting(); // Join meet on tap
                      }
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            color: const Color(0xffAA66CC),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.06),
                                  offset: const Offset(0, 4)),
                            ]),
                        width: 174,
                        height: 52,
                        child: const Center(
                          child: Text(
                            "JOIN MEET",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                  const Spacer(flex: 32),
                ],
              ),
              const Spacer(flex: 38),
            ],
          ),
        ),
      ),
    );
  }
  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }
  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
    String? display;
    if (nameText.text.trim().isEmpty) {
      display = email;
    } else {
      display = nameText.text;
    }
    //late String room;
    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room:roomText2.text)
      ..serverURL = serverUrl
      ..userDisplayName = display
      ..userEmail = email
    //  ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText2.text,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
      };
    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }
  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
