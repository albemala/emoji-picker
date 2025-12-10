import 'package:app/about/functions.dart';
import 'package:app/about/view-state.dart';
import 'package:app/feedback.dart';
import 'package:app/review.dart';
import 'package:app/share.dart';
import 'package:app/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutViewController extends Cubit<AboutViewState> {
  factory AboutViewController.fromContext(BuildContext context) {
    return AboutViewController();
  }

  AboutViewController() : super(AboutViewState.initial()) {
    updateViewState();
  }

  Future<void> updateViewState() async {
    final appVersion = await getAppVersion();
    emit(AboutViewState(appVersion: appVersion));
  }

  Future<void> openRateApp() async {
    await openStoreListing();
  }

  Future<void> openShareApp(String message, Rect sharePosition) async {
    await shareText(position: sharePosition, text: message);
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
