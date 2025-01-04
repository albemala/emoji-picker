import 'package:app/about/functions.dart';
import 'package:app/about/view_state.dart';
import 'package:app/app/defines.dart';
import 'package:app/feedback.dart';
import 'package:app/share.dart';
import 'package:app/urls/defines.dart';
import 'package:app/urls/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';

class AboutViewBloc extends Cubit<AboutViewModel> {
  factory AboutViewBloc.fromContext(BuildContext context) {
    return AboutViewBloc();
  }

  AboutViewBloc()
      : super(
          const AboutViewModel(appVersion: '...'),
        ) {
    _init();
  }

  Future<void> _init() async {
    await _updateViewModel();
  }

  Future<void> _updateViewModel() async {
    emit(
      AboutViewModel(
        appVersion: await getAppVersion(),
      ),
    );
  }

  Future<void> openRateApp() async {
    await InAppReview.instance.openStoreListing(
      appStoreId: appleAppId,
      microsoftStoreId: microsoftStoreId,
    );
  }

  Future<void> openShareApp(
    String message,
    Rect sharePosition,
  ) async {
    await shareText(
      position: sharePosition,
      text: message,
    );
  }

  Future<void> openOtherApps() async {
    await openUrl(otherProjectsUrl);
  }

  Future<void> openEmail() async {
    await sendFeedback();
  }

  Future<void> openWebsite() async {
    await openUrl(repositoryUrl);
  }

  Future<void> openTwitter() async {
    await openUrl(twitterUrl);
  }
}
