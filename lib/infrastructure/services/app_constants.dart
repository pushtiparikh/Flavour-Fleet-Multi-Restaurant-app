import 'package:flavourfleet/infrastructure/services/tr_keys.dart';

class AppConstants {
  AppConstants._();

  /// shared preferences keys
  static const String keyLangSelected = 'keyLangSelected';
  static const String keyUserId = 'keyUserId';
  static const String keyUserImage = 'keyUser';
  static const String keyToken = 'keyToken';
  static const String keyUiType = 'keyUiType';
  static const String keyLocaleCode = 'keyLocaleCode';
  static const String keyFirstName = 'keyFirstName';
  static const String keyLastName = 'keyLastName';
  static const String keyPhone = 'keyPhone';
  static const String keyProfileImage = 'keyProfileImage';
  static const String keySavedStores = 'keySavedStores';
  static const String keySearchStores = 'keySearchStores';
  static const String keyViewedProducts = 'keyViewedProducts';
  static const String keyAddressSelected = 'keyAddressSelected';
  static const String keyAddressInformation = 'keyAddressInformation';
  static const String keyIsGuest = 'keyIsGuest';
  static const String keyLocalAddresses = 'keyLocalAddresses';
  static const String keyActiveAddressTitle = 'keyActiveAddressTitle';
  static const String keyLikedProducts = 'keyLikedProducts';
  static const String keySelectedCurrency = 'keySelectedCurrency';
  static const String keyCartProducts = 'keyCartProducts';
  static const String keyAppThemeMode = 'keyAppThemeMode';
  static const String keyWalletData = 'keyWalletData';
  static const String keyGlobalSettings = 'keyGlobalSettings';
  static const String keySettingsFetched = 'keySettingsFetched';
  static const String keyTranslations = 'keyTranslations';
  static const String keyLanguageData = 'keyLanguageData';
  static const String keyAuthenticatedWithSocial = 'keyAuthenticatedWithSocial';
  static const String keyLangLtr = 'keyLangLtr';

  /// hero tags
  static const String heroTagSelectUser = 'heroTagSelectUser';
  static const String heroTagSelectAddress = 'heroTagSelectAddress';
  static const String heroTagSelectCurrency = 'heroTagSelectCurrency';

  /// app strings
  static const String emptyString = '';

  



  /// locales
  static const String localeCodeEn = 'en';
  static const String chatGpt =
      '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';

  /// location
  static const double demoLatitude = 41.304223;
  static const double demoLongitude = 69.2348277;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  static const Duration timeRefresh = Duration(seconds: 30);

  static const List infoImage = [
    "assets/images/save.png",
    "assets/images/delivery.png",
    "assets/images/fast.png",
    "assets/images/set.png",
  ];

  static const List infoTitle = [
    TrKeys.saveTime,
    TrKeys.deliveryRestriction,
    TrKeys.fast,
    TrKeys.set,
  ];


  static const payLater = [
    "progress",
    "canceled",
    "rejected",
  ];

}

enum ShopStatus { notRequested, newShop, edited, approved, rejected }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
}

enum PriceFilter { byLow, byHigh }


enum ListAlignment { singleBig, vertically, horizontally }

enum ExtrasType { color, text, image }

enum DeliveryTypeEnum { delivery, pickup }

enum ShippingDeliveryVisibilityType {
  cantOrder,
  onlyDelivery,
  onlyPickup,
  both,
}

enum OrderStatus { open, accepted, ready, onWay, delivered, canceled }

enum CouponType { fix, percent }

enum MessageOwner { you, partner }

enum BannerType { banner, look }

enum LookProductStockStatus { outOfStock, alreadyAdded, notAdded }
