import UIKit

public enum ExampleStylableView<View>:String, CaseIterable, StylableView{
        
    case primary
    case secondary
    case accent
    
    public func style(for theme: Themeable) -> Property<View> {
        return .empty()
    }
}

public extension Property {
    static func theme(for styleView:ExampleStylableView<Element>, forTheme theme:Themeable = ExampleThemeable.defaultTheme) -> Property<Element>{
        return styleView.style(for: theme)
    }
}

public extension Stylable{
    func applyStyleView(_ styleView:ExampleStylableView<Self>, for theme:Themeable = ExampleThemeable.defaultTheme){
        setStyle(styleView.style(for: theme))
    }
}

public extension ExampleStylableView where View:UIView{
    func applyStyleView(for theme:Themeable = ExampleThemeable.defaultTheme, to views:View...){
        views.forEach({$0.setStyle(self.style(for: theme))})
    }
}

public extension UIView{
    func applyStyleView(_ styleView:ExampleStylableView<UIView>, for theme:Themeable = ExampleThemeable.defaultTheme){
        setStyle(styleView.style(for: theme))
    }
}

//public extension UIButton{
//    func applyStyleView(_ styleView:ExampleStylableView<UIButton>, for theme:Themeable = ExampleThemeable.defaultTheme){
//        setStyle(styleView.style(for: theme))
//    }
//}

