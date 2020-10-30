//
//  ViewController.swift
//  RxSwiftEx02
//
//  Created by danny on 2020/10/30.
//

import UIKit
import RxSwift

class ViewController: UITableViewController {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func exJust1(_ sender: Any) {
        Observable.just("Hello World")
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exJust2(_ sender: Any) {
        Observable.just(["Hello", "World"])
            .subscribe(onNext: { arr in
                print(arr)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exFrom1(_ sender: Any) {
        Observable.from(["RxSwift", "In", "4", "Hours"])
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exMap1(_ sender: Any) {
        Observable.just("Hello")
            .map {
                str in "\(str) RxSwift"
            }
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exMap2(_ sender: Any) {
        Observable.from(["with", "danny"])
            .map { $0.count}
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func exFilter(_ sender: Any) {
        Observable.from([1,2,3,4,5,6,7,8,9,10])
            .filter { $0 % 2 == 0 }
            .subscribe(onNext: { n in
                print(n)
            })
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func exMap3(_ sender: Any) {
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/")}
            .map { "https://picsum.photos/\($0)/?random" }
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .map { $0! }
            .map { try Data(contentsOf: $0)}
            .map { UIImage(data: $0)}
            .subscribe(onNext: { image in
                self.imageView.image = image
            })
            .disposed(by: disposeBag)
            
    }
    
}

