final validSettings = [
  {
    'text_file': '{"test_setting_1":0,"test_setting_2":27,"test_setting_3":-123}',
    'set_settings': {
      'test_setting_1': 0,
      'test_setting_2': 27,
      'test_setting_3': -123,
    }
  },
  {
    'text_file': '{"test_setting_1":0.0,"test_setting_2":123.45,"test_setting_3":-678.9}',
    'set_settings': {
      'test_setting_1': 0.0,
      'test_setting_2': 123.45,
      'test_setting_3': -678.9,
    }
  },
];
final invalidSettings = [
  {
    'text_file': '{"test_setting_1":"asd","test_setting_2":true,"test_setting_3":"bcde"}',
  },
  {
    'text_file': '{"test_setting_1":false,"test_setting_2":123,"test_setting_3":"abc"}',
  },
  {
    'text_file': '{"test_setting_1":false,"test_setting_2":"fjkdfgjgd","test_setting_3":123.456}',
  },
];
final invalidJsons = [
  {
    'text_file': '{',
  },
  {
    'text_file': 'asd',
  },
  {
    'text_file': '{"test":123',
  },
];
