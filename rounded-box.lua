-- roundBox will produce an axis aligned box with width(x), depth(y) and height(z).
-- the result will be placed with the origin at the centre of the figure.
-- the edges of the box will be rounded to a radius of 5 units by default.
-- also, by default, all edges and corners will be rounded.
--
-- the default edge radius can be changed from the options.
-- the faces can be selectively flattened by setting of options.
-- please review the defaults hash for keys and values.
--
-- Note, this function makes use of the mergeTables method supplied in the 
-- utilities file.
--
function roundedBox(width, depth, height, options)
  options = options or {}
  
  defaults = {
    edge_radius=5,
    flat_top=false, 
    flat_bottom=false,
    flat_front=false,
    flat_back=false,
    flat_left=false,
    flat_right=false
  }

  settings = mergeTables(defaults, options)

  edge_radius = settings.edge_radius

  -- build frame
  frame_height = height - 2 * edge_radius
  frame_width = width - 2 * edge_radius
  frame_depth = depth - 2 * edge_radius
  height_offset = 0
  width_offset = 0
  depth_offset = 0

  if settings.flat_top then
    frame_height = frame_height + edge_radius
    height_offset = height_offset + edge_radius / 2
  end
  if settings.flat_bottom then
    frame_height = frame_height + edge_radius
    height_offset = height_offset - edge_radius / 2
  end
  if settings.flat_right then
    frame_width = frame_width + edge_radius
    width_offset = width_offset + edge_radius / 2
  end
  if settings.flat_left then
    frame_width = frame_width + edge_radius
    width_offset = width_offset - edge_radius / 2
  end
  if settings.flat_back then
    frame_depth = frame_depth + edge_radius
    depth_offset = depth_offset + edge_radius / 2
  end
  if settings.flat_front then
    frame_depth = frame_depth + edge_radius
    depth_offset = depth_offset - edge_radius / 2
  end

  x_frame = translate(0, depth_offset, height_offset) * scale(width, frame_depth, frame_height) * ccube(1)
  y_frame = translate(width_offset, 0, height_offset) * scale(frame_width, depth, frame_height) * ccube(1)
  z_frame = translate(width_offset, depth_offset, 0)  * scale(frame_width, frame_depth, height) * ccube(1)
  frame = {x_frame, y_frame, z_frame}

  -- build corners
  corners = {}
  
  x_step = width / 2 - edge_radius
  y_step = depth / 2 - edge_radius
  z_step = height / 2 - edge_radius
  for x = -1, 1, 2 do
    for y = -1, 1, 2 do
      for z = -1, 1, 2 do
        table.insert(corners, translate(x_step * x, y_step * y, z_step * z) * sphere(edge_radius))
      end
    end
  end

  -- build_edges
  edges = {}

  -- x edges
  edge_length = width - 2 * edge_radius
  edge_offset = 0
  if settings.flat_right then
    edge_length = edge_length + edge_radius
    edge_offset = edge_offset + edge_radius / 2
  end
  if settings.flat_left then 
    edge_length = edge_length + edge_radius
    edge_offset = edge_offset - edge_radius / 2
  end
  table.insert(edges, translate(edge_offset, edge_radius - depth / 2, edge_radius - height / 2) * rotate(0, 90, 0) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(edge_offset, depth / 2 - edge_radius, edge_radius - height / 2) * rotate(0, 90, 0) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(edge_offset, edge_radius - depth / 2, height / 2 - edge_radius) * rotate(0, 90, 0) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(edge_offset, depth / 2 - edge_radius, height / 2 - edge_radius) * rotate(0, 90, 0) * ccylinder(edge_radius, edge_length))

  -- y edges
  edge_length = depth - 2 * edge_radius
  edge_offset = 0
  if settings.flat_back then
    edge_length = edge_length + edge_radius
    edge_offset = edge_offset + edge_radius / 2
  end
  if settings.flat_front then 
    edge_length = edge_length + edge_radius
    edge_offset = edge_offset - edge_radius / 2
  end
  table.insert(edges, translate(edge_radius - width / 2, edge_offset, edge_radius - height / 2) * rotate(90, 0, 0) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(width / 2 - edge_radius, edge_offset, edge_radius - height / 2) * rotate(90, 0, 0) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(edge_radius - width / 2, edge_offset, height / 2 - edge_radius) * rotate(90, 0, 0) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(width / 2 - edge_radius, edge_offset, height / 2 - edge_radius) * rotate(90, 0, 0) * ccylinder(edge_radius, edge_length))

  -- z edges
  edge_length = height - 2 * edge_radius
  edge_offset = 0
  if settings.flat_top then
    edge_length = edge_length + edge_radius
    edge_offset = edge_offset + edge_radius / 2
  end
  if settings.flat_bottom then 
    edge_length = edge_length + edge_radius
    edge_offset = edge_offset - edge_radius / 2
  end
  table.insert(edges, translate(edge_radius - width / 2, edge_radius - depth / 2, edge_offset) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(width / 2 - edge_radius, edge_radius - depth / 2, edge_offset) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(edge_radius - width / 2, depth / 2 - edge_radius, edge_offset) * ccylinder(edge_radius, edge_length))
  table.insert(edges, translate(width / 2 - edge_radius, depth / 2 - edge_radius, edge_offset) * ccylinder(edge_radius, edge_length))

  return union({union(edges), union(frame), union(corners)})
end