import 'package:auth/data/user/user.dart';
import 'package:auth/generated/auth.pb.dart';
import 'package:auth/utils.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("", () {
    test('Проверка функции areUserDtoEqual', () {
      assert(Utils.areUserDtoEqual(
          UserDto(id: '1', username: 'test_username', email: 'test@mail.ru'),
          UserDto(id: '1', username: 'test_username', email: 'test@mail.ru')));
    });
    test('Проверка функции getUserDtoFromUserVeiw', () {
      assert(Utils.areUserDtoEqual(
          UserDto(id: '1', username: 'test_username', email: 'test@mail.ru'),
          Utils.getUserDtoFromUserVeiw(UserView(
              id: 1, username: 'test_username', email: 'test@mail.ru'))));
    });
  });
}
