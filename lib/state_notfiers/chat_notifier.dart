import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/helper/network_exceptions.dart';
import 'package:protibeshi_app/models/chats/conversation_model.dart';
import 'package:protibeshi_app/models/chats/message_model.dart';
import 'package:protibeshi_app/views/others/error_pop.dart';

class ChatIDNotifier extends StateNotifier<ApiState<List<ConversationModel>>> {
  ChatIDNotifier() : super(const ApiState.initial()) {
    getMyChatIds();
  }

  StreamSubscription<Event>? _stream;

  Future<void> getMyChatIds() async {
    state = const ApiState.loading();
    try {
      _stream =
          FirebaseConstants.userChatsRef(FirebaseAuth.instance.currentUser!.uid)
              .onValue
              .listen((event) {
        List<ConversationModel> chats = [];
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> mapOfMaps = Map.from(event.snapshot.value);
          for (var value in mapOfMaps.values) {
            chats.add(ConversationModel.fromMap(Map.from(value)));
          }
        }
        state = ApiState.loaded(data: chats);
      });
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );

      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  @override
  void dispose() {
    if (_stream != null) {
      _stream!.cancel();
    }
    super.dispose();
  }
}
class ChatMessageNotifier extends StateNotifier<ApiState<List<MessageModel>>> {
  ChatMessageNotifier(this.chatId) : super(const ApiState.initial()) {
    //To Make faimly with the chatId
    allMessages();
  }

  StreamSubscription<Event>? _stream;
  final String chatId;

  Future<void> allMessages() async {
    state = const ApiState.loading();
    try {
      _stream = FirebaseConstants.messagesRef(chatId).onValue.listen((event) {
        List<MessageModel> _messages = [];
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> mapOfMaps = Map.from(event.snapshot.value);
          for (var value in mapOfMaps.values) {
            _messages.add(MessageModel.fromMap(Map.from(value)));
          }
        }
        state = ApiState.loaded(data: _messages);
      });
    } catch (e) {
      String err = NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e),
      );

      errorPopup(err); //Shows Error PopUp
      state = ApiState.error(
        error: err,
      );
    }
  }

  @override
  void dispose() {
    if (_stream != null) {
      _stream!.cancel();
    }
    super.dispose();
  }
}

//ChatRepo classes methods converted to riverpod
class CreateConversationNotifier extends StateNotifier<ApiState<String>> {
  CreateConversationNotifier() : super(const ApiState.initial());
   static Future<String?> createConversation(String userId) async {
    String _chatId =
        FirebaseAuth.instance.currentUser!.uid.compareTo(userId) == 1
            ? "${FirebaseAuth.instance.currentUser!.uid}_$userId"
            : "${userId}_${FirebaseAuth.instance.currentUser!.uid}";
    var _conversation = ConversationModel(
      id: _chatId,
      userIds: [FirebaseAuth.instance.currentUser!.uid, userId],
      lastMessageTime: DateTime.now(),
    );
    return await FirebaseConstants.userChatsRef(
            FirebaseAuth.instance.currentUser!.uid)
        .child(_conversation.id)
        .set(_conversation.toMap())
        .then((value) async {
      return await FirebaseConstants.userChatsRef(userId)
          .child(_conversation.id)
          .set(_conversation.toMap())
          .then((value) => _conversation.id);
          
    }
    );
}}
class CreateMessageNotifier extends StateNotifier<ApiState<String>> {
  CreateMessageNotifier() : super(const ApiState.initial());
  static Future<bool> createMessage(
      String conversationId, String? message, String otherUserId,
      [List<String>? attachments]) async {
    final _time = DateTime.now();
    var _message = MessageModel(
      id: _time.microsecondsSinceEpoch.toString(),
      message: message,
      userId: FirebaseAuth.instance.currentUser!.uid,
      conversationId: conversationId,
      createdAt: _time,
      attachments: attachments,
    );

    try {
      await FirebaseConstants.messagesRef(conversationId)
          .child(_message.id)
          .set(_message.toMap());

      await FirebaseConstants.userChatsRef(
              FirebaseAuth.instance.currentUser!.uid)
          .child(conversationId)
          .update({
        'lastMessageTime': _time.millisecondsSinceEpoch,
      });

      await FirebaseConstants.userChatsRef(otherUserId)
          .child(conversationId)
          .update({
        'lastMessageTime': _time.millisecondsSinceEpoch,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
class GetConversationIdNotifier extends StateNotifier<ApiState<String>> {
  GetConversationIdNotifier() : super(const ApiState.initial());
 
 static Future<String?> getConversationId(String userId) async {
    String _chatId =
        FirebaseAuth.instance.currentUser!.uid.compareTo(userId) == 1
            ? "${FirebaseAuth.instance.currentUser!.uid}_$userId"
            : "${userId}_${FirebaseAuth.instance.currentUser!.uid}";

    return await FirebaseConstants.userChatsRef(
            FirebaseAuth.instance.currentUser!.uid)
        .child(_chatId)
        .onValue
        .first
        .then((value) => value.snapshot.value != null ? _chatId : null);
  }
}
class MarkAsReadNotifier extends StateNotifier<ApiState<String>> {
      MarkAsReadNotifier() : super(const ApiState.initial());
 
    static Future<bool> markAsRead(String chatId, String messageId) async {
    try {
      await FirebaseConstants.messagesRef(chatId).child(messageId).update({
        "isRead": true,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
  }

class ChatRepo {
  ChatRepo._();
    static Future<String?> createConversation(String userId) async {
    String _chatId =
        FirebaseAuth.instance.currentUser!.uid.compareTo(userId) == 1
            ? "${FirebaseAuth.instance.currentUser!.uid}_$userId"
            : "${userId}_${FirebaseAuth.instance.currentUser!.uid}";
    var _conversation = ConversationModel(
      id: _chatId,
      userIds: [FirebaseAuth.instance.currentUser!.uid, userId],
      lastMessageTime: DateTime.now(),
    );

    return await FirebaseConstants.userChatsRef(
            FirebaseAuth.instance.currentUser!.uid)
        .child(_conversation.id)
        .set(_conversation.toMap())
        .then((value) async {
      return await FirebaseConstants.userChatsRef(userId)
          .child(_conversation.id)
          .set(_conversation.toMap())
          .then((value) => _conversation.id);
    });
  }

    static Future<bool> createMessage(
      String conversationId, String? message, String otherUserId,
      [List<String>? attachments]) async {
    final _time = DateTime.now();
    var _message = MessageModel(
      id: _time.microsecondsSinceEpoch.toString(),
      message: message,
      userId: FirebaseAuth.instance.currentUser!.uid,
      conversationId: conversationId,
      createdAt: _time,
      attachments: attachments,
    );

    try {
      await FirebaseConstants.messagesRef(conversationId)
          .child(_message.id)
          .set(_message.toMap());

      await FirebaseConstants.userChatsRef(
              FirebaseAuth.instance.currentUser!.uid)
          .child(conversationId)
          .update({
        'lastMessageTime': _time.millisecondsSinceEpoch,
      });

      await FirebaseConstants.userChatsRef(otherUserId)
          .child(conversationId)
          .update({
        'lastMessageTime': _time.millisecondsSinceEpoch,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

    static Future<String?> getConversationId(String userId) async {
    String _chatId =
        FirebaseAuth.instance.currentUser!.uid.compareTo(userId) == 1
            ? "${FirebaseAuth.instance.currentUser!.uid}_$userId"
            : "${userId}_${FirebaseAuth.instance.currentUser!.uid}";

    return await FirebaseConstants.userChatsRef(
            FirebaseAuth.instance.currentUser!.uid)
        .child(_chatId)
        .onValue
        .first
        .then((value) => value.snapshot.value != null ? _chatId : null);
  }

    static Future<bool> markAsRead(String chatId, String messageId) async {
    try {
      await FirebaseConstants.messagesRef(chatId).child(messageId).update({
        "isRead": true,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

}
