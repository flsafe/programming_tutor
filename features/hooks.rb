# Prepcode limits rate at which solution checks or solution 
# grading can occur. Here I make sure we don't hit that limit during testing.
# CHECK_RATE specifies the number of seconds between in solution check.
Before ('@with_vcr') do
  CodeSession.const_set(:CHECK_RATE, 0)
end
