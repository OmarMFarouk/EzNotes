import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';

import '../../src/app_colors.dart';

class FilterTile extends StatefulWidget {
  const FilterTile({
    super.key,
  });

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  int angle = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(2),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list_alt,
                    color: AppColors.subTitleText,
                  ),
                  Text(
                    'Date modified',
                    style: TextStyle(
                        fontSize: 17,
                        color: AppColors.subTitleText,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const VerticalDivider(
              color: AppColors.titleText,
              width: 5,
              endIndent: 4,
              indent: 4,
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                BlocProvider.of<HomeCubit>(context).reArrange();
                setState(() {
                  angle == 2 ? angle = 0 : angle = 2;
                });
              },
              child: RotatedBox(
                quarterTurns: angle,
                child: const Icon(
                  Icons.keyboard_double_arrow_down,
                  color: AppColors.titleText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
