import 'package:event_bus/event_bus.dart';
import 'package:wan/model/dto/login_dto.dart';

EventBus bus = EventBus();

class ThemeEvent {
  int theme;
  bool darkTheme;

  ThemeEvent(this.theme, this.darkTheme);
}

class LoginEvent {
  LoginDTO data;

  LoginEvent({this.data});
}

class AddTodoEvent {
  int type;

  AddTodoEvent(this.type);
}
