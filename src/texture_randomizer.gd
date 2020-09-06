class_name TextureRandomizer

static func apply_random_texture(mesh: MeshInstance, textures: Array):
	var rnd = GameManager.get_rng().randi_range(0, textures.size() - 1)
	mesh.get_surface_material(0).albedo_texture = textures[rnd]
