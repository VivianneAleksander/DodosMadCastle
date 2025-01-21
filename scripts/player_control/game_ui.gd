extends MeshAnimationMiddleman

func hurt():
	$AnimationPlayer2.play("hurt")

func update_health(n : int):
	$HealthRects.update_rects(n)
	
func update_bubbles(n: int):
	$BubbleRects.update_rects(n)
