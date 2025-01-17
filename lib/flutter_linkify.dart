import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linkify/linkify.dart';

export 'package:linkify/linkify.dart'
    show
        LinkifyElement,
        LinkifyOptions,
        LinkableElement,
        TextElement,
        Linkifier,
        UrlElement,
        UrlLinkifier,
        EmailElement,
        EmailLinkifier;

/// Callback clicked link
typedef LinkCallback(LinkableElement link);

/// Turns URLs into links
class Linkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style for non-link text
  final TextStyle style;

  /// Style of link text
  final TextStyle linkStyle;

  // RichText

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// Text direction of the text
  final TextDirection textDirection;

  /// The maximum number of lines for the text to span, wrapping if necessary
  final int maxLines;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel
  final double textScaleFactor;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// The strut style used for the vertical layout
  final StrutStyle strutStyle;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale
  final Locale locale;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis textWidthBasis;

  /// Text to be displayed before the main [text]
  final String prefixText;

  /// Style for [prefixText]
  final TextStyle prefixTextStyle;

  const Linkify({
    Key key,
    @required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options,
    // TextSpan
    this.style,
    this.linkStyle,
    // RichText
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.softWrap = true,
    this.strutStyle,
    this.locale,
    this.textWidthBasis = TextWidthBasis.parent,
    this.prefixText,
    this.prefixTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: options,
      linkifiers: linkifiers,
    );

    return Text.rich(
      buildTextSpan(
        elements,
        style: Theme.of(context).textTheme.bodyText2.merge(style),
        onOpen: onOpen,
        prefixText: prefixText,
        prefixTextStyle: prefixTextStyle,
        maxLines: maxLines,
        overflow: overflow,
        strutStyle: strutStyle,
        linkStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(style)
            .copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyle),
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      softWrap: softWrap,
      strutStyle: strutStyle,
      locale: locale,
      textWidthBasis: textWidthBasis,
    );
  }
}

/// Turns URLs into links
class SelectableLinkify extends StatelessWidget {
  /// Text to be linkified
  final String text;

  /// Linkifiers to be used for linkify
  final List<Linkifier> linkifiers;

  /// Callback for tapping a link
  final LinkCallback onOpen;

  /// linkify's options.
  final LinkifyOptions options;

  // TextSpan

  /// Style for non-link text
  final TextStyle style;

  /// Style of link text
  final TextStyle linkStyle;

  // RichText

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// Text direction of the text
  final TextDirection textDirection;

  /// The minimum number of lines to occupy when the content spans fewer lines.
  final int minLines;

  /// The maximum number of lines for the text to span, wrapping if necessary
  final int maxLines;

  /// The strut style used for the vertical layout
  final StrutStyle strutStyle;

  /// Defines how to measure the width of the rendered text.
  final TextWidthBasis textWidthBasis;

  // SelectableText

  /// Defines the focus for this widget.
  final FocusNode focusNode;

  /// Whether to show cursor
  final bool showCursor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Configuration of toolbar options
  final ToolbarOptions toolbarOptions;

  /// How thick the cursor will be
  final double cursorWidth;

  /// How rounded the corners of the cursor should be
  final Radius cursorRadius;

  /// The color to use when painting the cursor
  final Color cursorColor;

  /// Determines the way that drag start behavior is handled
  final DragStartBehavior dragStartBehavior;

  /// If true, then long-pressing this TextField will select text and show the cut/copy/paste menu,
  /// and tapping will move the text caret
  final bool enableInteractiveSelection;

  /// Called when the user taps on this selectable text (not link)
  final GestureTapCallback onTap;

  final ScrollPhysics scrollPhysics;

  const SelectableLinkify({
    Key key,
    @required this.text,
    this.linkifiers = defaultLinkifiers,
    this.onOpen,
    this.options,
    // TextSpan
    this.style,
    this.linkStyle,
    // RichText
    this.textAlign,
    this.textDirection,
    this.minLines,
    this.maxLines,
    // SelectableText
    this.focusNode,
    this.strutStyle,
    this.showCursor = false,
    this.autofocus = false,
    this.toolbarOptions,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.scrollPhysics,
    this.textWidthBasis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: options,
      linkifiers: linkifiers,
    );

    return SelectableText.rich(
      buildTextSpan(
        elements,
        style: Theme.of(context).textTheme.bodyText2.merge(style),
        onOpen: onOpen,
        strutStyle: strutStyle,
        maxLines: maxLines,
        linkStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .merge(style)
            .copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            )
            .merge(linkStyle),
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      strutStyle: strutStyle,
      showCursor: showCursor,
      autofocus: autofocus,
      toolbarOptions: toolbarOptions,
      cursorWidth: cursorWidth,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: onTap,
      scrollPhysics: scrollPhysics,
      textWidthBasis: textWidthBasis,
    );
  }
}

class LinkableSpan extends WidgetSpan {
  LinkableSpan({
    @required MouseCursor mouseCursor,
    @required InlineSpan inlineSpan,
    StrutStyle strutStyle,
    int maxLines,
    TextOverflow overflow,
  }) : super(
          child: MouseRegion(
            cursor: mouseCursor,
            child: Text.rich(
              inlineSpan,
              strutStyle: strutStyle,
              maxLines: maxLines,
              overflow: overflow,
            ),
          ),
        );
}

/// Raw TextSpan builder for more control on the RichText
TextSpan buildTextSpan(
  List<LinkifyElement> elements, {
  TextStyle style,
  TextStyle linkStyle,
  LinkCallback onOpen,
  String prefixText,
  TextStyle prefixTextStyle,
  StrutStyle strutStyle,
  int maxLines,
  TextOverflow overflow,
}) {
  return TextSpan(
    text: prefixText,
    style: prefixTextStyle,
    children: elements.map<WidgetSpan>(
      (element) {
        if (element is LinkableElement) {
          return LinkableSpan(
            mouseCursor: SystemMouseCursors.click,
            inlineSpan: TextSpan(
              text: element.text,
              style: linkStyle,
              recognizer: onOpen != null
                  ? (TapGestureRecognizer()..onTap = () => onOpen(element))
                  : null,
            ),
            strutStyle: strutStyle,
            maxLines: maxLines,
            overflow: overflow,
          );
        } else {
          return WidgetSpan(
            child: Text.rich(
              TextSpan(
                text: element.text,
                style: style,
              ),
              strutStyle: strutStyle,
              maxLines: maxLines,
              overflow: overflow,
            ),
          );
        }
      },
    ).toList(),
  );
}
