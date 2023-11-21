
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flavourfleet/application/home/home_provider.dart';
import 'package:flavourfleet/presentation/components/app_bars/common_app_bar.dart';
import 'package:flavourfleet/presentation/components/buttons/pop_button.dart';
import 'package:flavourfleet/presentation/theme/app_style.dart';

import 'filter_category_service.dart';

class ServiceTwoCategoryPage extends ConsumerWidget {
  final int index;
  const ServiceTwoCategoryPage({super.key, required this.index});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final title = state.selectIndexCategory != -1
        ? state.categories[state.selectIndexCategory].translation?.title
        : "";
    return WillPopScope(
      onWillPop: (){
        notifier.setSelectCategory(-1, context);
        // context.popRoute();
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          children: [
            CommonAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    style: Style.interNormal(size: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FilterCategoryService(
                state: state,
                event: notifier,
                categoryIndex: index,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: const PopButton(),
      ),
    );
  }
}
