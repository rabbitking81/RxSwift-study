//
//  RxSwiftViewController.swift
//  RxSwiftEx01
//
//  Created by danny on 2020/10/30.
//

import UIKit
import RxSwift

class RxSwiftViewController: UIViewController {
    private var counter: Int = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }
    
    @IBAction func onLoadImage(_ sender: Any) {
        self.imageview.image = nil
        
        _ = rxswiftLoadImage(from: LARGER_IMAGE_URL)
            .observeOn(MainScheduler.instance)
            .subscribe( {
                result in
                switch result {
                case let .next(image):
                    self.imageview.image = image
                case let .error(err):
                    print(err.localizedDescription)
                case .completed:
                    break
                }
            })
    }
    
    private func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageUrl) { (image) in
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
    }
}
