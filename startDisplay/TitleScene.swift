//
//  TitleScene.swift
//  startDisplay
//
//  Created by Arai Koyo on 2018/04/10.
//  Copyright © 2018年 Arai Koyo. All rights reserved.
//
import SpriteKit

class TitleScene : SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.clear    // これ落とし穴！やらないとモヤがかかったみたいになる
        self.scaleMode = .resizeFill    // これを入れないとiPadで表示した時にパーティクルが小さく表示されてしまう
        emitParticle()
    }
    
    func emitParticle() {
        
        // パーティクルファイルのパスを指定
        guard let testParticlePath = Bundle.main.path(forResource: "MyParticle9", ofType: "sks") else {
            return
        }
        
        // パーティクルを作って載せる
        let testParticle = NSKeyedUnarchiver.unarchiveObject(withFile: testParticlePath) as! SKEmitterNode
        testParticle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)        
        print(testParticle.position)
        self.addChild(testParticle)
    }
}
