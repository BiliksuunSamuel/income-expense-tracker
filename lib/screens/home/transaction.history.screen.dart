import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/transaction.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/datetime.separator.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/transaction.item.card.dart';
import 'package:ie_montrac/screens/home/transaction.details.screen.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  //initial state
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(0);
      _scrollController.addListener(_onScroll);
    });
    super.initState();
  }

  //handle load data
  void _loadData(int pageIndex) async {
    final controller = Get.find<TransactionController>();
    await Future.wait([
      controller.getAuthUser(),
      controller.getAllTransactions(pageIndex: pageIndex)
    ]);
  }

  void _onScroll() async {
    // Check if the scroll position has reached the bottom
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      var controller = Get.find<TransactionController>();
      var page = controller.page;
      var hasMore =
          controller.pageSize * controller.page < controller.totalCount;
      if (!hasMore) return;
      await controller.getAllTransactions(pageIndex: page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TransactionController(repository: Get.find()),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              _loadData(0);
            },
            child: AppView(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        const SliverAppBar(
                            pinned: true,
                            backgroundColor: Colors.white,
                            automaticallyImplyLeading: false,
                            title: AppHeaderTitle(
                              title: "Transaction History",
                            )),
                        SliverFillRemaining(
                          child: controller.allTransactions.isNotEmpty
                              ? ContentContainer(
                                  padding: Dimensions.getPadding(10),
                                  child: ListView.builder(
                                      controller: _scrollController,
                                      padding: EdgeInsets.zero,
                                      itemCount:
                                          controller.allTransactions.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        var item =
                                            controller.allTransactions[index];
                                        return Column(
                                          children: [
                                            //if two adjacent transactions have the same date, don't show the date
                                            if (index == 0 ||
                                                item.createdAt.day !=
                                                    controller
                                                        .allTransactions[
                                                            index - 1]
                                                        .createdAt
                                                        .day)
                                              DateTimeSeparator(
                                                  datetime: item.createdAt),
                                            TransactionItemCard(
                                              transaction: item,
                                              onPress: () {
                                                Get.to(
                                                    () =>
                                                        const TransactionDetailsScreen(),
                                                    arguments: {
                                                      "transactionId": item.id,
                                                      "transactionType":
                                                          item.type
                                                    });
                                              },
                                            )
                                          ],
                                        );
                                      }),
                                )
                              : const ContentContainer(
                                  child: Center(
                                    child: EmptyStateView(
                                      message: "No Transactions",
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: controller.loading,
                      child: const Loader(),
                    )
                  ],
                )),
          );
        });
  }
}
