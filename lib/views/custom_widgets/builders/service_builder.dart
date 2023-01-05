import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/listing/category/service_model.dart';
import 'package:protibeshi_app/providers/catgory_provider.dart';

class ServiceBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<ServiceModel> userServices) builder;
  const ServiceBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getServiceProvider).maybeMap(
        orElse: () =>  Container(),
        error: (_) =>  Center(child:Text("error is: ${_.error}")),
        loaded: (list) {
          return builder(context,list.data);
        });
  }
}
