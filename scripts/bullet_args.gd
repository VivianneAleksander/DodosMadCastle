extends Resource
class_name BulletArgs

@export var direction : Vector3 = Vector3.FORWARD
@export var velocity : float = 1.0
@export var damage : int = 1
@export_enum("PLAYER", "ENEMY", "NEUTRAL", "NONE") var alliance : int = 0
@export var piercing : int = 0
var origin : Vector3

static func make_copy(args : BulletArgs) -> BulletArgs:
	var new_args : BulletArgs = BulletArgs.new()
	
	new_args.direction = args.direction
	new_args.velocity = args.velocity
	new_args.damage = args.damage
	new_args.alliance = args.alliance
	new_args.piercing = args.piercing
	new_args.origin = args.origin
	
	return new_args
