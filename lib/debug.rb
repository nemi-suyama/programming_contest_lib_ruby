def puts_val(h)
  s=''
  h.each{|k,v| s<<"#{k}:#{v}, "}
  puts s
end