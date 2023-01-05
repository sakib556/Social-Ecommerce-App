import 'package:badges/badges.dart' as badge;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/date_formatter.dart';
import 'package:protibeshi_app/models/chats/conversation_model.dart';
import 'package:protibeshi_app/providers/chat_provider.dart';
import 'package:protibeshi_app/translations/locale_keys.g.dart';
import 'package:protibeshi_app/views/custom_widgets/user_avatar.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';
import 'package:protibeshi_app/views/tabs/inbox/components/chat_page.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      //  var inbox = ; //Static function

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title:  Text(LocaleKeys.inbox.tr()),
            actions: [
              context.locale.languageCode == 'en' ? 
                TextButton(
                onPressed: () async => await (context.setLocale(const Locale('bn'))),
                child: const Text('বাংলা'))
                : TextButton(
                onPressed: () async => await (context.setLocale(const Locale('en'))),
                child: const Text('English')),
            ],
            //title: const Text("Inbox"),
          ),
          body: ref.watch(allChatIdsProvider).maybeMap(
                error: (_) => SomethingWentWrong(errorMessage: _.error),
                orElse: () => const Loading(),
                loaded: (_) {
                  if (_.data.isNotEmpty) {
                    return ChatListView(conversations: _.data);
                  } else {
                    return const Center(child: Text("No Chats"));
                  }
                },
              )),
    );
  }
}

class ChatListView extends StatelessWidget {
  final List<ConversationModel> conversations;

  const ChatListView({
    Key? key,
    required this.conversations,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    conversations.sort((a, b) => b.lastMessageTime.microsecondsSinceEpoch
        .compareTo(a.lastMessageTime.microsecondsSinceEpoch));

    return ListView(
      children: conversations.map((conversation) {
        return ChatListTile(conversation: conversation);
      }).toList(),
    );
  }
}

class ChatListTile extends ConsumerWidget {
  final ConversationModel conversation;
  const ChatListTile({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> _userIds = conversation.userIds;
    String _otherUserId = _userIds
        .firstWhere((id) => id != FirebaseAuth.instance.currentUser!.uid);

    return ref.watch(chatMessageProvider(conversation.id)).maybeMap(
        error: (_) => SomethingWentWrong(errorMessage: _.error),
        loaded: (_) => _.data.isEmpty
            ? const SizedBox()
            : UserBasicBuilder(
                userId: _otherUserId,
                builder: (context, userBasicModel, isOnline) {
                  //
                  final _unreadMessagesCount = _.data.where((element) {
                    if (element.userId == _otherUserId) {
                      return !element.isRead;
                    } else {
                      return false;
                    }
                  }).length;

                  //
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            conversationId: conversation.id,
                            otherUserId: _otherUserId,
                          ),
                        ),
                      );
                    },
                    title: Row(
                      children: [
                        UserAvatar(
                          userId: userBasicModel.id,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userBasicModel.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.subtitle2),
                              _.data.last.message == null
                                  ? Text("Attachments",
                                      style:
                                          Theme.of(context).textTheme.caption)
                                  : Text(
                                      _.data.last.userId ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? "You: ${_.data.last.message!}"
                                          : _.data.last.message!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormatter.toTime(_.data.last.createdAt),
                            style: Theme.of(context).textTheme.caption),
                        _unreadMessagesCount != 0
                            ? badge.Badge(
                                elevation: 0,
                                badgeColor:
                                    Theme.of(context).colorScheme.primary,
                                animationType: badge.BadgeAnimationType.slide,
                                badgeContent: Text(
                                  _unreadMessagesCount.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Theme.of(context).colorScheme.surface),
                                        //color: Colors.white),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  );
                },
              ),
        orElse: () => const Center(child: CircularProgressIndicator()));
  }
}
