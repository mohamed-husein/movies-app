import 'package:flutter/material.dart';
import '../../../model/crew_model.dart';

import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/custom_text.dart';

class CrewWidget extends StatelessWidget {
  const CrewWidget({super.key, required this.crew});

  final List<CrewModel> crew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: AppSizes.pW16),
      child: SizedBox(
        height: AppSizes.pH50,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: crew.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    ApiConstants.imageUrl(
                      crew[index].profilePath,
                    ),
                  ),
                  radius: AppSizes.br25,
                ),
                SizedBox(
                  width: AppSizes.pW6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      crew[index].department,
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      context: context,
                    ),
                    SizedBox(
                      height: AppSizes.pH4,
                    ),
                    CustomText.bodySmall(
                      crew[index].name,
                      context: context,
                    ),
                  ],
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: AppSizes.pW10,
            );
          },
        ),
      ),
    );
  }
}
