import 'package:cradle/common/pictures.dart';

class Onboarding{
  final String image;
  final String description;
  Onboarding({
    required this.image,
    required this.description,
});
}

List<Onboarding> onBodyContent = [
  Onboarding(
      image: Pictures.onboarding2,
      description: "Ready to dive into the news? \n Let's get cracking!"
  ),
  Onboarding(
      image: Pictures.onboarding1,
      description: "Discover the world, one story at a time. \n Welcome to Cradle, \n your personalized news haven."
  )
];