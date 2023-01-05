import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/listing/category/teaching_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';

class TeachingBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<TeachingModel> userServices) builder;
  const TeachingBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTeachingProvider).maybeMap(
        orElse: () => Container(),
        error: (_) =>  Center(child:Text("error is: ${_.error}")),
        loaded: (list) {
          return builder(context,list.data);
        });
  }
}
