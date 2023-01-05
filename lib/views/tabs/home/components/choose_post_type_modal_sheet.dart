import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/tabs/home/components/borrow/create_borrow_post_page_view.dart';

class ChoosePostTypeModalSheet extends StatelessWidget {
  const ChoosePostTypeModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _choosePostTypeList
            .map(
              (postType) => ListTile(
                title: Text(
                  postType.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  int _postNumber = _choosePostTypeList.indexOf(postType);
                  if (_postNumber == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateBorrowPostPageView(),
                        fullscreenDialog: true,
                      ),
                    );
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

List<ChoosePostTypeListItem> _choosePostTypeList = [
  ChoosePostTypeListItem(
    title: "I need something",
    subtitle: "Borrow anything from your neigbors",
  ),
  ChoosePostTypeListItem(
    title: "I'll provide something",
    subtitle: "Lend anything to your neigbors and get paid",
  ),
  ChoosePostTypeListItem(
    title: "Just post",
    subtitle: "Get any info from your neighbors",
  ),
  ChoosePostTypeListItem(
    title: "Report an incident",
    subtitle: "Let's inform each other if anything happens.",
  ),
];

class ChoosePostTypeListItem {
  final String title;
  final String subtitle;
  ChoosePostTypeListItem({
    required this.title,
    required this.subtitle,
  });
}
