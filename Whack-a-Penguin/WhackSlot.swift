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
  //Configurates whack hole with penguin under it and with SKCropNode.maskNode makes it invisible
  func configure(at position: CGPoint) {
    self.position = position
    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)
    let cropNode = SKCropNode()
    cropNode.position = CGPoint(x: 0, y: 15)
    cropNode.zPosition = 1
    cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
    charNode = SKSpriteNode(imageNamed: "penguinGood")
    charNode.position = CGPoint(x: 0, y: -90)
    charNode.name = "character"
    cropNode.addChild(charNode)
    addChild(cropNode)
  }

  //Shows a random penguin
  func show(hideTime: Double){
    if isVisible { return }
    charNode.xScale = 1
    charNode.yScale = 1
    if let smokeParticle = SKEmitterNode(fileNamed: "MudLike") {
      smokeParticle.position = CGPoint(x: charNode.position.x, y: charNode.position.y + 80)
      charNode.addChild(smokeParticle)
    }
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

  //Hides random shown penguin
  func hide(){
    if !isVisible { return }
    if let smokeParticle = SKEmitterNode(fileNamed: "MudLike") {
      smokeParticle.position = CGPoint(x: charNode.position.x, y: charNode.position.y + 80)
      charNode.addChild(smokeParticle)
    }
    charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
    isVisible = false
  }

  //Hitting penguin method
  func hit(){
    isHit = true
    let delay = SKAction.wait(forDuration: 0.25)
    let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
    let notVisible = SKAction.run{ [weak self] in self?.isVisible = false }
    if let smokeParticle = SKEmitterNode(fileNamed: "SmokeParticle") {
      smokeParticle.position = charNode.position
      charNode.addChild(smokeParticle)
    }
    let sequence = SKAction.sequence([delay, hide, notVisible])
    charNode.run(sequence)
  }
}
