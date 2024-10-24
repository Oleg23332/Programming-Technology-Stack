def NSD(a,b)
  if b == 0
    return a
  end
  return NSD(b,a % b)
end

puts(NSD(30,15))