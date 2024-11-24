import 'package:flutter/material.dart';
import 'package:ie_montrac/models/Transaction.dart';

import '../components/transaction.card.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class GroupedTransactionsSection extends StatelessWidget {
  final String title;
  final List<Transaction> transactions;
  const GroupedTransactionsSection(
      {super.key, required this.title, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppFontSize.fontSizeTitle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.getHeight(10),
        ),
        ListView.builder(
            itemCount: transactions.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, index) {
              var item = transactions[index];
              return TransactionCard(item: item);
            }),
      ],
    );
  }
}
