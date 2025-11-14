import 'package:auth_sample/core/constants/app_icons.dart';
import 'package:auth_sample/core/design_system/widgets/app_bar.dart';
import 'package:auth_sample/core/design_system/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_strings.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackButtonBar(),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.thankYouForChoosingWorkiom,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  WidgetSpan(child: SizedBox(width: 8)),
                  WidgetSpan(child: SvgPicture.asset(AppIcons.symbol)),
                ],
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}