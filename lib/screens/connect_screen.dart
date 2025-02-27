import 'package:flutter/material.dart';

import 'package:passy/common/synchronization_wrapper.dart';
import 'package:passy/passy_data/loaded_account.dart';
import 'package:passy/passy_flutter/passy_theme.dart';

import 'main_screen.dart';

class ConnectScreen extends StatefulWidget {
  static const routeName = '${MainScreen.routeName}/connect';

  const ConnectScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectScreen();
}

class _ConnectScreen extends State<ConnectScreen> {
  String _address = '';

  _ConnectScreen();

  @override
  Widget build(BuildContext context) {
    LoadedAccount _account =
        ModalRoute.of(context)!.settings.arguments as LoadedAccount;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: PassyTheme.appBarButtonPadding,
          splashRadius: PassyTheme.appBarButtonSplashRadius,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Connect'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(children: [
              const Spacer(),
              RichText(
                text: const TextSpan(
                  text: 'You have to be on the ',
                  children: [
                    TextSpan(
                      text: 'same network ',
                      style: TextStyle(
                          color: PassyTheme.lightContentSecondaryColor),
                    ),
                    TextSpan(
                        text:
                            'as the host to connect.\n\nEnter host address as shown '),
                    TextSpan(
                      text: 'below the QR code',
                      style: TextStyle(
                          color: PassyTheme.lightContentSecondaryColor),
                    ),
                    TextSpan(text: ':\n'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Row(children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: PassyTheme.passyPadding.right,
                        top: PassyTheme.passyPadding.top,
                        bottom: PassyTheme.passyPadding.bottom),
                    child: TextFormField(
                      initialValue: _address,
                      decoration: const InputDecoration(
                        labelText: 'Host address',
                      ),
                      onChanged: (s) => setState(() => _address = s),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: PassyTheme.passyPadding.right),
                    child: FloatingActionButton(
                      onPressed: () => SynchronizationWrapper(context: context)
                          .connect(_account, address: _address),
                      child: const Icon(Icons.sync_rounded),
                    ),
                  ),
                )
              ]),
              const Spacer(),
            ]),
          ),
        ],
      ),
    );
  }
}
