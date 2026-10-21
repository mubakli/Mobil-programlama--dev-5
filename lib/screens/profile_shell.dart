import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../theme.dart';
import '../widgets/message_dialog.dart';
import '../widgets/profile_card.dart';
import 'profile_pages.dart';

const _labels = ['Profil', 'Hakkında', 'İletişim', 'Misyon / Vizyon'];
const _icons = [
  Icons.grid_view_rounded,
  Icons.person_outline_rounded,
  Icons.alternate_email_rounded,
  Icons.explore_outlined
];

class ProfileShell extends StatefulWidget {
  const ProfileShell({super.key});

  @override
  State<ProfileShell> createState() => _ProfileShellState();
}

class _ProfileShellState extends State<ProfileShell> {
  int _selectedPage = 0;
  int _profileIndex = 0;
  final _scrollController = ScrollController();
  Profile get _profile => sampleProfiles[_profileIndex];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    setState(() => _selectedPage = index);
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  void _refreshProfile() {
    setState(() => _profileIndex = (_profileIndex + 1) % sampleProfiles.length);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text('Örnek kullanıcı yenilendi: ${_profile.name}'),
          behavior: SnackBarBehavior.floating));
  }

  void _openMessage({bool mail = false}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => MessageDialog(profile: _profile, initiallyMail: mail),
    );
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;
        final usableWidth = constraints.maxWidth / textScale.clamp(1.0, 2.0);
        final desktop = usableWidth >= 850;
        final topNavigation = usableWidth >= 1050;
        final padding = desktop ? 36.0 : 20.0;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(desktop ? 84 : 68),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: line))),
              child: SafeArea(
                  bottom: false,
                  child: Center(
                      child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1192),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Row(children: [
                          Container(
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                  color: green,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.school_outlined,
                                  color: Colors.white, size: 23)),
                          const SizedBox(width: 10),
                          Flexible(
                              flex: topNavigation ? 0 : 1,
                              fit:
                                  topNavigation ? FlexFit.loose : FlexFit.tight,
                              child: const Text('kampüs',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: ink,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -1))),
                          if (topNavigation) ...[
                            const SizedBox(width: 32),
                            for (var i = 0; i < _labels.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor:
                                          _selectedPage == i ? green : muted,
                                      backgroundColor:
                                          _selectedPage == i ? mint : null,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 18)),
                                  onPressed: () => _selectPage(i),
                                  child: Text(_labels[i]),
                                ),
                              ),
                          ],
                          if (topNavigation) const Spacer(),
                          if (usableWidth > 1200) ...[
                            const Text('ÖĞRENCİ PORTALI',
                                style: TextStyle(
                                    color: muted,
                                    fontSize: 10,
                                    letterSpacing: 1.3)),
                            const SizedBox(width: 16),
                          ],
                          Tooltip(
                              message:
                                  'Görüntülenen örnek profil: ${_profile.name}',
                              child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Color(_profile.color),
                                  child: Text(_profile.initials,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: green,
                                          fontWeight: FontWeight.w600)))),
                        ])),
                  ))),
            ),
          ),
          bottomNavigationBar: topNavigation
              ? null
              : NavigationBar(
                  selectedIndex: _selectedPage,
                  onDestinationSelected: _selectPage,
                  labelBehavior:
                      NavigationDestinationLabelBehavior.onlyShowSelected,
                  destinations: [
                    for (var i = 0; i < _labels.length; i++)
                      NavigationDestination(
                          icon: Icon(_icons[i]), label: _labels[i])
                  ],
                ),
          body: SelectionArea(
              child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1192),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      padding, desktop ? 36 : 24, padding, 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.home_outlined,
                              size: 15, color: muted),
                          const SizedBox(width: 8),
                          const Text('Kişisel alan',
                              style: TextStyle(fontSize: 11, color: muted)),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              child: Text('/', style: TextStyle(color: muted))),
                          Flexible(
                              child: Text(_labels[_selectedPage],
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: green,
                                      fontWeight: FontWeight.w600)))
                        ]),
                        const SizedBox(height: 23),
                        LayoutBuilder(builder: (context, size) {
                          final heading = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _selectedPage == 0
                                        ? 'Bir profilden daha fazlası.'
                                        : _labels[_selectedPage],
                                    style: desktop
                                        ? Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                        : Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                const SizedBox(height: 8),
                                const Text('Tanış, keşfet, iletişimde kal.',
                                    style:
                                        TextStyle(fontSize: 13, color: muted)),
                              ]);
                          final actions =
                              Wrap(spacing: 10, runSpacing: 10, children: [
                            OutlinedButton.icon(
                                key: const Key('refresh-user'),
                                onPressed: _refreshProfile,
                                icon:
                                    const Icon(Icons.refresh_rounded, size: 17),
                                label: const Text('Kullanıcı yenile')),
                            FilledButton.icon(
                                key: const Key('open-message'),
                                onPressed: _openMessage,
                                icon: const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 17),
                                label: const Text('Mesaj / Mail')),
                          ]);
                          return size.maxWidth / textScale.clamp(1.0, 2.0) >=
                                  1020
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      Expanded(child: heading),
                                      const SizedBox(width: 24),
                                      Flexible(child: actions),
                                    ])
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      heading,
                                      const SizedBox(height: 20),
                                      actions
                                    ]);
                        }),
                        const SizedBox(height: 28),
                        if (desktop)
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 326,
                                    child: ProfileCard(
                                        profile: _profile,
                                        onContact: () => _selectPage(2))),
                                const SizedBox(width: 24),
                                Expanded(child: _page()),
                              ])
                        else ...[
                          if (_selectedPage == 0) ...[
                            ProfileCard(
                                profile: _profile,
                                onContact: () => _selectPage(2)),
                            const SizedBox(height: 20)
                          ],
                          _page(),
                        ],
                        const SizedBox(height: 28),
                        const Divider(height: 1),
                        const SizedBox(height: 18),
                        const Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 24,
                            runSpacing: 8,
                            children: [
                              Text(
                                  'kampüs  /  Küçük bağlantılar, büyük fikirler.',
                                  style: TextStyle(fontSize: 11, color: muted)),
                              Text('5. hafta projesi · Flutter UI demosu',
                                  style: TextStyle(fontSize: 11, color: muted)),
                            ]),
                      ])),
            )),
          )),
        );
      });

  Widget _page() => switch (_selectedPage) {
        1 => AboutPage(profile: _profile),
        2 => ContactPage(
            profile: _profile,
            onMessage: _openMessage,
            onMail: () => _openMessage(mail: true)),
        3 => const MissionPage(),
        _ => OverviewPage(
            profile: _profile,
            onAbout: () => _selectPage(1),
            onMessage: _openMessage),
      };
}
