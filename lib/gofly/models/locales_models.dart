import 'dart:convert';

LocaleModel localeModelFromJson(String str) =>
    LocaleModel.fromJson(json.decode(str));

String localeModelToJson(LocaleModel data) => json.encode(data.toJson());

class LocaleModel {
  LocaleModel({
    this.chooseLang,
    this.introScreen,
    this.loginScreen,
    this.forgotPasswordScreen,
    this.signupScreen,
    this.enterPhoneScreen,
    this.verifyPhoneScreen,
    this.destinationScreen,
    this.setPickupTimeScreen,
    this.searchPlaceScreen,
    this.paymentOptionScreen,
    this.paymentScreen,
    this.paymentDetailsScreen,
    this.cancelRideScreen,
    this.reviewScreen,
    this.myProfileScreen,
    this.yourRideScreen,
    this.notificationScreen,
    this.chatsScreen,
    this.drawerScreen,
  });

  final String? chooseLang;
  final IntroModel? introScreen;
  final LoginModel? loginScreen;
  final ForgotPasswordModel? forgotPasswordScreen;
  final SignupModel? signupScreen;
  final EnterPhoneModel? enterPhoneScreen;
  final VerifyPhoneModel? verifyPhoneScreen;
  final DestinationModel? destinationScreen;
  final SetPickupTimeModel? setPickupTimeScreen;
  final SearchPlaceModel? searchPlaceScreen;
  final PaymentOptionModel? paymentOptionScreen;
  final PaymentModel? paymentScreen;
  final PaymentDetailsModel? paymentDetailsScreen;
  final CancelRideModel? cancelRideScreen;
  final ReviewModel? reviewScreen;
  final MyProfileModel? myProfileScreen;
  final YourRideModel? yourRideScreen;
  final NotificationModel? notificationScreen;
  final ChatsModel? chatsScreen;
  final DrawerModel? drawerScreen;

  factory LocaleModel.fromJson(Map<String, dynamic> json) => LocaleModel(
        chooseLang: json["choose_lang"],
        introScreen: IntroModel.fromJson(json["intro_screen"]),
        loginScreen: LoginModel.fromJson(json["login_screen"]),
        forgotPasswordScreen:
            ForgotPasswordModel.fromJson(json["forgot_password_screen"]),
        signupScreen: SignupModel.fromJson(json["signup_screen"]),
        enterPhoneScreen: EnterPhoneModel.fromJson(json["enter_phone_screen"]),
        verifyPhoneScreen:
            VerifyPhoneModel.fromJson(json["verify_phone_screen"]),
        destinationScreen:
            DestinationModel.fromJson(json["destination_screen"]),
        setPickupTimeScreen:
            SetPickupTimeModel.fromJson(json["set_pickup_time_screen"]),
        searchPlaceScreen:
            SearchPlaceModel.fromJson(json["search_place_screen"]),
        paymentOptionScreen:
            PaymentOptionModel.fromJson(json["payment_option_screen"]),
        paymentScreen: PaymentModel.fromJson(json["payment_screen"]),
        paymentDetailsScreen:
            PaymentDetailsModel.fromJson(json["payment_details_screen"]),
        cancelRideScreen: CancelRideModel.fromJson(json["cancel_ride_screen"]),
        reviewScreen: ReviewModel.fromJson(json["review_screen"]),
        myProfileScreen: MyProfileModel.fromJson(json["my_profile_screen"]),
        yourRideScreen: YourRideModel.fromJson(json["your_ride_screen"]),
        notificationScreen:
            NotificationModel.fromJson(json["notification_screen"]),
        chatsScreen: ChatsModel.fromJson(json["chats_screen"]),
        drawerScreen: DrawerModel.fromJson(json["drawer_screen"]),
      );

  Map<String, dynamic> toJson() => {
        "choose_lang": chooseLang,
        "intro_screen": introScreen!.toJson(),
        "login_screen": loginScreen!.toJson(),
        "forgot_password_screen": forgotPasswordScreen!.toJson(),
        "signup_screen": signupScreen!.toJson(),
        "enter_phone_screen": enterPhoneScreen!.toJson(),
        "verify_phone_screen": verifyPhoneScreen!.toJson(),
        "destination_screen": destinationScreen!.toJson(),
        "set_pickup_time_screen": setPickupTimeScreen!.toJson(),
        "search_place_screen": searchPlaceScreen!.toJson(),
        "payment_option_screen": paymentOptionScreen!.toJson(),
        "payment_screen": paymentScreen!.toJson(),
        "payment_details_screen": paymentDetailsScreen!.toJson(),
        "cancel_ride_screen": cancelRideScreen!.toJson(),
        "review_screen": reviewScreen!.toJson(),
        "my_profile_screen": myProfileScreen!.toJson(),
        "your_ride_screen": yourRideScreen!.toJson(),
        "notification_screen": notificationScreen!.toJson(),
        "chats_screen": chatsScreen!.toJson(),
        "drawer_screen": drawerScreen!.toJson(),
      };
}

class CancelRideModel {
  CancelRideModel({
    required this.dropOff,
    required this.distance,
    required this.price,
    required this.trackRide,
    required this.cancelRide,
  });

  final String dropOff;
  final String distance;
  final String price;
  final String trackRide;
  final String cancelRide;

  factory CancelRideModel.fromJson(Map<String, dynamic> json) =>
      CancelRideModel(
        dropOff: json["drop_off"],
        distance: json["distance"],
        price: json["price"],
        trackRide: json["track_ride"],
        cancelRide: json["cancel_ride"],
      );

  Map<String, dynamic> toJson() => {
        "drop_off": dropOff,
        "distance": distance,
        "price": price,
        "track_ride": trackRide,
        "cancel_ride": cancelRide,
      };
}

class ChatsModel {
  ChatsModel({
    required this.typeMessage,
  });

  final String typeMessage;

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
        typeMessage: json["type_message"],
      );

  Map<String, dynamic> toJson() => {
        "type_message": typeMessage,
      };
}

class DestinationModel {
  DestinationModel({
    required this.whereGoing,
    required this.bodyWhereGoing,
    required this.enterDestination,
  });

  final String whereGoing;
  final String bodyWhereGoing;
  final String enterDestination;

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        whereGoing: json["where_going"],
        bodyWhereGoing: json["body_where_going"],
        enterDestination: json["enter_destination"],
      );

  Map<String, dynamic> toJson() => {
        "where_going": whereGoing,
        "body_where_going": bodyWhereGoing,
        "enter_destination": enterDestination,
      };
}

class DrawerModel {
  DrawerModel({
    required this.home,
    required this.yourRide,
    required this.payment,
    required this.message,
    required this.notification,
    required this.settings,
    required this.logout,
  });

  final String home;
  final String yourRide;
  final String payment;
  final String message;
  final String notification;
  final String settings;
  final String logout;

  factory DrawerModel.fromJson(Map<String, dynamic> json) => DrawerModel(
        home: json["home"],
        yourRide: json["your_ride"],
        payment: json["payment"],
        message: json["message"],
        notification: json["notification"],
        settings: json["settings"],
        logout: json["logout"],
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "your_ride": yourRide,
        "payment": payment,
        "message": message,
        "notification": notification,
        "settings": settings,
        "logout": logout,
      };
}

class EnterPhoneModel {
  EnterPhoneModel({
    required this.enterPhoneNum,
    required this.phoneNumError,
    required this.enterPhoneBody,
    required this.enterPhoneNumTwo,
    required this.sendCode,
  });

  final String enterPhoneNum;
  final String phoneNumError;
  final String enterPhoneBody;
  final String enterPhoneNumTwo;
  final String sendCode;

  factory EnterPhoneModel.fromJson(Map<String, dynamic> json) =>
      EnterPhoneModel(
        enterPhoneNum: json["enter_phone_num"],
        phoneNumError: json["phone_num_error"],
        enterPhoneBody: json["enter_phone_body"],
        enterPhoneNumTwo: json["enter_phone_num_two"],
        sendCode: json["send_code"],
      );

  Map<String, dynamic> toJson() => {
        "enter_phone_num": enterPhoneNum,
        "phone_num_error": phoneNumError,
        "enter_phone_body": enterPhoneBody,
        "enter_phone_num_two": enterPhoneNumTwo,
        "send_code": sendCode,
      };
}

class ForgotPasswordModel {
  ForgotPasswordModel({
    required this.forgetPassTitle,
    required this.forgotPassBody,
    required this.enterEmailOrPhone,
    required this.enterEmailOrPhoneError,
    required this.send,
  });

  final String forgetPassTitle;
  final String forgotPassBody;
  final String enterEmailOrPhone;
  final String enterEmailOrPhoneError;
  final String send;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        forgetPassTitle: json["forget_pass_title"],
        forgotPassBody: json["forgot_pass_body"],
        enterEmailOrPhone: json["enter_email_or_phone"],
        enterEmailOrPhoneError: json["enter_email_or_phone_error"],
        send: json["send"],
      );

  Map<String, dynamic> toJson() => {
        "forget_pass_title": forgetPassTitle,
        "forgot_pass_body": forgotPassBody,
        "enter_email_or_phone": enterEmailOrPhone,
        "enter_email_or_phone_error": enterEmailOrPhoneError,
        "send": send,
      };
}

class IntroModel {
  IntroModel({
    required this.titleLocateDesti,
    required this.bodyLocateDesti,
    required this.titleSelectYourRoot,
    required this.bodySelectYourRoot,
    required this.titleGetYourTexi,
    required this.bodyGetYourTexi,
    required this.startBtn,
  });

  final String titleLocateDesti;
  final String bodyLocateDesti;
  final String titleSelectYourRoot;
  final String bodySelectYourRoot;
  final String titleGetYourTexi;
  final String bodyGetYourTexi;
  final String startBtn;

  factory IntroModel.fromJson(Map<String, dynamic> json) => IntroModel(
        titleLocateDesti: json["title_locate_desti"],
        bodyLocateDesti: json["body_locate_desti"],
        titleSelectYourRoot: json["title_select_your_root"],
        bodySelectYourRoot: json["body_select_your_root"],
        titleGetYourTexi: json["title_get_your_texi"],
        bodyGetYourTexi: json["body_get_your_texi"],
        startBtn: json["start_btn"],
      );

  Map<String, dynamic> toJson() => {
        "title_locate_desti": titleLocateDesti,
        "body_locate_desti": bodyLocateDesti,
        "title_select_your_root": titleSelectYourRoot,
        "body_select_your_root": bodySelectYourRoot,
        "title_get_your_texi": titleGetYourTexi,
        "body_get_your_texi": bodyGetYourTexi,
        "start_btn": startBtn,
      };
}

class LoginModel {
  LoginModel({
    required this.welcome,
    required this.welcomeBody,
    required this.emailError,
    required this.passwordError,
    required this.forgotPassword,
    required this.login,
    required this.dontHaveAccount,
  });

  final String welcome;
  final String welcomeBody;
  final String emailError;
  final String passwordError;
  final String forgotPassword;
  final String login;
  final String dontHaveAccount;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        welcome: json["welcome"],
        welcomeBody: json["welcome_body"],
        emailError: json["email_error"],
        passwordError: json["password_error"],
        forgotPassword: json["forgot_password"],
        login: json["login"],
        dontHaveAccount: json["dont_have_account"],
      );

  Map<String, dynamic> toJson() => {
        "welcome": welcome,
        "welcome_body": welcomeBody,
        "email_error": emailError,
        "password_error": passwordError,
        "forgot_password": forgotPassword,
        "login": login,
        "dont_have_account": dontHaveAccount,
      };
}

class MyProfileModel {
  MyProfileModel({
    required this.myProfile,
    required this.firstName,
    required this.firstNameError,
    required this.lastName,
    required this.lastNameError,
    required this.phoneNum,
    required this.phoneNumError,
    required this.emailAddress,
    required this.emailAddressError,
    required this.password,
    required this.passwordError,
    required this.save,
  });

  final String myProfile;
  final String firstName;
  final String firstNameError;
  final String lastName;
  final String lastNameError;
  final String phoneNum;
  final String phoneNumError;
  final String emailAddress;
  final String emailAddressError;
  final String password;
  final String passwordError;
  final String save;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
        myProfile: json["my_profile"],
        firstName: json["first_name"],
        firstNameError: json["first_name_error"],
        lastName: json["last_name"],
        lastNameError: json["last_name_error"],
        phoneNum: json["phone_num"],
        phoneNumError: json["phone_num_error"],
        emailAddress: json["email_address"],
        emailAddressError: json["email_address_error"],
        password: json["password"],
        passwordError: json["password_error"],
        save: json["save"],
      );

  Map<String, dynamic> toJson() => {
        "my_profile": myProfile,
        "first_name": firstName,
        "first_name_error": firstNameError,
        "last_name": lastName,
        "last_name_error": lastNameError,
        "phone_num": phoneNum,
        "phone_num_error": phoneNumError,
        "email_address": emailAddress,
        "email_address_error": emailAddressError,
        "password": password,
        "password_error": passwordError,
        "save": save,
      };
}

class NotificationModel {
  NotificationModel({
    required this.notificaitons,
    required this.wantsToShareCab,
  });

  final String notificaitons;
  final String wantsToShareCab;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificaitons: json["notificaitons"],
        wantsToShareCab: json["wants_to_share_cab"],
      );

  Map<String, dynamic> toJson() => {
        "notificaitons": notificaitons,
        "wants_to_share_cab": wantsToShareCab,
      };
}

class PaymentDetailsModel {
  PaymentDetailsModel({
    required this.paymentDetails,
    required this.paymentDate,
    required this.paymentMethod,
    required this.paymentHistory,
    required this.to,
    required this.fullDetails,
    required this.youSpend,
    required this.onThisMon,
    required this.all,
    required this.wantsToShareCab,
  });

  final String paymentDetails;
  final String paymentDate;
  final String paymentMethod;
  final String paymentHistory;
  final String to;
  final String fullDetails;
  final String youSpend;
  final String onThisMon;
  final String all;
  final String wantsToShareCab;

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsModel(
        paymentDetails: json["payment_details"],
        paymentDate: json["payment_date"],
        paymentMethod: json["payment_method"],
        paymentHistory: json["payment_history"],
        to: json["to"],
        fullDetails: json["full_details"],
        youSpend: json["you_spend"],
        onThisMon: json["on_this_mon"],
        all: json["all"],
        wantsToShareCab: json["wants_to_share_cab"],
      );

  Map<String, dynamic> toJson() => {
        "payment_details": paymentDetails,
        "payment_date": paymentDate,
        "payment_method": paymentMethod,
        "payment_history": paymentHistory,
        "to": to,
        "full_details": fullDetails,
        "you_spend": youSpend,
        "on_this_mon": onThisMon,
        "all": all,
        "wants_to_share_cab": wantsToShareCab,
      };
}

class PaymentOptionModel {
  PaymentOptionModel({
    required this.cash,
    required this.paymentMethod,
    required this.payWithMaster,
    required this.payWithPaypal,
    required this.payWithVisa,
    required this.bookRide,
  });

  final String cash;
  final String paymentMethod;
  final String payWithMaster;
  final String payWithPaypal;
  final String payWithVisa;
  final String bookRide;

  factory PaymentOptionModel.fromJson(Map<String, dynamic> json) =>
      PaymentOptionModel(
        cash: json["cash"],
        paymentMethod: json["payment_method"],
        payWithMaster: json["pay_with_master"],
        payWithPaypal: json["pay_with_paypal"],
        payWithVisa: json["pay_with_visa"],
        bookRide: json["book_ride"],
      );

  Map<String, dynamic> toJson() => {
        "cash": cash,
        "payment_method": paymentMethod,
        "pay_with_master": payWithMaster,
        "pay_with_paypal": payWithPaypal,
        "pay_with_visa": payWithVisa,
        "book_ride": bookRide,
      };
}

class PaymentModel {
  PaymentModel({
    required this.addCreditCard,
    required this.scanCard,
    required this.cardHolderName,
    required this.cardHolderNameError,
    required this.cardNum,
    required this.cardNumError,
    required this.save,
  });

  final String addCreditCard;
  final String scanCard;
  final String cardHolderName;
  final String cardHolderNameError;
  final String cardNum;
  final String cardNumError;
  final String save;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        addCreditCard: json["add_credit_card"],
        scanCard: json["scan_card"],
        cardHolderName: json["card_holder_name"],
        cardHolderNameError: json["card_holder_name_error"],
        cardNum: json["card_num"],
        cardNumError: json["card_num_error"],
        save: json["save"],
      );

  Map<String, dynamic> toJson() => {
        "add_credit_card": addCreditCard,
        "scan_card": scanCard,
        "card_holder_name": cardHolderName,
        "card_holder_name_error": cardHolderNameError,
        "card_num": cardNum,
        "card_num_error": cardNumError,
        "save": save,
      };
}

class ReviewModel {
  ReviewModel({
    required this.howYourTrip,
    required this.howYourTripBody,
    required this.addComment,
    required this.submitReview,
  });

  final String howYourTrip;
  final String howYourTripBody;
  final String addComment;
  final String submitReview;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        howYourTrip: json["how_your_trip"],
        howYourTripBody: json["how_your_trip_body"],
        addComment: json["add_comment"],
        submitReview: json["submit_review"],
      );

  Map<String, dynamic> toJson() => {
        "how_your_trip": howYourTrip,
        "how_your_trip_body": howYourTripBody,
        "add_comment": addComment,
        "submit_review": submitReview,
      };
}

class SearchPlaceModel {
  SearchPlaceModel({
    required this.searchPlaceText,
    required this.whereYouGo,
    required this.yourPlace,
    required this.home,
    required this.homeAddress,
    required this.homeAddressError,
    required this.office,
    required this.officeAddress,
    required this.officeAddressError,
    required this.addPlace,
    required this.searchPlaceHere,
    required this.savePlace,
  });

  final String searchPlaceText;
  final String whereYouGo;
  final String yourPlace;
  final String home;
  final String homeAddress;
  final String homeAddressError;
  final String office;
  final String officeAddress;
  final String officeAddressError;
  final String addPlace;
  final String searchPlaceHere;
  final String savePlace;

  factory SearchPlaceModel.fromJson(Map<String, dynamic> json) =>
      SearchPlaceModel(
        searchPlaceText: json["search_place_text"],
        whereYouGo: json["where_you_go"],
        yourPlace: json["your_place"],
        home: json["home"],
        homeAddress: json["home_address"],
        homeAddressError: json["home_address_error"],
        office: json["office"],
        officeAddress: json["office_address"],
        officeAddressError: json["office_address_error"],
        addPlace: json["add_place"],
        searchPlaceHere: json["search_place_here"],
        savePlace: json["save_place"],
      );

  Map<String, dynamic> toJson() => {
        "search_place_text": searchPlaceText,
        "where_you_go": whereYouGo,
        "your_place": yourPlace,
        "home": home,
        "home_address": homeAddress,
        "home_address_error": homeAddressError,
        "office": office,
        "office_address": officeAddress,
        "office_address_error": officeAddressError,
        "add_place": addPlace,
        "search_place_here": searchPlaceHere,
        "save_place": savePlace,
      };
}

class SetPickupTimeModel {
  SetPickupTimeModel({
    required this.scheduleRide,
    required this.setPickupTime,
  });

  final String scheduleRide;
  final String setPickupTime;

  factory SetPickupTimeModel.fromJson(Map<String, dynamic> json) =>
      SetPickupTimeModel(
        scheduleRide: json["schedule_ride"],
        setPickupTime: json["set_pickup_time"],
      );

  Map<String, dynamic> toJson() => {
        "schedule_ride": scheduleRide,
        "set_pickup_time": setPickupTime,
      };
}

class SignupModel {
  SignupModel({
    required this.signUp,
    required this.signUpBody,
    required this.fullName,
    required this.fullNameError,
    required this.email,
    required this.emailError,
    required this.password,
    required this.passwordError,
    required this.confirmPass,
    required this.confirmPassError,
    required this.signUpBtn,
    required this.or,
    required this.signUpWithGoogle,
  });

  final String signUp;
  final String signUpBody;
  final String fullName;
  final String fullNameError;
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final String confirmPass;
  final String confirmPassError;
  final String signUpBtn;
  final String or;
  final String signUpWithGoogle;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        signUp: json["sign_up"],
        signUpBody: json["sign_up_body"],
        fullName: json["full_name"],
        fullNameError: json["full_name_error"],
        email: json["email"],
        emailError: json["email_error"],
        password: json["password"],
        passwordError: json["password_error"],
        confirmPass: json["confirm_pass"],
        confirmPassError: json["confirm_pass_error"],
        signUpBtn: json["sign_up_btn"],
        or: json["or"],
        signUpWithGoogle: json["sign_up_with_google"],
      );

  Map<String, dynamic> toJson() => {
        "sign_up": signUp,
        "sign_up_body": signUpBody,
        "full_name": fullName,
        "full_name_error": fullNameError,
        "email": email,
        "email_error": emailError,
        "password": password,
        "password_error": passwordError,
        "confirm_pass": confirmPass,
        "confirm_pass_error": confirmPassError,
        "sign_up_btn": signUpBtn,
        "or": or,
        "sign_up_with_google": signUpWithGoogle,
      };
}

class VerifyPhoneModel {
  VerifyPhoneModel({
    required this.verifyPhoneNum,
    required this.verifyPhoneBody,
    required this.didntReciveCode,
    required this.resend,
    required this.verifyBtn,
  });

  final String verifyPhoneNum;
  final String verifyPhoneBody;
  final String didntReciveCode;
  final String resend;
  final String verifyBtn;

  factory VerifyPhoneModel.fromJson(Map<String, dynamic> json) =>
      VerifyPhoneModel(
        verifyPhoneNum: json["verify_phone_num"],
        verifyPhoneBody: json["verify_phone_body"],
        didntReciveCode: json["didnt_recive_code"],
        resend: json["resend"],
        verifyBtn: json["verify_btn"],
      );

  Map<String, dynamic> toJson() => {
        "verify_phone_num": verifyPhoneNum,
        "verify_phone_body": verifyPhoneBody,
        "didnt_recive_code": didntReciveCode,
        "resend": resend,
        "verify_btn": verifyBtn,
      };
}

class YourRideModel {
  YourRideModel({
    required this.yourRides,
    required this.today,
  });

  final String yourRides;
  final String today;

  factory YourRideModel.fromJson(Map<String, dynamic> json) => YourRideModel(
        yourRides: json["your_rides"],
        today: json["today"],
      );

  Map<String, dynamic> toJson() => {
        "your_rides": yourRides,
        "today": today,
      };
}
