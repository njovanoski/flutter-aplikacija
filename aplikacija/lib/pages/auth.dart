import 'package:aplikacija/widgets/ui_elements/adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../models/auth.dart';

class EmailFieldValidator {
  static String validate(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'Password invalid';
    } else {
      return null;
    }
  }
}

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  AnimationController _controller;
  Animation<Offset> _slideAnimation;

  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      // ignore: missing_return
      validator: (String value) => EmailFieldValidator.validate(value),

      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      // ignore: missing_return
      validator: (String value) => PasswordFieldValidator.validate(value),

      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
      child: SlideTransition(
        position: _slideAnimation,
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Confirm Password',
              filled: true,
              fillColor: Colors.white),
          obscureText: true,
          // ignore: missing_return
          validator: (String value) {
            if (_passwordTextController.text != value &&
                _authMode == AuthMode.Singup) {
              return 'Passwords do not match';
            }
          },
        ),
      ),
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> sucessInformation;

    sucessInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (sucessInformation['success']) {
      //Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An error occured!'),
            content: Text(sucessInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordConfirmTextField(),
                    _buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      child: Text(
                          'Switch to ${_authMode == AuthMode.Login ? 'Singup' : 'Login'}'),
                      onPressed: () {
                        setState(() {
                          if (_authMode == AuthMode.Login) {
                            setState(() {
                              _authMode = AuthMode.Singup;
                            });
                            _controller.forward();
                          } else {
                            setState(() {
                              _authMode = AuthMode.Login;
                              _controller.reverse();
                            });
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return model.isLoading
                            ? AdaptiveProgressIndicator()
                            : RaisedButton(
                                textColor: Colors.white,
                                child: Text(_authMode == AuthMode.Login
                                    ? 'LOGIN'
                                    : 'SINGUP'),
                                onPressed: () =>
                                    _submitForm(model.authenticate),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
