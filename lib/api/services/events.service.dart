import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/constants/keys.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';
import 'package:ie_montrac/utils/utilities.dart';
import 'package:socket_io_client/socket_io_client.dart' as SocketIo;

import '../repositories/repository.dart';

class EventsService {
  static late SocketIo.Socket socket;

  static void connect() {
    socket.connect();
  }

  static void disconnect() {
    socket.disconnect();
  }

  //emit new sign in event
  static void signInEvent(String userId, String tokenId) {
    socket.emit('signIn', {'userId': userId, 'tokenId': tokenId});
  }

  //emit new sign out event
  static void signOutEvent(String userId) {
    socket.emit('sign_out', userId);
  }

  //emit new transaction event
  static void transactionEvent(String userId) {
    socket.emit('transaction', userId);
  }

  //emit new budget event
  static void budgetEvent(String userId) {
    socket.emit('budget', userId);
  }

  //emit new category event
  static void categoryEvent(String userId) {
    socket.emit('category', userId);
  }

  //emit new expense event
  static void expenseEvent(String userId) {
    socket.emit('expense', userId);
  }

  //emit new income event
  static void incomeEvent(String userId) {
    socket.emit('income', userId);
  }

  //emit new report event
  static void reportEvent(String userId) {
    socket.emit('report', userId);
  }

  //check login details on receive of sign in event
  static void handleSignInEvent(String userId, String tokenId) async {
    var repository = Get.find<Repository>();
    var authUser = await repository.getAuthUser();
    if (authUser?.user == null) return;

    if (userId.equals(authUser?.user?.id) &&
        !tokenId.equals(authUser?.user?.tokenId)) {
      if (kDebugMode) {
        print("User signed in from another device,logging out");
      }
      await repository.removeFromLocalStorage(Keys.User);
      return Get.off(() => const WelcomeScreen(),
          transition: Transition.fadeIn);
    }
  }
}
