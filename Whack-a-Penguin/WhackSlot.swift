//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Николай Никитин on 02.01.2022.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
  //MARK: - Properties
  var charNode: SKSpriteNode!
  var isVisible = false
  var isHit = false

  //MARK: - Methods
  func configure(at position: CGPoint) {
    self.position = position
    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)
    let cropNode = SKCropNode()
    cropNode.position = CGPoint(x: 0, y: 15)
    cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
    charNode = SKSpriteNode(fileNamed: "penguinGood")
    charNode.position = CGPoint(x: 0, y: -90)
    charNode.name = "character"
    cropNode.addChild(charNode)
    addChild(cropNode)
  }

  func show(hideTime: Double){
    if isVisible { return }
    charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
    isVisible = true
    isHit = false
    if Int.random(in: 0...2) == 0 {
      charNode.texture = SKTexture(imageNamed: "penguinGood")
      charNode.name = "charFriend"
    } else {
      charNode.texture = SKTexture(imageNamed: "penguinEvil")
      charNode.name = "charEnemy"
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
      self?.hide()
    }
  }

  func hide(){
    if !isVisible { return }
    charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
    isVisible = false
  }
}
