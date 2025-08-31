import 'package:get/get.dart';
import 'package:ie_montrac/screens/auth/forgot.password.screen.dart';
import 'package:ie_montrac/screens/auth/otp.verify.screen.dart';
import 'package:ie_montrac/screens/auth/reset.password.screen.dart';
import 'package:ie_montrac/screens/home/add.expense.screen.dart';
import 'package:ie_montrac/screens/home/add.income.screen.dart';
import 'package:ie_montrac/screens/home/budget.edit.screen.dart';
import 'package:ie_montrac/screens/home/budget.screen.dart';
import 'package:ie_montrac/screens/home/edit.expense.screen.dart';
import 'package:ie_montrac/screens/home/edit.income.screen.dart';
import 'package:ie_montrac/screens/home/financial.report.screen.dart';
import 'package:ie_montrac/screens/home/invoices.screen.dart';
import 'package:ie_montrac/screens/home/profile/currency.update.screen.dart';
import 'package:ie_montrac/screens/home/profile/profile.screen.dart';
import 'package:ie_montrac/screens/home/subscription.details.screen.dart';
import 'package:ie_montrac/screens/home/subscription.screen.dart';
import 'package:ie_montrac/screens/home/transaction.details.screen.dart';
import 'package:ie_montrac/screens/home/transaction.history.screen.dart';
import 'package:ie_montrac/screens/home/transactions.screen.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';

import '../screens/auth/auth.screen.dart';
import '../screens/home/home.screen.dart';
import '../screens/home/invoice.details.screen.dart';

class AppRoutes {
  static const String home = '/';
  static const welcomeScreen = "/welcome";
  static const String transactionsScreen = '/transactions';
  static const String profileScreen = '/profile';
  static const String transactionHistoryScreen = '/transaction-history';
  static const String budgetScreen = '/budget';
  static const String addIncomeScreen = '/add-income';
  static const String addExpenseScreen = '/add-expense';
  static const String editBudgetScreen = '/edit-budget';
  static const String editIncomeScreen = '/edit-income';
  static const String editExpenseScreen = '/edit-expense';
  static const String reportScreen = '/report';
  static const String transactionDetailsScreen = '/transaction-details';
  static const String addBudgetScreen = '/add-budget';
  static const String subscriptionsScreen = '/subscriptions';
  static const String currencyUpdateScreen = '/currency-update';
  static const String otpVerifyScreen = '/otp-verify';
  static const String authScreen = '/auth';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String resetPasswordScreen = '/reset-password';
  static const String subscriptionDetailsScreen = '/subscription-details';
  static const String invoicesScreen = '/invoices';
  static const String invoiceDetailsScreen = '/invoice-details';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: welcomeScreen, page: () => const WelcomeScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: transactionsScreen, page: () => const TransactionsScreen()),
    GetPage(
        name: transactionHistoryScreen,
        page: () => const TransactionHistoryScreen()),
    GetPage(name: budgetScreen, page: () => const BudgetScreen()),
    GetPage(name: addIncomeScreen, page: () => const AddIncomeScreen()),
    GetPage(name: addExpenseScreen, page: () => AddExpenseScreen()),
    GetPage(name: editBudgetScreen, page: () => BudgetEditScreen()),
    GetPage(name: editIncomeScreen, page: () => EditIncomeScreen()),
    GetPage(name: editExpenseScreen, page: () => EditExpenseScreen()),
    GetPage(name: reportScreen, page: () => const FinancialReportScreen()),
    GetPage(
        name: transactionDetailsScreen,
        page: () => const TransactionDetailsScreen()),
    GetPage(name: subscriptionsScreen, page: () => const SubscriptionScreen()),
    GetPage(
        name: currencyUpdateScreen, page: () => const CurrencyUpdateScreen()),
    GetPage(name: otpVerifyScreen, page: () => const OtpVerifyScreen()),
    GetPage(name: authScreen, page: () => const AuthScreen()),
    GetPage(
        name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(
        name: subscriptionDetailsScreen,
        page: () => const SubscriptionDetailsScreen()),
    GetPage(name: invoicesScreen, page: () => const InvoicesScreen()),
    GetPage(
        name: invoiceDetailsScreen, page: () => const InvoiceDetailsScreen()),
  ];
}
