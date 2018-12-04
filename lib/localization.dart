/**
 * Let me WICHTEL that for you!
 * An application by nehegeb.
 */

// https://github.com/flutter/website/blob/master/src/_includes/code/internationalization/minimal/main.dart

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

// TODO: Getting the localization feature to work...

class LmgtfyLocalization {
  LmgtfyLocalization(this.locale);

  final Locale locale;

  static LmgtfyLocalization of(BuildContext context) {
    return Localizations.of<LmgtfyLocalization>(context, LmgtfyLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'test': 'Hello World',
    },
    'de': {
      'test': 'Hallo Welt',
    },
  };

  String get test {
    return _localizedValues[locale.languageCode]['test'];
  }
}

class LmgtfyLocalizationDelegate extends LocalizationsDelegate<LmgtfyLocalization> {
  const LmgtfyLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<LmgtfyLocalization> load(Locale locale) 
    return SynchronousFuture<LmgtfyLocalization>(LmgtfyLocalization(locale));
  }

  @override
  bool shouldReload(LmgtfyLocalizationDelegate old) => false;
}