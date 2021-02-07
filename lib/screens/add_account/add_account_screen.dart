import 'dart:io';
import 'dart:math';

import 'package:async_redux/async_redux.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/entry.dart';
import '../../models/otp.dart';
import '../../redux/actions/entries.dart';
import '../../redux/actions/favicon.dart';
import '../../services/locator.dart';
import '../../services/password/password_service.dart';
import '../../services/qr/qr_service.dart';
import '../../utils/navigation_utils.dart';
import '../../utils/validate.dart';
import '../../validators/min_validator.dart';
import '../../widgets/button.dart';
import '../../widgets/otp/otp_widget.dart';
import '../../widgets/tags/tags_widget.dart';
import '../add_otp/add_otp_screen.dart';
import '../generate_password/generate_password_screen.dart';

class AddAccountScreen extends StatefulWidget {
  final Entry entry;

  AddAccountScreen({this.entry});

  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  bool isEditPush = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode notesFocus = FocusNode();

  bool isUsernameValid = false;
  bool isPasswordValid = false;

  bool isOtpAvailable = false;
  Otp otp = Otp();

  List<String> tags = [];

  String name = '';

  String username = '';
  void setUsername(String val) {
    setState(() {
      username = val;
      isUsernameValid = validate<bool>(
        MinValidator(
          min: 1,
        ),
        val,
        true,
        false,
      );
    });
  }

  String password = '';
  void setPassword(String val) {
    setState(() {
      password = val ?? '';

      isPasswordValid = val == null
          ? false
          : validate<bool>(
              MinValidator(
                min: 1,
              ),
              val,
              true,
              false,
            );
    });
  }

  String notes = '';

  @override
  void initState() {
    super.initState();

    initializeTextEditingControllers();
  }

  void initializeTextEditingControllers() {
    if (widget.entry != null) {
      setUsername(widget.entry.username);
      setPassword(widget.entry.password);
      processAddOtp(widget.entry.otp);

      setState(() {
        isEditPush = true;
        name = widget.entry.name;
        username = widget.entry.username;
        password = widget.entry.password;
        notes = widget.entry.note;

        nameController.text = name;
        usernameController.text = username;
        passwordController.text = password;
        notesController.text = notes;

        otp = widget.entry.otp;
        tags = widget.entry.tags;
      });
    }

    nameController.addListener(() {
      setState(() {
        name = nameController.text;
      });
    });

    usernameController.addListener(() {
      setUsername(usernameController.text);
    });

    passwordController.addListener(() {
      setPassword(passwordController.text);
    });

    notesController.addListener(() {
      setState(() {
        notes = notesController.text;
      });
    });
  }

  Future requestOtp({bool scan = false}) async {
    if (scan) {
      try {
        final otp = await locator<QRService>().scanQRForOtp();
        processAddOtp(otp);
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.getString('failed_qr'),
            ),
          ),
        );
      }
    } else {
      Otp otp = await navigate(
        context,
        AddOtpScreen(),
        height: 360,
        width: 460,
      );
      processAddOtp(otp);
    }
  }

  void processAddOtp(Otp _otp) {
    if (_otp != null) {
      setState(() {
        otp = _otp;
        isOtpAvailable = true;
      });
    }
  }

  void add() {
    final data = Entry(
      favicon: '',
      name: name,
      note: notes,
      password: password,
      username: username,
      colorId: Random.secure().nextInt(iconColors.length),
      id: locator<PasswordService>().generateRandomPassword(
        length: 24,
      ),
      tags: tags,
    );

    if (isOtpAvailable) {
      data.otp = otp;
    }

    Navigator.of(context).pop(data);
  }

  Future<void> edit() async {
    final data = Entry(
      favicon: widget.entry.favicon,
      name: name,
      note: notes,
      password: password,
      username: username,
      colorId: widget.entry.colorId,
      id: widget.entry.id,
      tags: tags,
      otp: otp,
    );

    await Provider.of<DispatchFuture>(context, listen: false)(ModifyEntryAction(
      widget.entry,
      data,
    ));

    if (data.name != widget.entry.name) {
      await Provider.of<DispatchFuture>(context, listen: false)(
          AddFaviconAction(
        data,
      ));
    }

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEditPush
              ? context.getString('edit_tooltip')
              : context.getString('add_account'),
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
        actions: [
          IconButton(
            onPressed: isUsernameValid && isPasswordValid
                ? () async {
                    if (isEditPush) {
                      await edit();
                    } else {
                      add();
                    }
                  }
                : null,
            tooltip: context.getString('done_tooltip'),
            icon: Icon(Feather.check_circle),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: context.getString('name_url').toUpperCase(),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                usernameFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: context.getString('username_email').toUpperCase(),
                errorText: !isUsernameValid
                    ? context.getString('empty_username')
                    : null,
              ),
              focusNode: usernameFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                passwordFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: context.getString('password').toUpperCase(),
                errorText: !isPasswordValid
                    ? context.getString('empty_password')
                    : null,
              ),
              focusNode: passwordFocus,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                notesFocus.requestFocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            Button(
              child: Text(
                context.getString('generate_password'),
              ),
              onClick: () async {
                String generatedPassword = await navigate(
                  context,
                  GeneratePasswordScreen(),
                  height: 412,
                  width: 460,
                );
                passwordController.text = generatedPassword;
                setPassword(generatedPassword);
              },
            ),
            TextFormField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: context.getString('notes').toUpperCase(),
              ),
              textInputAction: TextInputAction.done,
              focusNode: notesFocus,
              onFieldSubmitted: (val) {
                notesFocus.unfocus();
              },
            ),
            SizedBox(
              height: 12,
            ),
            Builder(
              builder: (context) => Button(
                child: Text(
                  context.getString('two_factor_authentication'),
                ),
                onClick: () async {
                  if (!Platform.isAndroid && !Platform.isIOS) {
                    // Directly request OTP parameters as user input on desktop platforms
                    await requestOtp();
                  } else {
                    // Show a bottom sheet with the options to scan or enter manually on mobile platforms
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Feather.camera),
                              title: Text(
                                context.getString('scan_qr'),
                              ),
                              onTap: () async {
                                Navigator.of(context).pop();
                                await requestOtp(scan: true);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.keyboard),
                              title: Text(
                                context.getString('enter_manually'),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                requestOtp();
                              },
                            ),
                            ListTile(
                              leading: Icon(Feather.x),
                              title: Text(
                                context.getString('cancel'),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            if (isOtpAvailable)
              SizedBox(
                height: 16,
              ),
            if (isOtpAvailable)
              OtpWidget(
                otp: otp,
              ),
            SizedBox(
              height: 16,
            ),
            TagsWidget(
              onChange: (newTags) {
                setState(() {
                  tags = newTags;
                });
              },
              tags: tags,
              showAdd: true,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposeTextEditingControllers();
    disposeFocusNodes();

    super.dispose();
  }

  void disposeTextEditingControllers() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    notesController.dispose();
  }

  void disposeFocusNodes() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    notesFocus.dispose();
  }
}
