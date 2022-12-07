import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ootd/screen/mainScreen.dart';
import 'package:ootd/model/model.dart';
class PushNoti {

  Future<void> CallNotification()async{
    await AwesomeNotifications().createNotification(content:
    NotificationContent(id: 1, channelKey: 'channelKey',
      title: '${Emojis.money_coin}',
      body: 'asdasd',
    ),
    );
  }
}
