part of '../home_page.dart';

extension UserPostThreads on HomePage {
  Widget _buildNewPostThreads() {
    return GestureDetector(
      onTap: () => {print("New Post Threads")},
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderDark,
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: CachedNetworkImageProvider(
                'https://i.pinimg.com/736x/e9/e0/7d/e9e07de22e3ef161bf92d1bcf241e4d0.jpg',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nguyen Phung Nam"),
                  SizedBox(height: 2),
                  Text(
                    "What's new?",
                    style: TextStyle(
                      color: AppColors.hintText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
