import UIKit

public enum TestStylableView<View>:String, CaseIterable, StylableView{
        
    case primary
    case secondary
    case accent
    
    public func style(for theme: Themeable) -> Property<View> {
        return .empty()
    }
}

public extension Property {
    static func theme(for styleView:TestStylableView<Element>, forTheme theme:Themeable = Theme.defaultTheme) -> Property<Element>{
        return styleView.style(for: theme)
    }
}

public extension Stylable{
    func applyStyleView(_ styleView:TestStylableView<Self>, for theme:Themeable = Theme.defaultTheme){
        setStyle(styleView.style(for: theme))
    }
}

public extension TestStylableView where View:UILabel{
    func applyStyleView(for theme:Themeable = Theme.defaultTheme, to views:View...){
        views.forEach({$0.setStyle(self.style(for: theme))})
    }
}

public extension TestStylableView where View:UIButton{
    func applyStyleView(for theme:Themeable = Theme.defaultTheme, to views:View...){
        views.forEach({$0.setStyle(self.style(for: theme))})
    }
}

public extension UILabel{
    func applyStyleView(_ styleView:TestStylableView<UILabel>, for theme:Themeable = Theme.defaultTheme){
        setStyle(styleView.style(for: theme))
    }
}

public extension UIButton{
    func applyStyleView(_ styleView:TestStylableView<UIButton>, for theme:Themeable = Theme.defaultTheme){
        setStyle(styleView.style(for: theme))
    }
}

