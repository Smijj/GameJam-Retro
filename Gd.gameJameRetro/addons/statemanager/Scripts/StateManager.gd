extends Node

enum States {
	NONE,
	MENU,
	GAMEPLAY,
}

signal OnGameStateChanged(newState:States)

var _LastGameState:States = States.NONE
var _GameState:States = States.NONE

var LastGameState:States:
	get: return _LastGameState
var GameState:States: 
	get: return _GameState

func SetState(newState:States) -> void:
	# No need to change anything if its already the requested gamestate
	if newState == _GameState: return
	
	_LastGameState = _GameState
	_GameState = newState
	OnGameStateChanged.emit(_GameState)
	print("new gamestate: "+str(_GameState))

func ReturnToPreviousState() -> void:
	SetState(_LastGameState)

func IsGameplay() -> bool:
	if _GameState == States.GAMEPLAY:
		return true
	return false
