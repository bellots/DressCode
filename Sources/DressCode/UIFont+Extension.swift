import UIKit

extension UIFont {

    /// Returns a bold version of `self`
    public var bolded: UIFont {
        return fontDescriptor.withSymbolicTraits(.traitBold)
            .map { UIFont(descriptor: $0, size: 0) } ?? self
    }

    /// Returns an italic version of `self`
    public var italicized: UIFont {
        return fontDescriptor.withSymbolicTraits(.traitItalic)
            .map { UIFont(descriptor: $0, size: 0) } ?? self
    }

    /// Returns a scaled version of `self`
    func scaled(scaleFactor: CGFloat) -> UIFont {
        let newDescriptor = fontDescriptor.withSize(fontDescriptor.pointSize * scaleFactor)
        return UIFont(descriptor: newDescriptor, size: 0)
    }

    class func preferredCustomFont(forTextStyle textStyle: UIFont.TextStyle, fontName name:String) -> UIFont {
        // we are using the UIFontDescriptor which is less expensive than creating an intermediate UIFont
        let systemFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        let customFontDescriptor = UIFontDescriptor.init(fontAttributes: [
            UIFontDescriptor.AttributeName.family: name,
            UIFontDescriptor.AttributeName.size: systemFontDescriptor.pointSize // use the font size of the default dynamic font
        ])

        // return font of new family with same size as the preferred system font
        return UIFont(descriptor: customFontDescriptor, size: 0)
    }

}
