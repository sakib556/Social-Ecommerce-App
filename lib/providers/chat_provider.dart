import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/chats/conversation_model.dart';
import 'package:protibeshi_app/models/chats/message_model.dart';
import 'package:protibeshi_app/state_notfiers/chat_notifier.dart';

//New Code
final allChatIdsProvider =
    StateNotifierProvider<ChatIDNotifier, ApiState<List<ConversationModel>>>(
        (ref) => ChatIDNotifier());
final chatMessageProvider = StateNotifierProvider.family
    .autoDispose<ChatMessageNotifier, ApiState<List<MessageModel>>, String>(
        (ref, chatID) => ChatMessageNotifier(chatID));
//
final createConversationProvider =  StateNotifierProvider <CreateConversationNotifier,ApiState<String>>(
        (ref) => CreateConversationNotifier());
final createMessageProvider =  StateNotifierProvider<CreateMessageNotifier,ApiState<String>>(
        (ref) => CreateMessageNotifier());
final getConversationIdProvider = StateNotifierProvider<GetConversationIdNotifier,ApiState<String>>(
        (ref) => GetConversationIdNotifier());
final markAsReadProvider = StateNotifierProvider<MarkAsReadNotifier, ApiState<String>>(
        (ref) => MarkAsReadNotifier());
