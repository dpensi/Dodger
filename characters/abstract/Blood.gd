extends Particles2D

func _ready():
	var lifespan = get_tree().create_timer(lifetime * 2)
	lifespan.connect("timeout", self, "queue_free")

