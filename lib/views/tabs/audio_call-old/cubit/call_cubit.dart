// import 'dart:async';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'call_state.dart';
// import 'package:quiver/async.dart';

// class CallCubit extends Cubit<CallState> {
//   CallCubit() : super(CallInitial());

//   static CallCubit get(context) => BlocProvider.of(context);

//   //Agora video room

//   int? _remoteUid;
//   late RtcEngine _engine;

//   Future<void> initAgoraAndJoinChannel(
//       {required String channelToken,
//       required String channelName,
//       required bool isCaller}) async {
//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: "appId",
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//     await _engine.enableVideo();
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user ${connection.localUid} joined");
//           _remoteUid = null;
//           emit(AgoraRemoteUserJoinedEvent());
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user ${connection.localUid} left channel");
//           _remoteUid = null;
//           emit(AgoraUserLeftEvent());
//         },
//       ),
//     );

//     //join channel
//     await _engine.joinChannel(agoraTestToken, agoraTestChannelName, null, 0);
//     if (isCaller) {
//       emit(AgoraInitForSenderSuccessState());
//       playContactingRing(isCaller: true);
//     } else {
//       emit(AgoraInitForReceiverSuccessState());
//     }

//     debugPrint('channelTokenIs $channelToken channelNameIs $channelName');
//   }

//   //Sender
//   AudioPlayer assetsAudioPlayer = AudioPlayer();

//   Future<void> playContactingRing({required bool isCaller}) async {
//     String audioAsset = "assets/sounds/ringlong.mp3";
//     ByteData bytes = await rootBundle.load(audioAsset);
//     Uint8List soundBytes =
//         bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//     int result = await assetsAudioPlayer.playBytes(soundBytes);
//     if (result == 1) {
//       //play success
//       debugPrint("Sound playing successful.");
//     } else {
//       debugPrint("Error while playing sound.");
//     }
//     if (isCaller) {
//       startCountdownCallTimer();
//     }
//   }

//   int current = 0;
//   late CountdownTimer countDownTimer;
//   void startCountdownCallTimer() {
//     countDownTimer = CountdownTimer(
//       const Duration(seconds: callDurationInSec),
//       const Duration(seconds: 1),
//     );
//     var sub = countDownTimer.listen(null);
//     sub.onData((duration) {
//       current = callDurationInSec - duration.elapsed.inSeconds;
//       debugPrint("DownCount: $current");
//     });

//     sub.onDone(() {
//       debugPrint("CallTimeDone");
//       sub.cancel();
//       emit(DownCountCallTimerFinishState());
//     });
//   }

//   bool muted = false;
//   Widget muteIcon = const Icon(
//     Icons.keyboard_voice_rounded,
//     color: Colors.black,
//   );

//   Future<void> toggleMuted() async {
//     muted = !muted;
//     muteIcon = muted
//         ? const Icon(
//             Icons.mic_off_rounded,
//             color: Colors.black,
//           )
//         : const Icon(
//             Icons.keyboard_voice_rounded,
//             color: Colors.black,
//           );
//     await engine!.muteLocalAudioStream(muted);
//     emit(AgoraToggleMutedState());
//   }

//   Future<void> switchCamera() async {
//     await engine!.switchCamera();
//     emit(AgoraSwitchCameraState());
//   }

//   //Update Call Status
//   final _callApi = CallApi();
//   void updateCallStatusToUnAnswered({required String callId}) {
//     emit(LoadingUnAnsweredVideoChatState());
//     _callApi
//         .updateCallStatus(callId: callId, status: CallStatus.unAnswer.name)
//         .then((value) {
//       emit(SuccessUnAnsweredVideoChatState());
//     }).catchError((onError) {
//       emit(ErrorUnAnsweredVideoChatState(onError.toString()));
//     });
//   }

//   Future<void> updateCallStatusToCancel({required String callId}) async {
//     await _callApi.updateCallStatus(
//         callId: callId, status: CallStatus.cancel.name);
//   }

//   Future<void> updateCallStatusToReject({required String callId}) async {
//     await _callApi.updateCallStatus(
//         callId: callId, status: CallStatus.reject.name);
//   }

//   Future<void> updateCallStatusToAccept({required CallModel callModel}) async {
//     await _callApi.updateCallStatus(
//         callId: callModel.id, status: CallStatus.accept.name);
//     initAgoraAndJoinChannel(
//         channelToken: agoraTestChannelName,
//         channelName: agoraTestToken,
//         isCaller: false);
//   }

//   Future<void> updateCallStatusToEnd({required String callId}) async {
//     await _callApi.updateCallStatus(
//         callId: callId, status: CallStatus.end.name);
//   }

//   Future<void> endCurrentCall({required String callId}) async {
//     await _callApi.endCurrentCall(callId: callId);
//   }

//   Future<void> updateUserBusyStatusFirestore(
//       {required CallModel callModel}) async {
//     await _callApi.updateUserBusyStatusFirestore(
//         callModel: callModel, busy: false);
//   }

//   Future<void> performEndCall({required CallModel callModel}) async {
//     await endCurrentCall(callId: callModel.id);
//     await updateUserBusyStatusFirestore(callModel: callModel);
//   }

//   StreamSubscription? callStatusStreamSubscription;
//   void listenToCallStatus(
//       {required CallModel callModel,
//       required BuildContext context,
//       required bool isReceiver}) {
//     var _homeCubit = HomeCubit.get(context);
//     callStatusStreamSubscription =
//         _callApi.listenToCallStatus(callId: callModel.id);
//     callStatusStreamSubscription!.onData((data) {
//       if (data.exists) {
//         String status = data.data()!['status'];
//         if (status == CallStatus.accept.name) {
//           _homeCubit.currentCallStatus = CallStatus.accept;
//           debugPrint('acceptStatus');
//           emit(CallAcceptState());
//         }
//         if (status == CallStatus.reject.name) {
//           _homeCubit.currentCallStatus = CallStatus.reject;
//           debugPrint('rejectStatus');
//           callStatusStreamSubscription!.cancel();
//           emit(CallRejectState());
//         }
//         if (status == CallStatus.unAnswer.name) {
//           _homeCubit.currentCallStatus = CallStatus.unAnswer;
//           debugPrint('unAnswerStatusHere');
//           callStatusStreamSubscription!.cancel();
//           emit(CallNoAnswerState());
//         }
//         if (status == CallStatus.cancel.name) {
//           _homeCubit.currentCallStatus = CallStatus.cancel;
//           debugPrint('cancelStatus');
//           callStatusStreamSubscription!.cancel();
//           emit(CallCancelState());
//         }
//         if (status == CallStatus.end.name) {
//           _homeCubit.currentCallStatus = CallStatus.end;
//           debugPrint('endStatus');
//           callStatusStreamSubscription!.cancel();
//           emit(CallEndState());
//         }
//       }
//     });
//   }
// }
