class_name TextureRandomizer

var _textures = null

func _init(textures: Array):
	_textures = textures


func apply_random_texture(mesh: MeshInstance):
	var rnd = GameManager.get_rng().randi_range(0, _textures.size() - 1)
	mesh.get_surface_material(0).albedo_texture = _textures[rnd]
