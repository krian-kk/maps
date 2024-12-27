import 'package:bloc/bloc.dart';
import 'package:maps/features/user/domain/entity/user.dart';
import 'package:maps/features/user/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  var errorCount = 0;

  UserBloc({required this.userRepository}) : super(UserLoading()) {
    on<UserEvent>((event, emit) async {
      // on<LoadUserEvent>(_onLoadUser);
      if (event is LoadUserEvent) {
        try {
          List<User> products = await userRepository.fetchUser();
          emit(UserLoaded(products));
        } catch (e) {
          errorCount++;
          if (errorCount == 2) {
            emit(UserError("Failed to load users. Please try again"));
          } else {
            List<User> products = await userRepository.fetchUser();
            emit(UserLoaded(products));
          }
        }
      }
    });
  }
}