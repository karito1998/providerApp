// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  Computed<String>? _$userFullNameComputed;

  @override
  String get userFullName =>
      (_$userFullNameComputed ??= Computed<String>(() => super.userFullName,
              name: '_AppStore.userFullName'))
          .value;

  final _$isLoggedInAtom = Atom(name: '_AppStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$isDarkModeAtom = Atom(name: '_AppStore.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AppStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isRememberMeAtom = Atom(name: '_AppStore.isRememberMe');

  @override
  bool get isRememberMe {
    _$isRememberMeAtom.reportRead();
    return super.isRememberMe;
  }

  @override
  set isRememberMe(bool value) {
    _$isRememberMeAtom.reportWrite(value, super.isRememberMe, () {
      super.isRememberMe = value;
    });
  }

  final _$isTesterAtom = Atom(name: '_AppStore.isTester');

  @override
  bool get isTester {
    _$isTesterAtom.reportRead();
    return super.isTester;
  }

  @override
  set isTester(bool value) {
    _$isTesterAtom.reportWrite(value, super.isTester, () {
      super.isTester = value;
    });
  }

  final _$selectedLanguageCodeAtom =
      Atom(name: '_AppStore.selectedLanguageCode');

  @override
  String get selectedLanguageCode {
    _$selectedLanguageCodeAtom.reportRead();
    return super.selectedLanguageCode;
  }

  @override
  set selectedLanguageCode(String value) {
    _$selectedLanguageCodeAtom.reportWrite(value, super.selectedLanguageCode,
        () {
      super.selectedLanguageCode = value;
    });
  }

  final _$userProfileImageAtom = Atom(name: '_AppStore.userProfileImage');

  @override
  String get userProfileImage {
    _$userProfileImageAtom.reportRead();
    return super.userProfileImage;
  }

  @override
  set userProfileImage(String value) {
    _$userProfileImageAtom.reportWrite(value, super.userProfileImage, () {
      super.userProfileImage = value;
    });
  }

  final _$currencySymbolAtom = Atom(name: '_AppStore.currencySymbol');

  @override
  String get currencySymbol {
    _$currencySymbolAtom.reportRead();
    return super.currencySymbol;
  }

  @override
  set currencySymbol(String value) {
    _$currencySymbolAtom.reportWrite(value, super.currencySymbol, () {
      super.currencySymbol = value;
    });
  }

  final _$currencyCodeAtom = Atom(name: '_AppStore.currencyCode');

  @override
  String get currencyCode {
    _$currencyCodeAtom.reportRead();
    return super.currencyCode;
  }

  @override
  set currencyCode(String value) {
    _$currencyCodeAtom.reportWrite(value, super.currencyCode, () {
      super.currencyCode = value;
    });
  }

  final _$currencyCountryIdAtom = Atom(name: '_AppStore.currencyCountryId');

  @override
  String get currencyCountryId {
    _$currencyCountryIdAtom.reportRead();
    return super.currencyCountryId;
  }

  @override
  set currencyCountryId(String value) {
    _$currencyCountryIdAtom.reportWrite(value, super.currencyCountryId, () {
      super.currencyCountryId = value;
    });
  }

  final _$uIdAtom = Atom(name: '_AppStore.uId');

  @override
  String get uId {
    _$uIdAtom.reportRead();
    return super.uId;
  }

  @override
  set uId(String value) {
    _$uIdAtom.reportWrite(value, super.uId, () {
      super.uId = value;
    });
  }

  final _$isPlanSubscribeAtom = Atom(name: '_AppStore.isPlanSubscribe');

  @override
  bool get isPlanSubscribe {
    _$isPlanSubscribeAtom.reportRead();
    return super.isPlanSubscribe;
  }

  @override
  set isPlanSubscribe(bool value) {
    _$isPlanSubscribeAtom.reportWrite(value, super.isPlanSubscribe, () {
      super.isPlanSubscribe = value;
    });
  }

  final _$planTitleAtom = Atom(name: '_AppStore.planTitle');

  @override
  String get planTitle {
    _$planTitleAtom.reportRead();
    return super.planTitle;
  }

  @override
  set planTitle(String value) {
    _$planTitleAtom.reportWrite(value, super.planTitle, () {
      super.planTitle = value;
    });
  }

  final _$identifierAtom = Atom(name: '_AppStore.identifier');

  @override
  String get identifier {
    _$identifierAtom.reportRead();
    return super.identifier;
  }

  @override
  set identifier(String value) {
    _$identifierAtom.reportWrite(value, super.identifier, () {
      super.identifier = value;
    });
  }

  final _$planEndDateAtom = Atom(name: '_AppStore.planEndDate');

  @override
  String get planEndDate {
    _$planEndDateAtom.reportRead();
    return super.planEndDate;
  }

  @override
  set planEndDate(String value) {
    _$planEndDateAtom.reportWrite(value, super.planEndDate, () {
      super.planEndDate = value;
    });
  }

  final _$userFirstNameAtom = Atom(name: '_AppStore.userFirstName');

  @override
  String get userFirstName {
    _$userFirstNameAtom.reportRead();
    return super.userFirstName;
  }

  @override
  set userFirstName(String value) {
    _$userFirstNameAtom.reportWrite(value, super.userFirstName, () {
      super.userFirstName = value;
    });
  }

  final _$userLastNameAtom = Atom(name: '_AppStore.userLastName');

  @override
  String get userLastName {
    _$userLastNameAtom.reportRead();
    return super.userLastName;
  }

  @override
  set userLastName(String value) {
    _$userLastNameAtom.reportWrite(value, super.userLastName, () {
      super.userLastName = value;
    });
  }

  final _$userContactNumberAtom = Atom(name: '_AppStore.userContactNumber');

  @override
  String get userContactNumber {
    _$userContactNumberAtom.reportRead();
    return super.userContactNumber;
  }

  @override
  set userContactNumber(String value) {
    _$userContactNumberAtom.reportWrite(value, super.userContactNumber, () {
      super.userContactNumber = value;
    });
  }

  final _$userEmailAtom = Atom(name: '_AppStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$userNameAtom = Atom(name: '_AppStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$tokenAtom = Atom(name: '_AppStore.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$countryIdAtom = Atom(name: '_AppStore.countryId');

  @override
  int get countryId {
    _$countryIdAtom.reportRead();
    return super.countryId;
  }

  @override
  set countryId(int value) {
    _$countryIdAtom.reportWrite(value, super.countryId, () {
      super.countryId = value;
    });
  }

  final _$stateIdAtom = Atom(name: '_AppStore.stateId');

  @override
  int get stateId {
    _$stateIdAtom.reportRead();
    return super.stateId;
  }

  @override
  set stateId(int value) {
    _$stateIdAtom.reportWrite(value, super.stateId, () {
      super.stateId = value;
    });
  }

  final _$cityIdAtom = Atom(name: '_AppStore.cityId');

  @override
  int get cityId {
    _$cityIdAtom.reportRead();
    return super.cityId;
  }

  @override
  set cityId(int value) {
    _$cityIdAtom.reportWrite(value, super.cityId, () {
      super.cityId = value;
    });
  }

  final _$addressAtom = Atom(name: '_AppStore.address');

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$playerIdAtom = Atom(name: '_AppStore.playerId');

  @override
  String get playerId {
    _$playerIdAtom.reportRead();
    return super.playerId;
  }

  @override
  set playerId(String value) {
    _$playerIdAtom.reportWrite(value, super.playerId, () {
      super.playerId = value;
    });
  }

  final _$userIdAtom = Atom(name: '_AppStore.userId');

  @override
  int? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$providerIdAtom = Atom(name: '_AppStore.providerId');

  @override
  int? get providerId {
    _$providerIdAtom.reportRead();
    return super.providerId;
  }

  @override
  set providerId(int? value) {
    _$providerIdAtom.reportWrite(value, super.providerId, () {
      super.providerId = value;
    });
  }

  final _$serviceAddressIdAtom = Atom(name: '_AppStore.serviceAddressId');

  @override
  int get serviceAddressId {
    _$serviceAddressIdAtom.reportRead();
    return super.serviceAddressId;
  }

  @override
  set serviceAddressId(int value) {
    _$serviceAddressIdAtom.reportWrite(value, super.serviceAddressId, () {
      super.serviceAddressId = value;
    });
  }

  final _$userTypeAtom = Atom(name: '_AppStore.userType');

  @override
  String get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(String value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  final _$initialAdCountAtom = Atom(name: '_AppStore.initialAdCount');

  @override
  int get initialAdCount {
    _$initialAdCountAtom.reportRead();
    return super.initialAdCount;
  }

  @override
  set initialAdCount(int value) {
    _$initialAdCountAtom.reportWrite(value, super.initialAdCount, () {
      super.initialAdCount = value;
    });
  }

  final _$totalBookingAtom = Atom(name: '_AppStore.totalBooking');

  @override
  int get totalBooking {
    _$totalBookingAtom.reportRead();
    return super.totalBooking;
  }

  @override
  set totalBooking(int value) {
    _$totalBookingAtom.reportWrite(value, super.totalBooking, () {
      super.totalBooking = value;
    });
  }

  final _$createdAtAtom = Atom(name: '_AppStore.createdAt');

  @override
  String get createdAt {
    _$createdAtAtom.reportRead();
    return super.createdAt;
  }

  @override
  set createdAt(String value) {
    _$createdAtAtom.reportWrite(value, super.createdAt, () {
      super.createdAt = value;
    });
  }

  final _$setTesterAsyncAction = AsyncAction('_AppStore.setTester');

  @override
  Future<void> setTester(bool val, {bool isInitializing = false}) {
    return _$setTesterAsyncAction
        .run(() => super.setTester(val, isInitializing: isInitializing));
  }

  final _$setUserProfileAsyncAction = AsyncAction('_AppStore.setUserProfile');

  @override
  Future<void> setUserProfile(String val, {bool isInitializing = false}) {
    return _$setUserProfileAsyncAction
        .run(() => super.setUserProfile(val, isInitializing: isInitializing));
  }

  final _$setPlayerIdAsyncAction = AsyncAction('_AppStore.setPlayerId');

  @override
  Future<void> setPlayerId(String val, {bool isInitializing = false}) {
    return _$setPlayerIdAsyncAction
        .run(() => super.setPlayerId(val, isInitializing: isInitializing));
  }

  final _$setTokenAsyncAction = AsyncAction('_AppStore.setToken');

  @override
  Future<void> setToken(String val, {bool isInitializing = false}) {
    return _$setTokenAsyncAction
        .run(() => super.setToken(val, isInitializing: isInitializing));
  }

  final _$setCountryIdAsyncAction = AsyncAction('_AppStore.setCountryId');

  @override
  Future<void> setCountryId(int val, {bool isInitializing = false}) {
    return _$setCountryIdAsyncAction
        .run(() => super.setCountryId(val, isInitializing: isInitializing));
  }

  final _$setStateIdAsyncAction = AsyncAction('_AppStore.setStateId');

  @override
  Future<void> setStateId(int val, {bool isInitializing = false}) {
    return _$setStateIdAsyncAction
        .run(() => super.setStateId(val, isInitializing: isInitializing));
  }

  final _$setCurrencySymbolAsyncAction =
      AsyncAction('_AppStore.setCurrencySymbol');

  @override
  Future<void> setCurrencySymbol(String val, {bool isInitializing = false}) {
    return _$setCurrencySymbolAsyncAction.run(
        () => super.setCurrencySymbol(val, isInitializing: isInitializing));
  }

  final _$setCurrencyCodeAsyncAction = AsyncAction('_AppStore.setCurrencyCode');

  @override
  Future<void> setCurrencyCode(String val, {bool isInitializing = false}) {
    return _$setCurrencyCodeAsyncAction
        .run(() => super.setCurrencyCode(val, isInitializing: isInitializing));
  }

  final _$setCurrencyCountryIdAsyncAction =
      AsyncAction('_AppStore.setCurrencyCountryId');

  @override
  Future<void> setCurrencyCountryId(String val, {bool isInitializing = false}) {
    return _$setCurrencyCountryIdAsyncAction.run(
        () => super.setCurrencyCountryId(val, isInitializing: isInitializing));
  }

  final _$setCityIdAsyncAction = AsyncAction('_AppStore.setCityId');

  @override
  Future<void> setCityId(int val, {bool isInitializing = false}) {
    return _$setCityIdAsyncAction
        .run(() => super.setCityId(val, isInitializing: isInitializing));
  }

  final _$setUIdAsyncAction = AsyncAction('_AppStore.setUId');

  @override
  Future<void> setUId(String val, {bool isInitializing = false}) {
    return _$setUIdAsyncAction
        .run(() => super.setUId(val, isInitializing: isInitializing));
  }

  final _$setPlanSubscribeStatusAsyncAction =
      AsyncAction('_AppStore.setPlanSubscribeStatus');

  @override
  Future<void> setPlanSubscribeStatus(bool val, {bool isInitializing = false}) {
    return _$setPlanSubscribeStatusAsyncAction.run(() =>
        super.setPlanSubscribeStatus(val, isInitializing: isInitializing));
  }

  final _$setPlanTitleAsyncAction = AsyncAction('_AppStore.setPlanTitle');

  @override
  Future<void> setPlanTitle(String val, {bool isInitializing = false}) {
    return _$setPlanTitleAsyncAction
        .run(() => super.setPlanTitle(val, isInitializing: isInitializing));
  }

  final _$setIdentifierAsyncAction = AsyncAction('_AppStore.setIdentifier');

  @override
  Future<void> setIdentifier(String val, {bool isInitializing = false}) {
    return _$setIdentifierAsyncAction
        .run(() => super.setIdentifier(val, isInitializing: isInitializing));
  }

  final _$setPlanEndDateAsyncAction = AsyncAction('_AppStore.setPlanEndDate');

  @override
  Future<void> setPlanEndDate(String val, {bool isInitializing = false}) {
    return _$setPlanEndDateAsyncAction
        .run(() => super.setPlanEndDate(val, isInitializing: isInitializing));
  }

  final _$setUserIdAsyncAction = AsyncAction('_AppStore.setUserId');

  @override
  Future<void> setUserId(int val, {bool isInitializing = false}) {
    return _$setUserIdAsyncAction
        .run(() => super.setUserId(val, isInitializing: isInitializing));
  }

  final _$setUserTypeAsyncAction = AsyncAction('_AppStore.setUserType');

  @override
  Future<void> setUserType(String val, {bool isInitializing = false}) {
    return _$setUserTypeAsyncAction
        .run(() => super.setUserType(val, isInitializing: isInitializing));
  }

  final _$setTotalBookingAsyncAction = AsyncAction('_AppStore.setTotalBooking');

  @override
  Future<void> setTotalBooking(int val, {bool isInitializing = false}) {
    return _$setTotalBookingAsyncAction
        .run(() => super.setTotalBooking(val, isInitializing: isInitializing));
  }

  final _$setCreatedAtAsyncAction = AsyncAction('_AppStore.setCreatedAt');

  @override
  Future<void> setCreatedAt(String val, {bool isInitializing = false}) {
    return _$setCreatedAtAsyncAction
        .run(() => super.setCreatedAt(val, isInitializing: isInitializing));
  }

  final _$setProviderIdAsyncAction = AsyncAction('_AppStore.setProviderId');

  @override
  Future<void> setProviderId(int val, {bool isInitializing = false}) {
    return _$setProviderIdAsyncAction
        .run(() => super.setProviderId(val, isInitializing: isInitializing));
  }

  final _$setServiceAddressIdAsyncAction =
      AsyncAction('_AppStore.setServiceAddressId');

  @override
  Future<void> setServiceAddressId(int val, {bool isInitializing = false}) {
    return _$setServiceAddressIdAsyncAction.run(
        () => super.setServiceAddressId(val, isInitializing: isInitializing));
  }

  final _$setUserEmailAsyncAction = AsyncAction('_AppStore.setUserEmail');

  @override
  Future<void> setUserEmail(String val, {bool isInitializing = false}) {
    return _$setUserEmailAsyncAction
        .run(() => super.setUserEmail(val, isInitializing: isInitializing));
  }

  final _$setAddressAsyncAction = AsyncAction('_AppStore.setAddress');

  @override
  Future<void> setAddress(String val, {bool isInitializing = false}) {
    return _$setAddressAsyncAction
        .run(() => super.setAddress(val, isInitializing: isInitializing));
  }

  final _$setFirstNameAsyncAction = AsyncAction('_AppStore.setFirstName');

  @override
  Future<void> setFirstName(String val, {bool isInitializing = false}) {
    return _$setFirstNameAsyncAction
        .run(() => super.setFirstName(val, isInitializing: isInitializing));
  }

  final _$setLastNameAsyncAction = AsyncAction('_AppStore.setLastName');

  @override
  Future<void> setLastName(String val, {bool isInitializing = false}) {
    return _$setLastNameAsyncAction
        .run(() => super.setLastName(val, isInitializing: isInitializing));
  }

  final _$setContactNumberAsyncAction =
      AsyncAction('_AppStore.setContactNumber');

  @override
  Future<void> setContactNumber(String val, {bool isInitializing = false}) {
    return _$setContactNumberAsyncAction
        .run(() => super.setContactNumber(val, isInitializing: isInitializing));
  }

  final _$setUserNameAsyncAction = AsyncAction('_AppStore.setUserName');

  @override
  Future<void> setUserName(String val, {bool isInitializing = false}) {
    return _$setUserNameAsyncAction
        .run(() => super.setUserName(val, isInitializing: isInitializing));
  }

  final _$setLoggedInAsyncAction = AsyncAction('_AppStore.setLoggedIn');

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction
        .run(() => super.setLoggedIn(val, isInitializing: isInitializing));
  }

  final _$setInitialAdCountAsyncAction =
      AsyncAction('_AppStore.setInitialAdCount');

  @override
  Future<void> setInitialAdCount(int val) {
    return _$setInitialAdCountAsyncAction
        .run(() => super.setInitialAdCount(val));
  }

  final _$setDarkModeAsyncAction = AsyncAction('_AppStore.setDarkMode');

  @override
  Future<void> setDarkMode(bool val) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(val));
  }

  final _$setLanguageAsyncAction = AsyncAction('_AppStore.setLanguage');

  @override
  Future<void> setLanguage(String val, {BuildContext? context}) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(val, context: context));
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemember(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setRemember');
    try {
      return super.setRemember(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isDarkMode: ${isDarkMode},
isLoading: ${isLoading},
isRememberMe: ${isRememberMe},
isTester: ${isTester},
selectedLanguageCode: ${selectedLanguageCode},
userProfileImage: ${userProfileImage},
currencySymbol: ${currencySymbol},
currencyCode: ${currencyCode},
currencyCountryId: ${currencyCountryId},
uId: ${uId},
isPlanSubscribe: ${isPlanSubscribe},
planTitle: ${planTitle},
identifier: ${identifier},
planEndDate: ${planEndDate},
userFirstName: ${userFirstName},
userLastName: ${userLastName},
userContactNumber: ${userContactNumber},
userEmail: ${userEmail},
userName: ${userName},
token: ${token},
countryId: ${countryId},
stateId: ${stateId},
cityId: ${cityId},
address: ${address},
playerId: ${playerId},
userId: ${userId},
providerId: ${providerId},
serviceAddressId: ${serviceAddressId},
userType: ${userType},
initialAdCount: ${initialAdCount},
totalBooking: ${totalBooking},
createdAt: ${createdAt},
userFullName: ${userFullName}
    ''';
  }
}
