
import UIKit

public protocol ViewHolder: class {
  associatedtype RootViewType: UIView
}

public extension ViewHolder where Self: UIViewController {
  var rootView: RootViewType {
    guard let rootView = view as? RootViewType else { fatalError("Rootview type not found") }
    return rootView
  }
}
