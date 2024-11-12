import 'package:flutter/material.dart';

import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class NoDataView extends StatelessWidget {
  final String? message;
  final RefreshCallback? handleRefresh;
  const NoDataView({super.key, this.message, this.handleRefresh});

  @override
  Widget build(BuildContext context) {
    return handleRefresh != null
        ? RefreshIndicator(
            onRefresh: handleRefresh!,
            child: Container(
                padding: EdgeInsets.all(Dimensions.getPadding(10)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: Dimensions.getIconSize(150),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      SizedBox(
                        height: Dimensions.getHeight(5),
                      ),
                      Text(
                        message ?? "Nothing to show here!",
                        style: AppFontSize.fontSizeTitle()
                            .copyWith(color: Colors.grey.withOpacity(0.85)),
                      )
                    ],
                  ),
                )))
        : Container(
            padding: EdgeInsets.all(Dimensions.getPadding(10)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: Dimensions.getIconSize(150),
                    color: Colors.grey.withOpacity(0.15),
                  ),
                  SizedBox(
                    height: Dimensions.getHeight(5),
                  ),
                  Text(
                    message ?? "Nothing to show here!",
                    style: AppFontSize.fontSizeTitle()
                        .copyWith(color: Colors.grey.withOpacity(0.85)),
                  )
                ],
              ),
            ));
  }
}
