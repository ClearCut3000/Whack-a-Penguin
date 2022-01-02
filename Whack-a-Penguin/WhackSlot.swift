//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Николай Никитин on 02.01.2022.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
  var charNode: SKSpriteNode!

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
}
