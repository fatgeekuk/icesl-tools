function mergeTables(t1, t2)
  result = {}
  for k, v in pairs(t1) do
    result[k] = v
  end

  for k, v in pairs(t2) do
    result[k] = v
  end

  return result
end