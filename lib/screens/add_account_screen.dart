import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passy/common/assets.dart';
import 'package:passy/common/common.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  static const routeName = '/addAccount';

  @override
  State<StatefulWidget> createState() => _AddAccountScreen();
}

class _AddAccountScreen extends State<StatefulWidget> {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  Widget? _floatingBackButton;

  static const _loginInUseSnackBar =
      SnackBar(content: Text('Login is already in use'));
  static const _twoLettersSnackBar =
      SnackBar(content: Text('Username is shorter than 2 letters'));
  static const _usernameEmptySnackBar =
      SnackBar(content: Text('Username is empty'));
  static const _passwordEmptySnackBar =
      SnackBar(content: Text('Password is empty'));
  static const _passwordsDoNotMatch =
      SnackBar(content: Text('Passwords do not match'));

  void _addAccount() {
    if (_username.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(_usernameEmptySnackBar);
      return;
    }
    if (_username.length < 2) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(_twoLettersSnackBar);
      return;
    }
    if (data.hasAccount(_username)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(_loginInUseSnackBar);
      return;
    }
    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(_passwordEmptySnackBar);
      return;
    }
    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(_passwordsDoNotMatch);
      return;
    }
    data.createAccount(
      _username,
      _password,
    );
    data.info.value.lastUsername = _username;
    data.info.save();
    loadApp(context);
  }

  @override
  void initState() {
    super.initState();
    _floatingBackButton = data.noAccounts
        ? null
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: getBackButton(context),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingBackButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const Spacer(),
              purpleLogo,
              const Spacer(),
              const Text(
                'Add an account',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (a) => _username = a,
                                  decoration: const InputDecoration(
                                    hintText: 'Username',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(' ')
                                  ],
                                  autofocus: true,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  obscureText: true,
                                  onChanged: (a) => _password = a,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(' '),
                                    LengthLimitingTextInputFormatter(32),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Confirm password',
                                  ),
                                  onChanged: (a) => _confirmPassword = a,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(' '),
                                    LengthLimitingTextInputFormatter(32),
                                  ],
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: _addAccount,
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                ),
                                heroTag: 'addAccountBtn',
                              ),
                            ],
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                      flex: 10,
                    ),
                    const Spacer(),
                  ],
                ),
                flex: 4,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
