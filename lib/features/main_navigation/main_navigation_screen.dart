import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  late final AnimationController _iconAnimationController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 1.0,
      upperBound: 1.2,
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }
  // statefull screen을 동시에 사용하면 GlobalKey를 사용해야 한다.
  // final screens = [
  //   StfScreen(key: GlobalKey()),
  //   StfScreen(key: GlobalKey()),
  //   Container(),
  //   StfScreen(key: GlobalKey()),
  //   StfScreen(key: GlobalKey()),
  // ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonLongPress() {
    _iconAnimationController.forward();
  }

  void _onPostVideoButtonLongPressUp() {
    _iconAnimationController.reverse().then((value) => _onPostVideoButtonTap());
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record video"),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 나타날 때 기본적으로 scaffold가 body를 조절하게되어 영상이 찌그러지게됨.
      // 영상이 찌그러지지 않게 하기 위해서 resizeToAvoidBottomInset해줌.
      resizeToAvoidBottomInset: false,
      // 아래 두 가지 방법은 사용자가 다른 화면으로 갈 때마다 index를 바꾸게 되고
      // 이전 화면은 완전히 없어진다. 그래서 다시 돌아와도 처음부터 화면을 만든다.
      // 한 번에 하나의 화면만 렌더링한다.
      // body: screens[_selectedIndex], // 1
      // body: screens.elementAt(_selectedIndex), // 2

      // 사용자가 있던 위치를 기억하기를 원할 때
      // 화면을 폐기시켜 버리는 것이 아니라 잠시만 사라지게 하는 것
      // 모든 화면을 그리긴 하지만 보이지는 않게, 즉 사용자에게 시각적으로 보이지 않게
      // Offstage 위젯: widget이 안 보이게 하면서 계속 존재하게 한다.
      body: Stack(
        children: [
          // Offstage widget과 Offstage children이 너무 많으면 모든 children이 동시에
          // 활성화 되어 render 된다. 즉, 실수로 한 화면에서 너무 많은 resource를 사용한다면 그
          // widget은 절대 없어지지 않을테니 앱 전체가 느려진다.
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: Container(),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                  text: "Home",
                  isSelected: _selectedIndex == 0,
                  icon: FontAwesomeIcons.house,
                  selectedIcon: FontAwesomeIcons.house,
                  onTap: () => _onTap(0),
                  selectedIndex: _selectedIndex),
              NavTab(
                  text: "Discover",
                  isSelected: _selectedIndex == 1,
                  icon: FontAwesomeIcons.compass,
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  onTap: () => _onTap(1),
                  selectedIndex: _selectedIndex),
              Gaps.h24,
              GestureDetector(
                onLongPress: _onPostVideoButtonLongPress,
                onLongPressUp: _onPostVideoButtonLongPressUp,
                onTap: _onPostVideoButtonTap,
                child: ScaleTransition(
                  scale: _iconAnimationController,
                  child: PostVideoButton(inverted: _selectedIndex != 0),
                ),
              ),
              Gaps.h24,
              NavTab(
                  text: "Inbox",
                  isSelected: _selectedIndex == 3,
                  icon: FontAwesomeIcons.message,
                  selectedIcon: FontAwesomeIcons.solidMessage,
                  onTap: () => _onTap(3),
                  selectedIndex: _selectedIndex),
              NavTab(
                  text: "Profile",
                  isSelected: _selectedIndex == 4,
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  onTap: () => _onTap(4),
                  selectedIndex: _selectedIndex),
            ],
          ),
        ),
      ),
    );
  }
}
