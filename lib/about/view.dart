import 'package:app/about/functions.dart';
import 'package:app/ads/view.dart';
import 'package:app/app/defines.dart';
import 'package:app/math.dart';
import 'package:app/share.dart';
import 'package:app/urls/defines.dart';
import 'package:app/urls/functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:send_support_email/send_support_email.dart';

class AboutViewModel extends Equatable {
  final String appVersion;

  const AboutViewModel({
    required this.appVersion,
  });

  @override
  List<Object> get props => [
        appVersion,
      ];
}

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
    final email = await generateSupportEmail(supportEmailUrl);
    await openUrl(email);
  }

  Future<void> openWebsite() async {
    await openUrl(repositoryUrl);
  }

  Future<void> openTwitter() async {
    await openUrl(twitterUrl);
  }
}

class AboutViewBuilder extends StatelessWidget {
  const AboutViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutViewBloc>(
      create: AboutViewBloc.fromContext,
      child: BlocBuilder<AboutViewBloc, AboutViewModel>(
        builder: (context, viewModel) {
          return AboutView(
            bloc: context.read<AboutViewBloc>(),
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  final AboutViewBloc bloc;
  final AboutViewModel viewModel;

  const AboutView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AppInfoView(
                    appVersion: viewModel.appVersion,
                  ),
                  const SizedBox(height: 12),
                  _AppActionsView(
                    onRate: bloc.openRateApp,
                    onShare: bloc.openShareApp,
                    onOtherApps: bloc.openOtherApps,
                  ),
                  const SizedBox(height: 16),
                  _SupportView(
                    onOpenEmail: bloc.openEmail,
                    onOpenWebsite: bloc.openWebsite,
                  ),
                  const SizedBox(height: 16),
                  _NewsView(
                    onOpenTwitter: bloc.openTwitter,
                  ),
                ],
              ),
            ),
            const Material(
              type: MaterialType.card,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: _AdView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppInfoView extends StatelessWidget {
  final String appVersion;

  const _AppInfoView({
    required this.appVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 2),
          child: Image.asset(
            'assets/images/app-icon.png',
            width: 48,
            height: 48,
            filterQuality: FilterQuality.medium,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              children: [
                Text(
                  appVersion,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // const SizedBox(width: 8),
                // LinkButton(
                //   onPressed: bloc.showReleaseNotes,
                //   text: "What's new?",
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _AppActionsView extends StatelessWidget {
  final void Function() onRate;
  final void Function(String, Rect) onShare;
  final void Function() onOtherApps;

  const _AppActionsView({
    required this.onRate,
    required this.onShare,
    required this.onOtherApps,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton(
          onPressed: onRate,
          child: const Text('Rate'),
        ),
        Builder(
          builder: (context) {
            return OutlinedButton(
              onPressed: () {
                onShare(
                  '''
Find and copy unicode characters, emoji, kaomoji and symbols with Ejimo: $repositoryUrl''',
                  getSharePosition(context),
                );
              },
              child: const Text('Share'),
            );
          },
        ),
        FilledButton(
          onPressed: onOtherApps,
          child: const Text('Other Apps'),
        ),
      ],
    );
  }
}

class _SupportView extends StatelessWidget {
  final void Function() onOpenEmail;
  final void Function() onOpenWebsite;

  const _SupportView({
    required this.onOpenEmail,
    required this.onOpenWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Help & Support'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: onOpenEmail,
              child: const Text('Email'),
            ),
            OutlinedButton(
              onPressed: onOpenWebsite,
              child: const Text('Website'),
            ),
          ],
        ),
      ],
    );
  }
}

class _NewsView extends StatelessWidget {
  final void Function() onOpenTwitter;

  const _NewsView({
    required this.onOpenTwitter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('News, Tips & Tricks'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: onOpenTwitter,
              child: const Text('Twitter'),
            ),
          ],
        ),
      ],
    );
  }
}

class _AdView extends StatelessWidget {
  const _AdView();

  @override
  Widget build(BuildContext context) {
    // randomize which ad to show
    final random = randomInt(1, 4);
    if (random == 1) return const ExaboxAdView();
    if (random == 2) return const HexeeProAdView();
    if (random == 3) return const WMapAdView();
    if (random == 4) return const IroIronAdView();
    return const SizedBox();
  }
}
