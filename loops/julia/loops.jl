module Loops

export loops

function loops(u::Int)::Int
    a = zeros(Int, 10^4)          # Allocate an array of 10,000 zeros
    r = rand(1:10^4)              # Choose a random index between 1 and 10,000
    @inbounds for i in 1:10^4     # Outer loop over array indices
        @inbounds for j in 1:10^4 # Inner loop: 10,000 iterations per outer loop iteration
            a[i] += j % u         # Simple sum
        end
        a[i] += r                 # Add a random value to each element in array
    end
    return a[r]                   # Return the element at the random index
end

end  # module Loops
