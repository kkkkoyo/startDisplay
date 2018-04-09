//
//  ViewController.swift
//  startDisplay
//
//  Created by Arai Koyo on 2018/04/09.
//  Copyright © 2018年 Arai Koyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // スクリーン画面のサイズを取得
    let scWid: CGFloat = UIScreen.main.bounds.width     //画面の幅
    let scHei: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    

    @IBOutlet var imagee: UIImageView!
    
    @IBOutlet var tests: [UIImageView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("did")
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


}

