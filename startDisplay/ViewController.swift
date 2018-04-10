//
//  ViewController.swift
//  startDisplay
//
//  Created by Arai Koyo on 2018/04/09.
//  Copyright © 2018年 Arai Koyo. All rights reserved.
//

import UIKit
import SpriteKit
import LTMorphingLabel
import PagingMenuController

class ViewController: UIViewController {
    // スクリーン画面のサイズを取得
    let scWid: CGFloat = UIScreen.main.bounds.width     //画面の幅
    let scHei: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    @IBOutlet weak var skview: SKView!
    
    @IBOutlet var imagee: UIImageView!
    
    @IBOutlet var tests: [UIImageView]!
    
    
    //@IBOutlet weak var testms: LTMorphingLabel!
    @IBOutlet weak var testm2: LTMorphingLabel!
    
    @IBOutlet weak var testm3: LTMorphingLabel!
    
    
    @IBOutlet weak var testm: LTMorphingLabel!
    //表示制御用タイマー
    private var timer: Timer?
    //String配列のindex用
    private var index: Int = 0
    //表示するString配列
    private let textList = ["tech", "てっく部ずかん", "2018年新卒"]
    
    var animationCount = 0
    func selectAnimation(){
        var index = (Int)(arc4random_uniform(5))
        var titles: [LTMorphingEffect] = [ .anvil, .evaporate, .fall, .pixelate, .scale ]

        while(index==animationCount){
            index = (Int)(arc4random_uniform(5))
        }
        testm.morphingEffect = titles[index]
        animationCount = index
    }

    override func viewDidAppear(_ animated: Bool) {
        //候補:anvil,evaporate,fall,pixelate,scale
        
        var titles: [LTMorphingEffect] = [ .anvil, .evaporate, .fall, .pixelate, .scale ]
        let index = (Int)(arc4random_uniform(5))
        
        testm.morphingEffect = titles[index]
        super.viewDidAppear(animated)
        //タイマーの追加
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(update(timer:)), userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func update(timer: Timer) {
        //ここでtextの更新
        testm.text = textList[index]

        //Testtes()
        index += 1
        if index >= textList.count {
            index = 0
        }
        selectAnimation()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {

//        let TestView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: scWid, height: scHei))
//        let bgColor = UIColor.clear
//        TestView.backgroundColor = bgColor
//        self.view.addSubview(TestView)
        //self.skview.isUserInteractionEnabled = false
        self.view.bringSubview(toFront: testm)//前に出す

        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skview.allowsTransparency = true
        let scene = TitleScene(size: skview.bounds.size)
        //skview.presentScene(scene)
        // Do any additional setup after loading the view, typically from a nib.
        print("did")
        
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)

        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
        pagingMenuController.view.frame.origin.y += 150
        pagingMenuController.view.frame.size.height -= 200
        
        didAnimation()

        //Recognizer定義
        let tap_LEFT = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction_LEFT))
        let tap_CENTER = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction_CENTER))
        let tap_RIGHT = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction_RIGHT))
        let taps = [tap_LEFT,tap_CENTER,tap_RIGHT]
        for i in 0...(tests.count-1) {
            print(i)
            tests[i].image = UIImage(named:"test2")!
            tests[i].isUserInteractionEnabled = true
            tests[i].addGestureRecognizer(taps[i])
        }
        //moveSelfyImage()
    }
    // 画像がタップされたら呼ばれる
    @objc func tapFunction_LEFT(sender:UITapGestureRecognizer) {
        
        print("tap working0")
    }
    @objc func tapFunction_CENTER(sender:UITapGestureRecognizer) {
        print("tap working1")
    }
    // 画像がタップされたら呼ばれる
    @objc func tapFunction_RIGHT(sender:UITapGestureRecognizer) {
        print("tap working2")
    }
    
    @IBAction func RightSwipe(_ sender: Any) {
        moveSelfyImage()

    }
    
    @IBAction func LightSwipe(_ sender: Any) {
        moveSelfyImage()

    }
    @IBAction func butonTest(_ sender: Any) {
        moveSelfyImage()

    }
    var count = 0
    func moveSelfyImage(){
        let width = tests[0].frame.size.width
        let height = tests[0].frame.size.height
        let center = self.tests[0].center
        let beforePos = [tests[0].layer.position,tests[1].layer.position,tests[2].layer.position]
        count+=1;
        UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveLinear], animations: {
            
            self.imagee.center = center
            for i in 0...(self.tests.count-1) {
                self.tests[i].layer.position = i==0 ? beforePos[self.tests.count-1] : beforePos[i-1]
            }
            self.imagee.alpha = 0.0
        }, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            // 0.5秒後に実行したい処理
//            self.moveSelfyImage()
//        }
    }
    
    
    
    
    
    /*-------------------------------------------------*/
    
    
    func didAnimation(){
        let img7 = UIImage(named:"test2")!
        imagee.image = img7
        
        self.imagee.alpha = 1.0
        
        let width = imagee.frame.size.width
        let height = imagee.frame.size.height
        let center = self.imagee.center
        let smallsize:CGFloat = 0.6
        let bigsize:CGFloat = 1.9;
        
        UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseIn], animations: {
            print("hey")
            self.imagee.frame.size.width = width * smallsize
            self.imagee.frame.size.height = height * smallsize
            self.imagee.center = center
            
            
        }, completion: {(finished: Bool) in
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
            //アニメーション２：アニメーション１が終わったら実行される

            print("hoo")

            self.imagee.frame.size.width = width * bigsize
            self.imagee.frame.size.height = height * bigsize
            self.imagee.center = center
            
            self.imagee.alpha = 0.0
        }, completion: nil)
        })
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private struct PagingMenuOptions: PagingMenuControllerCustomizable {
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Test1VC") as! Test1ViewController
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Test2VC") as! Test2ViewController
        
        fileprivate var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
        }
        
        fileprivate var pagingControllers: [UIViewController] {
            return [vc1, vc2]
        }
        
        fileprivate struct MenuOptions: MenuViewCustomizable {
            var displayMode: MenuDisplayMode {
                return .segmentedControl
            }
            var height: CGFloat {
                return 40
            }
            var backgroundColor: UIColor {
                return UIColor.gray
            }
            var selectedBackgroundColor: UIColor {
                return UIColor.gray
            }
            var focusMode: MenuFocusMode {
                return .underline(height: 4, color: UIColor.darkGray, horizontalPadding: 0, verticalPadding: 0)
            }
            var itemsOptions: [MenuItemViewCustomizable] {
                return [MenuItem1(), MenuItem2()]
            }
        }
        
        fileprivate struct MenuItem1: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "First", color: UIColor.lightGray, selectedColor: UIColor.white))
            }
        }
        
        fileprivate struct MenuItem2: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                return .text(title: MenuItemText(text: "Second", color: UIColor.lightGray, selectedColor: UIColor.white))
            }
        }
    }


}

