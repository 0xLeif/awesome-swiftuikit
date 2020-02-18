import UIKit
import SwiftUIKit

class BrandedLoadingView: UIView {
    fileprivate var spinnerView = View()
    fileprivate var topLeftSpinnerView = View()
        .layer {  $0.addSublayer(dotLayer()) }
    fileprivate var bottomRightSpinnerView = View()
        .configure {
            $0.transform = $0.transform.rotated(by: .pi)
        }
        .layer { $0.addSublayer(dotLayer()) }
    
    init() {
        super.init(frame: .zero)
        
        embed(withPadding: 24) {
            spinnerView.embed {
                topLeftSpinnerView.embed {
                    bottomRightSpinnerView
                }
            }
        }
        .embed(withPadding: 32) {
            Image("logo_team_color")
                .contentMode(.scaleAspectFit)
                .frame(height: 64, width: 64)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() -> Self {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 2.5,
                           delay: 0,
                           options: .repeat,
                           animations: {
                            self.spinnerView.transform = self.spinnerView.transform.rotated(by: .pi)
            })
        }
        return self
    }
    
    private static func dotLayer() -> CAShapeLayer {
        return CAShapeLayer()
            .configure {
                $0.lineWidth = 4
                $0.fillColor = nil
                $0.strokeColor = Theme.activeTheme._get(.colorAccent)?.backgroundColor?.cgColor
                $0.path = UIBezierPath(arcCenter: .zero, radius: 2, startAngle: 0, endAngle: .pi * 2, clockwise: true).cgPath
        }
    }
}
