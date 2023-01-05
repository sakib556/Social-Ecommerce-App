import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/models/chats/message_model.dart';
import 'package:protibeshi_app/providers/chat_provider.dart';
import 'package:protibeshi_app/state_notfiers/chat_notifier.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class ChatPage extends StatelessWidget {
  final String conversationId;
  final String otherUserId;
  const ChatPage({
    Key? key,
    required this.conversationId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          // backgroundColor: Theme.of(context).colorScheme.background,
          // foregroundColor: Theme.of(context).colorScheme.onBackground,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
          title: GestureDetector(
            onTap: () {
              //TODO: open user profile
            },
            child: UserBasicBuilder(
                userId: otherUserId,
                builder: (context, userBasicModel, isOnline) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userBasicModel.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(isOnline ? "Online" : "Offline",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    )),
          ),
        ),
        body: SafeArea(
            child: ChatBody(
          conversationId: conversationId,
          otherUserId: otherUserId,
        )),
      ),
    );
  }
}

class ChatBody extends ConsumerWidget {
  final String conversationId;
  final String otherUserId;
  const ChatBody({
    Key? key,
    required this.conversationId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final chatsMessages = ref.watch(chatMessageProvider(conversationId));
    return Column(
      children: [
        Expanded(
            child: chatsMessages.maybeMap(
                loaded: (_) => _.data.isNotEmpty
                    ? MessagesListView(
                        messages: _.data,
                        convId: conversationId,
                      )
                    : const Center(child: Text("Say HI")),
                orElse: () =>
                    const Center(child: CircularProgressIndicator()))),
        ChatBodyBottomTextField(
          conversationId: conversationId,
          otherUserId: otherUserId,
        ),
      ],
    );
  }
}

class ChatBodyBottomTextField extends StatefulWidget {
  final String conversationId;
  final String otherUserId;
  const ChatBodyBottomTextField({
    Key? key,
    required this.conversationId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  State<ChatBodyBottomTextField> createState() =>
      _ChatBodyBottomTextFieldState();
}

class _ChatBodyBottomTextFieldState extends State<ChatBodyBottomTextField> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onSend() async {
    if (_messageController.text.isEmpty) {
      return;
    } else {
      ChatRepo.createMessage(
        widget.conversationId,
        _messageController.text.trim(),
        widget.otherUserId,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                _onSend();
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 8, right: 8),
                // fillColor: Theme.of(context).scaffoldBackgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Type a message...',
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.send),
            onPressed: _onSend,
          ),
        ],
      ),
    );
  }
}

class MessagesListView extends StatelessWidget {
  final List<MessageModel> messages;
  final String convId;
  const MessagesListView({
    Key? key,
    required this.messages,
    required this.convId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StickyGroupedListView<MessageModel, DateTime>(
      padding: const EdgeInsets.all(8),
      reverse: messages.length > 1 ? true : false,
      elements: messages,
      order: StickyGroupedListOrder.ASC,
      groupBy: (MessageModel element) => DateTime(element.createdAt.year,
          element.createdAt.month, element.createdAt.day),
      groupComparator: (DateTime value1, DateTime value2) =>
          value2.compareTo(value1),
      itemComparator: (MessageModel element1, MessageModel element2) =>
          element2.createdAt.compareTo(element1.createdAt),
      floatingHeader: true,
      groupSeparatorBuilder: (MessageModel element) => SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.12),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                DateFormatter.toMonthDay(element.createdAt),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 10,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.72)),
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (_, MessageModel element) {
        return SingleMessageTile(
            convId: convId,
            message: element,
            previousMessage: messages.indexOf(element) != 0
                ? messages[messages.indexOf(element) - 1]
                : null);
      },
    );
  }
}

class SingleMessageTile extends StatelessWidget {
  final MessageModel message;
  final MessageModel? previousMessage;
  final String convId;
  const SingleMessageTile({
    Key? key,
    required this.message,
    this.previousMessage,
    required this.convId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isMe = message.userId == FirebaseAuth.instance.currentUser!.uid;

    if (!message.isRead) {
      if (!_isMe) {
        ChatRepo.markAsRead(convId, message.id);
      }
    }
    const double _radius = 12.0;

    return Column(
      children: [
        Align(
          alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: _isMe
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.24)
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                  bottomLeft: _isMe
                      ? const Radius.circular(_radius)
                      : const Radius.circular(0),
                  bottomRight: _isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(_radius),
                  topLeft: const Radius.circular(_radius),
                  topRight: const Radius.circular(_radius)),
            ),
            margin: previousMessage != null
                ? previousMessage!.createdAt
                            .difference(message.createdAt)
                            .inMinutes >
                        15
                    ? const EdgeInsets.only(top: 2, bottom: 16)
                    : const EdgeInsets.symmetric(vertical: 2)
                : const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 48,
                    bottom: 6,
                    top: 4,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    child: Text(message.message!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(DateFormatter.toTime(message.createdAt),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 10,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.72),
                          )),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}




// Container(
//         alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
//         margin: const EdgeInsets.all(4),
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//         width: MediaQuery.of(context).size.width * 0.7,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment:
//               _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(message.message!,
//                 textAlign: TextAlign.start,
//                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     )),
//             const SizedBox(height: 8),
//             Text(DateFormatter.toTime(message.createdAt),
//                 style: Theme.of(context).textTheme.caption!.copyWith(
//                       color: Theme.of(context)
//                           .colorScheme
//                           .onBackground
//                           .withOpacity(0.72),
//                     ))
//           ],
//         ),
//         decoration: BoxDecoration(
//           color: _isMe
//               ? Theme.of(context).colorScheme.primary.withOpacity(0.38)
//               : Theme.of(context).colorScheme.background,
//           borderRadius: BorderRadius.only(
//             bottomLeft: _isMe ? const Radius.circular(16) : Radius.zero,
//             bottomRight: _isMe ? Radius.zero : const Radius.circular(16),
//             topLeft: const Radius.circular(16),
//             topRight: const Radius.circular(16),
//           ),
//         ),
//       )