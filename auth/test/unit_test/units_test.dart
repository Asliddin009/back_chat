import 'package:auth/data/user/user.dart';
import 'package:auth/generated/auth.pb.dart';
import 'package:auth/utils.dart';
import 'package:test/test.dart';

void main() {
  test('Проверка функции getUserDtoFromUserVeiw', () {
    assert(identical(
        UserDto(id: '1', username: 'test_username'),
        Utils.getUserDtoFromUserVeiw(
            UserView(id: 1, username: 'test_username'))));
  });
}
