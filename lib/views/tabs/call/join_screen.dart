import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/call/call.dart';

class JoinScreen extends StatelessWidget {
  final void Function() onCreateMeetingButtonPressed;
  final void Function() onJoinMeetingButtonPressed;
  final void Function(String) onMeetingIdChanged;

  const JoinScreen({
    Key? key,
    required this.onCreateMeetingButtonPressed,
    required this.onJoinMeetingButtonPressed,
    required this.onMeetingIdChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            child: const Text("Create Meeting"),
            onPressed: onCreateMeetingButtonPressed),
        const SizedBox(height: 16),
        TextField(
            decoration: const InputDecoration(
              hintText: "Meeting ID",
              border: OutlineInputBorder(),
            ),
            onChanged: onMeetingIdChanged),
        const SizedBox(height: 8),
        ElevatedButton(
          child: const Text("Join"),
          onPressed: onJoinMeetingButtonPressed,
        )
      ],
    );
  }
}

class SendCallScreen extends StatelessWidget {
  final void Function() onSendButtonPressed;
  final void Function() onCancelButtonPressed;

  const SendCallScreen({
    Key? key,
    required this.onSendButtonPressed,
    required this.onCancelButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            child: const Text("Send"), onPressed: onSendButtonPressed),
        const SizedBox(height: 16),
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: onCancelButtonPressed,
        )
      ],
    );
  }
}

