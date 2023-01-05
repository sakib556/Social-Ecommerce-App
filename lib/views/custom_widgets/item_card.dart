import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.details,
      required this.onTapped})
      : super(key: key);
  final String imageUrl;
  final String title;
  final String details;
  final VoidCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 150,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        // elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            onTapped();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ink.image(
              //   image: NetworkImage(
              //     imageUrl,
              //   ),
              //   height: 120,
              //   width: 150,
              //   fit: BoxFit.cover,
              // ),
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      height: 120,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image_outlined, size: 120),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(title, overflow: TextOverflow.ellipsis)),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    details,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
