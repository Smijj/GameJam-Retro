@tool
extends EditorPlugin

var AUTOLOAD_NAME: String = "MenuManager"

const MENUS_RESOURCE_PATH: String = "res://addons/menumanager/MenusResource.tres"
var _BtnOpenMenusResource: Button
var Menus: MenusResource = null
func _OpenMenusResource() -> void:
	if !Menus: 
		Menus = load(MENUS_RESOURCE_PATH);
		
		# If there the MenusResource resource doesnt exist, create a new one
		if !Menus:
			Menus = MenusResource.new()
			ResourceSaver.save(Menus, MENUS_RESOURCE_PATH)
	if Menus:
		EditorInterface.edit_resource(Menus)

func _enter_tree() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/menumanager/Scripts/MenuManager.gd")
	
	_BtnOpenMenusResource = Button.new()
	_BtnOpenMenusResource.pressed.connect(_OpenMenusResource)
	_BtnOpenMenusResource.text = "Open Menu Manager"
	add_control_to_container(EditorPlugin.CONTAINER_INSPECTOR_BOTTOM, _BtnOpenMenusResource)
	
func _exit_tree() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
	
	remove_control_from_container(EditorPlugin.CONTAINER_INSPECTOR_BOTTOM, _BtnOpenMenusResource)
	_BtnOpenMenusResource.pressed.disconnect(_OpenMenusResource)
	_BtnOpenMenusResource.queue_free()
