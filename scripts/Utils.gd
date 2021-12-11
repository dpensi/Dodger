extends Object

func vector2_average(vectors):
	var sum_x = 0
	var sum_y = 0
	for v in vectors:
		sum_x += v.x
		sum_y += v.y 
	return Vector2(sum_x / vectors.size(), 
			sum_y / vectors.size())

func middle_point(vec1, vec2):
	return vector2_average([vec1, vec2])

func almost_eq(val1, val2, epsilon=0.1):
	return abs(val1 - val2) < epsilon

func almost_gt(val1, val2, epsilon=0.1):
	return val1 - val2 > epsilon
	
func almost_lt(val1, val2, epsilon=0.1):
	return not almost_gt(val1, val2, epsilon)

func v2_almost_eq(vec1, vec2, epsilon=0.1):
	return vec1.distance_to(vec2) < epsilon

# discards the z axis
func v3_to_v2(vec3):
	return Vector2(vec3.x, vec3.y)

func v2_to_v3(vec2):
	return Vector3(vec2.x, vec2.y, 0)
