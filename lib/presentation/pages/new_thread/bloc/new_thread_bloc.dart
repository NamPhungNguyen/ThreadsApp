import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_thread_event.dart';
part 'new_thread_state.dart';

class NewThreadBloc extends Bloc<NewThreadEvent, NewThreadState> {
  NewThreadBloc() : super(NewThreadInitial());
}
