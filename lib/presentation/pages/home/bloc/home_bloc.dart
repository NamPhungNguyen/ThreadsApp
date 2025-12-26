import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/domain/entities/thread/thread_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_onInitial);
  }

  Future<void> _onInitial(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    // TODO: Replace with real API call
    await Future.delayed(const Duration(seconds: 1));

    final threads = _getMockThreads();
    emit(HomeLoaded(threads: threads));
  }

  List<ThreadEntity> _getMockThreads() {
    return [
      ThreadEntity(
        id: '1',
        content: 'Check out this amazing photo!',
        media: [
          MediaEntity(
            url: 'https://images.pexels.com/photos/20354072/pexels-photo-20354072.jpeg',
            type: MediaType.image,
          ),
        ],
        isLinkTopic: true,
        isVerified: true,
        likeCount: 7982000,
        commentCount: 12223,
        repostCount: 44,
        shareCount: 11,
      ),
      ThreadEntity(
        id: '2',
        content: 'Beautiful sunset photos from my trip',
        media: [
          MediaEntity(
            url: 'https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg',
            type: MediaType.image,
          ),
          MediaEntity(
            url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
            type: MediaType.video,
          ),
          MediaEntity(
            url: 'https://images.pexels.com/photos/29775096/pexels-photo-29775096.jpeg',
            type: MediaType.image,
          ),
        ],
        isVerified: true,
        likeCount: 5421,
        commentCount: 342,
        repostCount: 89,
        shareCount: 23,
      ),
      ThreadEntity(
        id: '3',
        content: 'Amazing performance!',
        media: [
          MediaEntity(
            url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
            type: MediaType.video,
          ),
        ],
        isLinkTopic: true,
        likeCount: 1892,
        commentCount: 156,
        repostCount: 34,
        shareCount: 8,
      ),
    ];
  }
}
