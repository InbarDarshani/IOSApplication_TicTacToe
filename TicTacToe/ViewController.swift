//
//  ViewController.swift
//  TicTacToe
//
//  Created by Inbar on 22/04/2022.
//

import UIKit

class ViewController: UIViewController {
	
	var turn = 1 //X
	var turnsLeft = 9
	var boardState = [0,0,0,0,0,0,0,0,0]
	let winningCells = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		
	@IBOutlet weak var labelImage: UIImageView!
	@IBOutlet weak var startOverButton: UIButton!
	
	@IBAction func action(_ sender: AnyObject) {
		
		if (boardState[sender.tag] != 0){
			return
		}
		
		boardState[sender.tag] = turn
		turnsLeft -= 1
		
		if (turn == 1){
			sender.setImage(UIImage(named: "x_sign.png"), for: UIControl.State())
			labelImage.image = UIImage(named: "o_turn.png")
			turn = 2
		}else{
			sender.setImage(UIImage(named: "o_sign.png"), for: UIControl.State())
			labelImage.image = UIImage(named: "x_turn.png")
			turn = 1
		}
		
		checkWin()
	}
	
	@IBAction func reset(_ sender: UIButton) {
		turn = 1 //X
		boardState = [0,0,0,0,0,0,0,0,0]
		turnsLeft = 9
		startOverButton.isHidden = true
		labelImage.image = UIImage(named: "x_turn.png")
		
		for i in 0...8{
			let cell = view.viewWithTag(i) as! UIButton
			cell.setImage(UIImage(named: "empty.png"), for: UIControl.State())
			cell.isEnabled = true
		}
	}
	
	
	func checkWin(){
		
		var foundWin = false
		
		for win in winningCells{
			if boardState[win[0]] != 0 &&
				boardState[win[0]] == boardState[win[1]] &&
				boardState[win[1]] == boardState[win[2]]{
				
				if boardState[win[0]] == 1{
					labelImage.image = UIImage(named: "x_wins.png")
				}else{
					labelImage.image = UIImage(named: "o_wins.png")
				}
								
				foundWin = true
				startOverButton.isHidden = false
			}
		}
		
		if foundWin == false && turnsLeft == 0{
			labelImage.image = UIImage(named: "tie.png")
			startOverButton.isHidden = false
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}

