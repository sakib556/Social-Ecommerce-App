import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'meeting_controls.dart';
import 'participant_tile.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;
  final void Function() leaveMeeting;

  const MeetingScreen(
      {Key? key,
      required this.meetingId,
      required this.token,
      required this.leaveMeeting})
      : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  Map<String, Stream?> participantVideoStreams = {};

  bool micEnabled = true;
  bool speakerEnabled = true;
  bool camEnabled = true;
  late Room room;

  void setParticipantStreamEvents(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams[participant.id] = stream);
      }
      // if (stream.kind == 'audio') {
      //   setState(() => p[participant.id] = stream);
      // }

    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams.remove(participant.id));
      }
    });
  }

  void setMeetingEventListener(Room _room) {
    setParticipantStreamEvents(_room.localParticipant);
    _room.on(
      Events.participantJoined,
      (Participant participant) => setParticipantStreamEvents(participant),
    );
    _room.on(Events.participantLeft, (String participantId) {
      if (participantVideoStreams.containsKey(participantId)) {
        setState(() => participantVideoStreams.remove(participantId));
      }
    });
    _room.on(Events.roomLeft, () {
      participantVideoStreams.clear();
      widget.leaveMeeting();
    });
  }

  @override
  void initState() {
    super.initState();
    // Create instance of Room (Meeting)
    room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: "Yash Chudasama",
      micEnabled: micEnabled,
      camEnabled: camEnabled,
      maxResolution: 'hd',
      defaultCameraIndex: 1,
      notification: const NotificationInfo(
        title: "Video SDK",
        message: "Video SDK is sharing screen in the meeting",
        icon: "notification_share", // drawable icon name
      ),
    );
    //room = VideoSDK.;

    setMeetingEventListener(room);

    // Join meeting
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Meeting ID: ${room.id}"),
          MeetingControls(
            onToggleMicButtonPressed: () {
              micEnabled ? room.muteMic() : room.unmuteMic();
              micEnabled = !micEnabled;
            },
            onToggleSpeakerButtonPressed: () {
              // speakerEnabled ? room : room.unmuteMic();
              // speakerEnabled = !speakerEnabled;
            },
            onToggleCameraButtonPressed: () {
              camEnabled
                  ? room.disableCam()
                  : room.enableCam();
              camEnabled = !camEnabled;
            },
            onLeaveButtonPressed: () => room.leave(),
          ),
          ...participantVideoStreams.values
              .map(
                (e) => ParticipantTile(
                  stream: e!,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}