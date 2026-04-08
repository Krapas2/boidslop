class_name NodeUtils

static func find_node_in(node: Node, type: Variant) -> Variant:
	if is_instance_of(node, type):
		return node
	for child: Node in node.get_children():
		if is_instance_of(child, type):
			return child
	return null

static func find_nodes_in(node: Node, type: Variant) -> Array[Variant]:
	var result: Array[Variant] = []
	for child: Node in node.get_children():
		if is_instance_of(child, type):
			result.append(child)
	return result
