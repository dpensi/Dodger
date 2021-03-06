class_name Utils


func vector2_average(vectors):
	var sum_x = 0
	var sum_y = 0
	for v in vectors:
		sum_x += v.x
		sum_y += v.y 
	return Vector2(sum_x/vectors.size(), 
			sum_y / vectors.size())	

func middle_point(vec1, vec2):
	return vector2_average([vec1, vec2])