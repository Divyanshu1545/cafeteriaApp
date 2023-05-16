import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

//app colors
Color bgColor = const Color.fromARGB(255, 200, 205, 244);
Color mainColor = const Color(0xFF000633);
Color accentColor = const Color.fromARGB(255, 236, 233, 92);

//colors for cards
List<Color> cardColors = [
  const Color.fromARGB(255, 255, 255, 255),
  const Color.fromARGB(255, 246, 215, 153),
  const Color.fromARGB(255, 171, 246, 148),
  const Color.fromARGB(255, 247, 153, 179),
  const Color.fromARGB(255, 241, 247, 143),
  const Color.fromARGB(255, 245, 132, 132),
  const Color.fromARGB(255, 144, 246, 226),
];
TextStyle listingStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w800,
  fontStyle: FontStyle.italic,
);

//font styling
TextStyle mainTitle = GoogleFonts.roboto(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
TextStyle mainContent = GoogleFonts.nunito(
  fontSize: 18,
  fontWeight: FontWeight.normal,
);
TextStyle dateTitle = GoogleFonts.roboto(
  fontSize: 11,
  fontWeight: FontWeight.w300,
);
