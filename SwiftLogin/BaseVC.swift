//
//  BaseVC.swift
//  Navermap_Module
//
//  Created by AutoCrypt on 2020/05/14.
//  Copyright © 2020 AutoCrypt. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class BaseVC: UIViewController {
    
    //SafeArea
    lazy var safeArea: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(safeAreaDidTap))
        v.addGestureRecognizer(panGesture)
        return v
    }()
    
    let API_TIMEOUT = 5 //second
    let UI_DEBOUNCE_TIME = 500 //ms
    let TRANSITION_DURATION = 0.35
    let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
    
    private var keyboardIsShow: Bool = false
    private var moveViewWhenKeyabordShow: Bool = true
    
    // 뷰가 사라질 때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    // 뷰 생성 후 나타내기 전
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // 뷰 생성 직 후
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        layoutSetupView()
        
    }
    
    private func layoutSetupView() {
        view.addSubview(safeArea)
        
        safeArea.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // 키보드 액션에 따른 알림
    func addKeyboardObserver(withView: Bool = true) {
        moveViewWhenKeyabordShow = withView
        keyboardIsShow = false
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIApplication.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIApplication.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(notification:)),
                                               name: UIApplication.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide(notification:)),
                                               name: UIApplication.keyboardDidHideNotification,
                                               object: nil)
    }
    // push <-> pop
    func pushViewController(_ vc: UIViewController, animated: Bool = true) {
        view.endEditing(true)
        navigationController?.pushViewController(vc, animated: animated)
    }
    // push <-> pop
    func popViewController(animated: Bool = true) {
        view.endEditing(true)
        navigationController?.popViewController(animated: animated)
    }
    
    func popViewController(before idx: Int, animated: Bool = true) {
        let controllerCount = navigationController?.viewControllers.count ?? 0
        let targetIdx = controllerCount - idx
        
        if targetIdx >= 0 {
            guard let controller = navigationController?.viewControllers[targetIdx] else { return }
            navigationController?.popToViewController(controller, animated: animated)
        }
    }
    // root view 까지 내려가기
    func popToRootViewController(animated: Bool = true) {
        view.endEditing(true)
        navigationController?.popToRootViewController(animated: animated)
    }
    
    // present <-> dismiss  (모달 뷰 스타일)
    func presentCrossDissolve(_ vc: UIViewController) {
        let naviVC = UINavigationController(rootViewController: vc)
        naviVC.modalTransitionStyle = .crossDissolve
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true, completion: nil)
    }
    // present <-> dismiss  (모달 뷰 스타일)
    func dismissCorssDissolve() {
        dismiss(animated: true, completion: nil)
    }
    
    // 사이드 메뉴 이펙트
    func presentLeftToRight(_ vc: UIViewController) {
        let transition = CATransition()
        transition.duration = TRANSITION_DURATION
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        
        let naviVC = UINavigationController(rootViewController: vc)
        naviVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async { [unowned self] in
            self.view.window!.layer.add(transition, forKey: kCATransition)
            self.present(naviVC, animated: false)
        }
    }
    
    // 사이드 메뉴 이펙트
    public func dismissRightToLeft(completion: (()->())? = nil) {
        let transition = CATransition()
        transition.duration = TRANSITION_DURATION/2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        
        DispatchQueue.main.async { [unowned self] in
            if let window = self.view.window {
                window.layer.add(transition, forKey: kCATransition)
                self.dismiss(animated: false) {
                    completion?()
                }
            }
        }
    }
    
    // 앨럿 띄우기
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .destructive,
                                         handler: nil)
        let confirmAction = UIAlertAction(title: "확인",
                                          style: .default,
                                          handler: nil)
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(confirmAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    // 토스트 띄우기
//    func showToast(title: String? = nil, message: String, duration: Double = 1.5, position: ToastPosition = .center, _ completion: ((_ didTap: Bool) -> Void)? = nil) {
//        view.makeToast(message,
//                       duration: duration,
//                       position: position,
//                       title: title,
//                       image: nil,
//                       style: .init(),
//                       completion: { didTap in
//                        if let c = completion {
//                            c(didTap)
//                        }})
//    }
    
    // 키보드 올라올떄
    @objc
    func keyboardWillShow(notification: Notification) {
        if !keyboardIsShow {
            let i = notification.userInfo!
            let k = (i[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
            let s: TimeInterval = (i[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            safeArea.snp.updateConstraints { [unowned self] in
                if self.moveViewWhenKeyabordShow {
                    $0.top.equalTo(view.safeArea.top).inset(-112)
                }
                $0.bottom.equalTo(view.safeArea.bottom).inset(k - view.safeAreaInsets.bottom)
            }
            
            UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
        }
    }
    
    // 키보드 내려갈떄
    @objc
    func keyboardWillHide(notification: Notification) {
        if keyboardIsShow {
            let info = notification.userInfo!
            let s: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            safeArea.snp.updateConstraints {
                $0.top.equalTo(view.safeArea.top)
                $0.bottom.equalTo(view.safeArea.bottom)
            }
            
            UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
        }
    }
    
    @objc
    func keyboardDidShow(notification: Notification) {
        keyboardIsShow = true
    }
    
    @objc
    func keyboardDidHide(notification: Notification) {
        keyboardIsShow = false
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    // 선택한 뷰를 최상단 위로 올려서 맨위에 보이게 하기
    func safeAreaBringToFront() {
        view.bringSubviewToFront(safeArea)
    }
    
    // 레이아웃 가이드를 탭 했을때 텍스트 필드 커서에서 벗어나기
    @objc
    private func safeAreaDidTap() {
        view.endEditing(true)
    }
    
}

extension BaseVC : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    // 화면바닥 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        return self.safeAreaLayoutGuide.snp
    }
}




