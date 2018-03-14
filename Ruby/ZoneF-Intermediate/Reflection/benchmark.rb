require 'benchmark'

include Benchmark

test = 'Could we consider that we are living in a world shaped by belief'
mth = test.method(:length)
n = 100000

bm(12) do |x|
	x.report('direct call') {n.times {test.length}}
	x.report('call') {n.times {mth.call()}}
	x.report('send') {n.times {test.send(:length)}}
	x.report('eval') {n.times {eval "test.length"}}
end
