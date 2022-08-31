import 'package:goplus/gofly/pages/cancel_ride_screen.dart';
import 'package:goplus/gofly/pages/drawer/destination_screen.dart';
import 'package:goplus/gofly/pages/messages/messages_screens.dart';
import 'package:goplus/gofly/pages/drawer/notification_screen.dart';
import 'package:goplus/gofly/pages/drawer/your_ride_screen.dart';
import 'package:goplus/gofly/pages/payment/payment_details_screen.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<CancelRideScreen>(() => CancelRideScreen());
    register<DestinationScreen>(() => DestinationScreen());
    register<PaymentDetailsScreen>(() => PaymentDetailsScreen());
    register<MessagesScreen>(() => MessagesScreen());
    register<NotificationsScreen>(() => NotificationsScreen());
    register<YourRidesScreen>(() => YourRidesScreen());
  }

  static dynamic fromString(String type) {
    return _constructors[type]!();
  }
}
