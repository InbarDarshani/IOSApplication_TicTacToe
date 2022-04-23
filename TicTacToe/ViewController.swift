//
//  ViewController.swift
//  TicTacToe
//
//  Created by Inbar on 22/04/2022.
//

import UIKit

class ViewController: UIViewController {
	
	var turn = 1 //X = 1 O = 2
	var turnsLeft = 9
	var boardState = [0,0,0,0,0,0,0,0,0]
	let winningCells = [[0,1,2],[3,4,5],[6,7,8],
						[0,3,6],[1,4,7], [2,5,8],
						[0,4,8],[2,4,6]]
	let winningImagesTags = [123, 456, 789, 147, 258, 369, 159, 357]
	var winImage: UIImageView? = nil
	
	@IBOutlet weak var labelImage: UIImageView!
	@IBOutlet weak var startOverButton: UIButton!
	
	@IBAction func action(_ sender: AnyObject) {
		if (boardState[sender.tag - 1] != 0){ return }
		
		boardState[sender.tag - 1] = turn
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
	
	func checkWin(){
		var foundWin = false
		var winIndex = -1
		var winner = 0
		
		for win in winningCells{
			if boardState[win[0]] != 0 &&
				boardState[win[0]] == boardState[win[1]] &&
				boardState[win[1]] == boardState[win[2]]{
				
				foundWin = true
				winIndex = winningCells.firstIndex(of: win)!
				winner = boardState[win[0]]
				applyWin(winIndex, winner)
			}
		}
		
		if foundWin == false && turnsLeft == 0{
			applyWin(winIndex, winner)
		}
	}
	
	func applyWin(_ winIndex: Int, _ winner: Int){
		startOverButton.isHidden = false
		
		if(winner == 0){
			labelImage.image = UIImage(named: "tie.png")
			return
		}
				
		switch winner {
		case 1:
			labelImage.image = UIImage(named: "x_wins.png")
		case 2:
			labelImage.image = UIImage(named: "o_wins.png")
		default:
			return
		}
		
		winImage = (view.viewWithTag(winningImagesTags[winIndex]) as! UIImageView)
		winImage!.isHidden = false
	}
	
	@IBAction func reset(_ sender: UIButton) {
		turn = 1 //X
		boardState = [0,0,0,0,0,0,0,0,0]
		turnsLeft = 9
		startOverButton.isHidden = true
		labelImage.image = UIImage(named: "x_turn.png")
		winImage?.isHidden = true
		
		for i in 1...9{
			let cellButton = view.viewWithTag(i) as! UIButton
			cellButton.setImage(UIImage(named: "empty.png"), for: UIControl.State())
			cellButton.isEnabled = true
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}

