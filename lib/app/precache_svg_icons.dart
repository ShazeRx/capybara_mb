import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

precacheSvgIcons() async {
  Future.wait(
    [
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.arrowBack),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.arrowNext),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.capybara),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.channel),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.email),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.logout),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.plus),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.user),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, SvgIcons.check),
        null,
      ),
    ],
  );
}
