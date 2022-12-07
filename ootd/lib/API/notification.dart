import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static void initializeNotificationService() {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: "basic_channel_key",
        channelName: "Basic Channel",
        channelDescription: "카카오 입사 예정자들",
        channelShowBadge: true,
        defaultColor: Colors.deepPurple,
        enableLights: true,
        enableVibration: true,
        //setting this to high or max will cause the notification to drop down from the top
        importance: NotificationImportance.Max,
        //Use the sound we added to the folders just now,
      )
    ]);
  }

  //Methods for creating notifications
  Future<void> createBasicNotification() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          //The id should be unique
            id: 10,
            channelKey: 'basic_channel_key',
            title: '오늘 뭐 입지?! ${Emojis.smile_smirking_face}',
            body: '날씨가 많이 추워졌네요.\n 뭘 입어야 할지 모르시겠죠?'));
  }

  Future<void> createPictureNotification() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          //The id should be unique
            id: 12,
            channelKey: 'basic_channel_key',
            title: '오늘 뭐 입지?! ${Emojis.smile_smirking_face}',
            body: '날씨가 많이 추워졌네요.\n 뭘 입어야 할지 모르시겠죠?',
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture:
            "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"));
  }

  Future<void> createScheduledNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        //The id should be unique
        id: 13,
        channelKey: 'basic_channel_key',
        title: '오늘 뭐 입지?! 예약된 알림이에요. ${Emojis.smile_smirking_face}',
        body: '날씨가 많이 추워졌네요.\n 뭘 입어야 할지 모르시겠죠?',
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
        "https://images.pexels.com/photos/2058911/pexels-photo-2058911.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      ),
      schedule: NotificationInterval(
        interval: 60,
        repeats: false,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
    );
  }

  Future<void> cleareAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  @override
  void onInit() {
    super.onInit();
    //Request permission from user to show notifications
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    //Clear badge on controller init as well
    AwesomeNotifications()
        .getGlobalBadgeCounter()
        .then((value) => AwesomeNotifications().setGlobalBadgeCounter(0));

    //Listen to different actions
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {
      //We can do stuff like route to a different screen
      //On IOS, the badge count will not decrease by itself, we have to do it here
      AwesomeNotifications()
          .getGlobalBadgeCounter()
          .then((value) => AwesomeNotifications().setGlobalBadgeCounter(0));
    });
    AwesomeNotifications()
        .createdStream
        .listen((ReceivedNotification receivedNotification) {
      //We will display a snackbar to here
      Get.snackbar(
        "Notification Created",
        "A notification was created just now for channel ${receivedNotification.channelKey}",
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  @override
  void onClose() {
    super.onClose();
//Close streams
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
  }
}