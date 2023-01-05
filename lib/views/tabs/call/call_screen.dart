// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/call/call.dart';
import 'package:protibeshi_app/providers/call_provider.dart';

import 'api.dart';
import 'join_screen.dart';
import 'meeting_screen.dart';

class VideoSDKQuickStart extends StatefulWidget {
  const VideoSDKQuickStart({Key? key}) : super(key: key);

  @override
  State<VideoSDKQuickStart> createState() => _VideoSDKQuickStartState();
}

class _VideoSDKQuickStartState extends State<VideoSDKQuickStart> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Call"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
                meetingId: meetingId,
                token: token,
                leaveMeeting: () {
                  setState(() => isMeetingActive = false);
                },
              )
            : JoinScreen(
                onMeetingIdChanged: (value) => meetingId = value,
                onCreateMeetingButtonPressed: () async {
                  meetingId = await createMeeting();
                  setState(() => isMeetingActive = true);
                },
                onJoinMeetingButtonPressed: () {
                  setState(() => isMeetingActive = true);
                },
              ),
      ),
    );
  }
}

class CallingScreen extends StatefulWidget {
  const CallingScreen({
    Key? key,
    required this.receiverId,
  }) : super(key: key);
  final String receiverId;

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Call"),
      ),
      body: isMeetingActive
          ? MeetingScreen(
              meetingId: meetingId,
              token: token,
              leaveMeeting: () {
                setState(() => isMeetingActive = false);
              },
            )
          : rp.Consumer(
              builder: (context, ref, child) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SendCallScreen(
                    onSendButtonPressed: () async {
                      String id =
                          "${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().millisecondsSinceEpoch}";
                      meetingId = await createMeeting();
                      CallModel callModel = CallModel(
                          id: id,
                          meetingId: meetingId,
                          token: token,
                          callerId: FirebaseAuth.instance.currentUser!.uid,
                          receiverId: widget.receiverId);
                      await ref
                          .read(callProvider.notifier)
                          .sendCall(callModel)
                          .then((value) {
                        print("$value value");
                        if (value.contains("calling")) {
                          setState(() => isMeetingActive = true);
                          EasyLoading.showSuccess("calling");
                        } else {
                          EasyLoading.showSuccess("busy!!");
                          //Navigator.pop(context);
                        }
                      });
                    },
                    onCancelButtonPressed: () async {
                      Navigator.pop(context);
                    },
                  )),
            ),
    );
  }
}

class RecieveCallScreen extends StatefulWidget {
  const RecieveCallScreen({
    Key? key,
    required this.callModel,
  }) : super(key: key);
  final CallModel callModel;

  @override
  State<RecieveCallScreen> createState() => _RecieveCallScreenState();
}

class _RecieveCallScreenState extends State<RecieveCallScreen> {
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Call"),
        ),
        body: rp.Consumer(
          builder: (context, ref, child) => isMeetingActive
              ? MeetingScreen(
                  meetingId: widget.callModel.meetingId,
                  token: widget.callModel.token,
                  leaveMeeting: () async {
                    await ref
                        .read(callProvider.notifier)
                        .cancelCall(widget.callModel.id);
                    setState(() => isMeetingActive = false);
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RecieveCall(
                    callModel: widget.callModel,
                    onAcceptButtonPressed: () async {
                      setState(() => isMeetingActive = true);
                    },
                    onCancelButtonPressed: () async {
                      await ref
                          .read(callProvider.notifier)
                          .cancelCall(widget.callModel.id);
                      setState(() => isMeetingActive = false);
                     // Navigator.pop(context);
                    },
                  )),
        ));
  }
}

class RecieveCall extends StatelessWidget {
  final CallModel callModel;
  final void Function() onAcceptButtonPressed;
  final void Function() onCancelButtonPressed;

  const RecieveCall({
    Key? key,
    required this.callModel,
    required this.onAcceptButtonPressed,
    required this.onCancelButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            child: const Text("Accept"), onPressed: onAcceptButtonPressed),
        const SizedBox(height: 16),
        Text("Meeting id: ${callModel.meetingId}"),
        const SizedBox(height: 8),
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: onCancelButtonPressed,
        )
      ],
    );
  }
}
