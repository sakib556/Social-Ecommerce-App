import 'dart:convert';
import 'package:http/http.dart' as http;

String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI1ZDBmY2ZkOS1iYTg3LTQxNDQtOTQwNS05ZDIyZWYxNWM4OWYiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3MTYzMzY3MSwiZXhwIjoxNjg3MTg1NjcxfQ.h4n8P0xrcZcbZ6yOFM1o9mOBkuAy5baJT1E1QOxA-Wg";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}