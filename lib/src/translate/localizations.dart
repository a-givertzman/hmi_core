import 'package:hmi_core/hmi_core_log.dart';
import 'package:hmi_core/src/core/json/json_map.dart';
import 'package:hmi_core/src/translate/app_lang.dart';
///
class Localizations {
  static final _log = const Log('Localizations')..level=LogLevel.warning;
  static AppLang _appLang = AppLang.en;
  static final _map = <String, List<String>>{
    'Ok': ['Ok', 'Ok',],
    'Cancel': ['Cancel', 'Отмена'],
    'Next': ['Next', 'Далее',],
    'Apply': ['Apply', 'Применить',],
    'Reload': ['Reload', 'Перезагрузить',],
    'Send error report': ['Send error report', 'Отправить отчет об ошибке'],
    'and': ['and', 'и'],
    //
    // Авторизация
    'Admin': ['Admin', 'Админ'],
    'Administrator': ['Administrator', 'Администратор'],
    'Operator': ['Operator', 'Оператор'],
    'Guest': ['Guest', 'Гость'],
    //
    'Login must be..': [
      'Login must 5...255 chars like a..z, A..Z, 0..9, "-", "_", "."', 
      'Логин должен содержать состоять 5...255 символов a..z, A..Z, 0..9, "-", "_", "."',
    ],
    'Please authenticate to continue...': [
      'Please authenticate to continue...', 
      'Авторизуйтесь что бы продолжить...',
    ],
    'User': ['User', 'Пользователь'],
    'is not found': ['is not found', 'не найден'],
    'User account': ['User account', 'Личный кабинет',],
    'Authentication': ['Authentication', 'Авторизация',],
    'Signing up': ['Signing up', 'Регистрация',],
    'Change password': ['Change password', 'Сменить пароль',],
    'Changing password': ['Changing password', 'Смена пароля',],
    'Please enter your login': [
      'Please enter your login', 
      'Введите ваш логин',
    ],
    'Please enter your password': [
      'Please enter your password', 
      'Введите ваш пароль',
    ],
    'User already authenticated': ['User already authenticated', 'Пользователь уже авторизован'],
    'Your number': ['Your number', 'Ваш номер',],
    'Your login': ['Your login', 'Ваш логин',],
    'Your password': ['Your password', 'Ваш пароль',],
    'Wrong number': ['Wrong number', 'Неверный номер',],
    'Wrong login': ['Wrong login', 'Неверный логин',],
    'User not found': ['User not found', 'Пользователь не найден',],
    'Wrong password': ['Wrong password', 'Неверный пароль',],
    'Wrong login or password': [
      'Wrong login or password', 
      'Неверный логин или пароль',
    ],
    'Authentication error': ['Authentication error', 'Ошибка авторизации'],
    'Check the network connection to the database': ['Check the network connection to the database', 'Проверьте сетевое подключение к базе данных'],
    'Authenticated successfully': ['Authenticated successfully', 'Авторизован успешно'],
    'User logout': ['User logout', 'Выйти из профиля',],
    'Editing is not permitted for current user': ['Editing is not permitted for current user', 'Изменение не разрешено для текущего пользователя'],
    'Logged out': ['Logged out', 'Вышел из системы'],
    //
    //
    'Acknowledge the event': ['Acknowledge the event', 'Квитировать событие'],
    //
    //
    'Home': ['Home', 'Домашний',],
    'Main page': ['Main page', 'Главная'],
    'Alarm page': ['Alarm page', 'Аварии'],
    'Event page': ['Event page', 'События'],
    'Settings page': ['Settings page', 'Уставки',],
    'Preferences page': ['Preferences page', 'Настройки',],
    //
    'Connection': ['Connection', 'Связь'],
    'Crane monitoring': ['Crane monitoring', 'Диагностика крана',],
    'Mode': ['Mode', 'Режим'],
    'Harbour': ['Harbour', 'В порту'],
    'In sea': ['In sea', 'В море'],
    'Select crane mode': ['Select crane mode', 'Выбор режима работы крана'],
    'Select winch mode': ['Select winch mode', 'Выбор режима работы лебедки'],
    'Select wave hight level': ['Select wave hight level', 'Выбор уровня высоты волны'],
    'Winch': ['Winch', 'Лебедка'],
    'Winch 1': ['Winch 1', 'Лебедка 1'],
    'Winch 2': ['Winch 2', 'Лебедка 2'],
    'Winch 3': ['Winch 3', 'Лебедка 3'],
    'Main winch': ['Main winch', 'Главная лебедка'],
    'Main boom': ['Main boom', 'Основная стрела'],
    'Main boom angle': ['Main boom angle', 'Угол наклона основной стрелы'],
    'Knuckle jib': ['Knuckle jib', 'Хобот'],
    'Knuckle jib angle': ['Knuckle jib angle', 'Угол наклона хобота'],
    'Crane slewing angle': ['Crane slewing angle', 'Угол поворота крана'],
    'Accumulator': ['Accumulator', 'Аккумулятор'],
    'Winch mode': ['Winch mode', 'Режим лебедки'],
    'Freight': ['Freight', 'Грузовой'],
    'AHC': ['AHC', 'AHC'],
    'Manriding': ['Manriding', 'Люди'],
    'Wind': ['Wind', 'Ветер'],
    'Pitch': ['Pitch', 'Дифферент'],
    'Roll': ['Roll', 'Крен'],
    'Oil temp': ['Oil temp', 'Температура масла'],
    'Onboard': ['Onboard', 'Над палубой'],
    'Parking': ['Parking', 'Парковка'],
    'Offshore': ['Offshore', 'За бортом'],
    'MOPS': ['MOPS', 'MOPS'],
    'AOPS': ['AOPS', 'AOPS'],
    'Brake': ['Brake', 'Тормоз'],
    'SWH': ['SWH', 'SWH'],
    'Load': ['Load', 'Нагрузка'],
    'Oil level': ['Oil level', 'Уровень масла'],
    'Pressure': ['Pressure', 'Давление'],
    'Temp': ['Temp', 'Темп'],
    'Temperature': ['Temperature', 'Температура'],
    'Drainage temp': ['Drainage temp', 'Темп дренажа'],
    'Constant tension': ['Constant tension', 'Пост натяж'],
    'Tension factor': ['Tension factor', 'Степень натяжения'],
    'Depth abs': ['Depth abs', 'Глубина абс'],
    'Absolute depth': ['Absolute depth', 'Абсолютная глубина'],
    'Rel depth': ['Rel depth', 'Отн глуб'],
    'Relative depth': ['Relative depth', 'Относительная глубина'],
    'Deck depth': ['Deck depth', 'Глубина от палубы'],
    'Hook speed': ['Hook speed', 'Скорость крюка'],
    'HPU': ['HPU', 'HPU'],
    'HPU 1': ['HPU 1', 'Насос 1'],
    'HPU 2': ['HPU 2', 'Насос 2'],
    'Emergency HPU': ['Emergency HPU', 'Авар насос'],
    'Emergency HPU 1': ['Emergency HPU 1', 'Авар насос ст 1'],
    'Emergency HPU 2': ['Emergency HPU 2', 'Авар насос ст 2'],
    'Hydraulic tank': ['Hydraulic tank', 'Гидравлический бак'],
    'Hydraulic power unit': ['Hydraulic power unit', 'Гидравлический силовой агрегат'],
    'Emergency hydraulic power unit': ['Emergency hydraulic power unit', 'Аварийный гидравлический силовой агрегат'],
    'Cooler': ['Cooler', 'Теплообменник'],
    'Slewing': ['Slewing', 'Поворот'],
    'Radius': ['Radius', 'Вылет'],
    'MarchingMode': ['MarchingMode', 'По походному'],
    'Rotation': ['Rotation', 'Поворот'],
    //
    'Date from': ['Date from', 'Дата от'],
    'To': ['To', 'До'],
    'Find': ['Find', 'Поиск'],
    //
    // Единицы измерения
    't': ['t', 'т'],
    's': ['s', 'с'],
    'm': ['m', 'м'],
    'mm': ['mm', 'мм'],
    'm/s': ['m/s', 'м/с'],
    'm/min': ['m/min', 'м/мин'],
    '% of SWL': ['% of SWL', '% от SWL'],
    'ms': ['ms', 'мс'],
    'rpm': ['rpm', 'об/мин'],
    //
    // Информационные сообщения 
    'Welcome': ['Welcome', 'Добро пожаловать',],
    'Under development': ['Under development', 'В разработке',],
    'Loading...': ['Loading...', 'Загружаю...',],
    'No notices': ['No notices', 'Сообщений нет',],
    'Canceled by user': ['Canceled by user', 'Отменено пользователем'],
    'Try to check network connection': ['Try to check network connection', 'Проверьте сетевое подключение'],
    'to the database': ['to the database', 'к базе данных'],
    'No events': ['No events', 'Нет событий'],
    'No alarms': ['No alarms', 'Нет аварий'],
    //
    // Предупредительные сообщения
    'This function not implemented': [
      'This function not implemented', 
      'Данный функционал еще не реализован',
    ],
    //
    // Ошибки
    'Error': ['Error', 'Ошибка',],
    'Reading data error': ['Reading data error', 'Ошибка при чтении данных'],
    'Invalid date value': ['Invalid date value', 'Недопустимое значение'],
    'Error retrieving events from the database': [
      'Error retrieving events from the database', 
      'Ошибка при получении событий из базы данных',
    ],
    'Please check connection to the database': [
      'Please check connection to the database', 
      'Пожалуйста, проверьте подключение к базе данных',
    ],
    //
    // Экран настроек | SettingsBasicProtectionsTab
    'Basic protections': ['Basic protections', 'Основные защиты'],
    'ART Torque limitation': ['ART Torque limitation', 'ART Ограничение крутящего момента'],
    'AOPS Rotation angle limit 5/7.5t': ['AOPS Rotation angle limit 5/7.5t', 'AOPS Ограничение угла поворота 5/7.5t'],
    'AOPS Rotation angle limit 20/23t': ['AOPS Rotation angle limit 20/23t', 'AOPS Ограничение угла поворота 20/23t'],
    //
    // Экран настроек | SettingsHpuTab
    'Oil Type': ['Oil Type', 'Тип масла'],
    'Emergency high oil level': ['Emergency high oil level', 'Аварийно высокий уровень масла'],
    'High oil level': ['High oil level', 'Высокий уровень масла'],
    'Emergency low oil level': ['Emergency low oil level', 'Аварийно низкий уровень масла'],
    'Low oil level': ['Low oil level', 'Низкий уровень масла'],
    'High oil temperature': ['High oil temperature', 'Высокая температура масла'],
    'Emergency high oil temperature': ['Emergency high oil temperature', 'Аварийно высокая температура масла'],
    'Low oil temperature': ['Low oil temperature', 'Низкая температура масла'],
    'Oil cooling': ['Oil cooling', 'Охлаждение масла'],
    'Oil temperature hysteresis': ['Oil temperature hysteresis', 'Гистерезис температуры масла'],
    'Water flow tracking timeout': ['Water flow tracking timeout', 'Тайм-аут отслеживания потока воды'],
    //
    // Экран настроек | SettingsMainWinchTab | SettingsMainBoomTab | SettingsRotaryBoomTab | SettingsRotationTab
    'Speed deceleration on one pump': ['Speed deceleration on one pump', 'Замедление скорости на одном насосе'],
    'Speed limit for slow types of work': ['Speed limit for slow types of work', 'Ограничение скорости при медленных видах работ'],
    'Speed limit at > 2 movement': ['Speed limit at > 2 movement', 'Ограничение скорости при > 2 движ'],
    'Linear acceleration time': ['Linear acceleration time', 'Время линейного ускорения'],
    'Linear deceleration time': ['Linear deceleration time', 'Время линейного замедления'],
    'Quick Stop time': ['Quick Stop time', 'Время быстрой остановки'],
    'Position of switching to mode': ['Position of switching to mode', 'Положение перехода в режим'],
    'Speed limit at the maximum position': ['Speed limit at the maximum position', 'Ограничение скорости у максимального положения'],
    'Speed limit at the minimum position': ['Speed limit at the minimum position', 'Ограничение скорости у минимального положения'],
    'Speed deceleration position': ['Speed deceleration position', 'Позиция понижения скорости'],
    'Speed limit to': ['Speed limit to', 'Ограничение скорости до'],
    'Default position': ['Default position', 'Предустановленное положение'],
    'Reset position': ['Reset position', 'Положение сброса'],
    'Position': ['Position', 'Положение'],
    'Speed limit at position': ['Speed limit at position', 'Ограничение скорости у положения'],
    //
    // Экран Аккумулятор | AccumulatorPage
    'High pressure accumulator': ['High pressure accumulator', 'Аккумулятор высокого давления'],
    'Low pressure accumulator': ['Low pressure accumulator', 'Аккумулятор низкого давления'],
    'Piston max limit': ['Piston max limit', 'Верхний предел поршня'],
    'Piston min limit': ['Piston min limit', 'Нижний предел поршня'],
    'Pressure of nitro': ['Pressure of nitro', 'Давление азота'],
    'Emergency high nitro pressure': ['Emergency high nitro pressure', 'Аварийно высокое давление азота'],
    //
    // Экран Лебедка | Winch_n_Page
    'Hydromotor': ['Hydromotor', 'Гидромотор'],
    'Rotation speed': ['Rotation speed', 'Скорость вращения'],
    'Rope length': ['Rope length', 'Длина каната'],
    'LVDT': ['LVDT', 'LVDT'],
    'Pressure of brake': ['Pressure of brake', 'Давление тормоза'],
    'Hydromotor state': ['Hydromotor state', 'Состояние гидромотора'],
  };
  ///
  /// First initialization of application language
  static Future<void> initialize(AppLang appLang, {JsonMap<List>? jsonMap}) async {
    _appLang = appLang;
    if (jsonMap != null) {
      await jsonMap.decoded
        .then((map) => map.map(
          (key, value) => MapEntry(key, value.cast<String>()),
        ))
        .then((map) => _map.addAll(map));
    }
  }
  ///
  /// returns translation for current lang 
  /// - To customize translation language call Localizations.initialize 
  static String getTranslation(String text) {
    final translations = _map[text];
    if(translations == null) {
      final normalizedText = text.toLowerCase().trim();
      return _map.entries
        .firstWhere(
          (entry) => entry.key.toLowerCase().trim() == normalizedText,
          orElse: () {
            _log.warning('Ошибка в методе $Localizations.getTranslations(): Не задан перевод для "$text"');
            return MapEntry(
              text, 
              List.filled(AppLang.values.length, text),
            );
          },
        ).value[_appLang.index];
    }
    return translations[_appLang.index];
  }
}
