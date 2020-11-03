//
//  ViewController.swift
//  RxSwiftEx03
//
//  Created by danny on 2020/11/02.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idValidView: UIView!
    @IBOutlet weak var pwValidView: UIView!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.setBackgroundColor(.blue, for: .normal)
        loginButton.setBackgroundColor(.gray, for: .disabled)
        
        bindUI()
    }

    private func bindUI() {
        idField.rx.text
            .orEmpty
            .map(checkEmailValid)
            .subscribe(onNext: { b in
                self.idValidView.isHidden = b
            })
        .disposed(by: disposeBag)
        
        pwField.rx.text
            .orEmpty
            .map(checkPasswordVaile)
            .subscribe(onNext: { b in
                self.pwValidView.isHidden = b
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            idField.rx.text.orEmpty.map(checkEmailValid),
            pwField.rx.text.orEmpty.map(checkPasswordVaile),
            resultSelector: { s1, s2 in s1 && s2 }
        )
        .subscribe(onNext: { b in
            self.loginButton.isEnabled = b
        })
        .disposed(by: disposeBag)
        
        
    }
    
    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func checkPasswordVaile(_ password: String) -> Bool {
        return password.count > 5
    }
}

