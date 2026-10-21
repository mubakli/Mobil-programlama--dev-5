import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../theme.dart';
import 'shared.dart';

class MessageDialog extends StatefulWidget {
  const MessageDialog(
      {super.key, required this.profile, this.initiallyMail = false});
  final Profile profile;
  final bool initiallyMail;

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  final _formKey = GlobalKey<FormState>();
  final _message = TextEditingController();
  final _mailBody = TextEditingController();
  final _subject = TextEditingController();
  final _scroll = ScrollController();
  final List<_LocalMessage> _messages = [];
  late bool _mail;

  @override
  void initState() {
    super.initState();
    _mail = widget.initiallyMail;
  }

  @override
  void dispose() {
    _message.dispose();
    _mailBody.dispose();
    _subject.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _sendPreview() {
    if (!_formKey.currentState!.validate()) return;
    final controller = _mail ? _mailBody : _message;
    setState(() {
      _messages.add(_LocalMessage(
          body: controller.text.trim(),
          subject: _mail ? _subject.text.trim() : null,
          time: TimeOfDay.now()));
      controller.clear();
      if (_mail) _subject.clear();
    });
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  Future<void> _close() async {
    final hasDraft = [_message, _mailBody, _subject]
        .any((controller) => controller.text.trim().isNotEmpty);
    if (hasDraft) {
      final discard = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Taslak silinsin mi?'),
                content: const Text(
                    'Yazdığınız taslak bu pencere kapatıldığında silinir.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Yazmaya devam et')),
                  FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Taslağı sil')),
                ],
              ));
      if (discard != true || !mounted) return;
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 600;
    final visibleMessages = _messages
        .where((message) => (message.subject != null) == _mail)
        .toList();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _close();
      },
      child: Dialog(
        insetPadding: EdgeInsets.all(mobile ? 12 : 32),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 570, maxHeight: 790),
          child: SingleChildScrollView(
            controller: _scroll,
            padding: EdgeInsets.all(mobile ? 20 : 28),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Bir merhaba gönder.',
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 5),
                          const Text('İletişim kurmanın en kolay yolu.',
                              style: TextStyle(fontSize: 12, color: muted)),
                        ])),
                    IconButton(
                        tooltip: 'Pencereyi kapat',
                        onPressed: _close,
                        icon: const Icon(Icons.close_rounded, size: 21)),
                  ]),
                  const SizedBox(height: 22),
                  SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<bool>(
                        showSelectedIcon: false,
                        segments: const [
                          ButtonSegment(
                              value: false,
                              icon: Icon(Icons.chat_bubble_outline_rounded,
                                  size: 17),
                              label: Text('Anlık mesaj')),
                          ButtonSegment(
                              value: true,
                              icon: Icon(Icons.mail_outline_rounded, size: 17),
                              label: Text('E-posta')),
                        ],
                        selected: {_mail},
                        onSelectionChanged: (selection) {
                          setState(() => _mail = selection.first);
                        },
                        style: SegmentedButton.styleFrom(
                            selectedBackgroundColor: mint,
                            selectedForegroundColor: green,
                            side: const BorderSide(color: line),
                            padding: const EdgeInsets.symmetric(vertical: 15)),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: canvas, borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      CircleAvatar(
                          radius: 21,
                          backgroundColor: Color(widget.profile.color),
                          child: Text(widget.profile.initials,
                              style:
                                  const TextStyle(color: green, fontSize: 13))),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(widget.profile.name,
                                style: const TextStyle(
                                    color: ink,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            Text(
                                _mail
                                    ? widget.profile.email
                                    : 'Alıcı · ${widget.profile.department}',
                                style: const TextStyle(
                                    color: muted, fontSize: 11)),
                          ])),
                      const Icon(Icons.lock_outline_rounded,
                          size: 16, color: muted),
                    ]),
                  ),
                  const SizedBox(height: 18),
                  const DemoNote(compact: true),
                  const SizedBox(height: 18),
                  if (visibleMessages.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 12),
                      child: Column(children: [
                        Icon(
                            _mail
                                ? Icons.mark_email_unread_outlined
                                : Icons.forum_outlined,
                            size: 28,
                            color: green),
                        const SizedBox(height: 10),
                        Text(
                            _mail
                                ? 'Yeni bir e-posta taslağı'
                                : 'Sohbet burada başlıyor.',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ink)),
                        const SizedBox(height: 5),
                        const Text(
                            'Önizlemeler yalnızca bu pencere açıkken saklanır.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: muted)),
                      ]),
                    )
                  else ...[
                    const Text('YEREL ÖNİZLEME',
                        style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1.2,
                            color: muted,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    for (final message in visibleMessages)
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 440),
                            margin: const EdgeInsets.only(left: 20, bottom: 12),
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: mint,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(14),
                                    bottomRight: Radius.circular(3))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (message.subject != null) ...[
                                    Text(message.subject!,
                                        style: const TextStyle(
                                            color: ink,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 6)
                                  ],
                                  SelectableText(message.body,
                                      style: const TextStyle(
                                          color: ink,
                                          fontSize: 13,
                                          height: 1.5)),
                                  const SizedBox(height: 9),
                                  Text(
                                      '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')} · Gönderilmedi (demo)',
                                      style: const TextStyle(
                                          fontSize: 10, color: green)),
                                ]),
                          )),
                  ],
                  const SizedBox(height: 6),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        if (_mail) ...[
                          TextFormField(
                            key: const Key('mail-subject'),
                            controller: _subject,
                            maxLength: 120,
                            decoration: const InputDecoration(
                                labelText: 'Konu',
                                hintText: 'E-postanız ne hakkında?',
                                counterText: ''),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Lütfen bir konu yazın.'
                                    : null,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                        ],
                        TextFormField(
                          key: ValueKey(_mail ? 'mail-body' : 'message-body'),
                          controller: _mail ? _mailBody : _message,
                          minLines: 3,
                          maxLines: 5,
                          maxLength: 2000,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              labelText:
                                  _mail ? 'E-posta içeriği' : 'Mesajınız',
                              hintText: 'Merhaba, …',
                              alignLabelWithHint: true),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Lütfen bir mesaj yazın.'
                                  : null,
                        ),
                        const SizedBox(height: 14),
                        Row(children: [
                          TextButton(
                              onPressed: _close, child: const Text('Vazgeç')),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: FilledButton.icon(
                                    key: const Key('send-preview'),
                                    onPressed: _sendPreview,
                                    icon: const Icon(Icons.send_rounded,
                                        size: 17),
                                    label: const Text('Gönder (demo)'),
                                  ))),
                        ]),
                      ])),
                ]),
          ),
        ),
      ),
    );
  }
}

class _LocalMessage {
  const _LocalMessage(
      {required this.body, required this.subject, required this.time});
  final String body;
  final String? subject;
  final TimeOfDay time;
}
