# AbbreviatedTypes

[![CI](https://github.com/wsshin/AbbreviatedTypes.jl/workflows/CI/badge.svg)](https://github.com/wsshin/AbbreviatedTypes.jl/actions)
[![Codecov](http://codecov.io/github/wsshin/AbbreviatedTypes.jl/coverage.svg?branch=main)](http://codecov.io/github/wsshin/AbbreviatedTypes.jl?branch=main)

**AbbreviatedTypes** defines compact type aliases of frequently used types with long names, e.g., `AbsVecFloat` for `AbstractVector{Float64}`.  The "abbreviated" type names are useful in making function signatures more compact.

## Change since Version 0.3
Before Version 0.3, AbbreviatedTypes defined the type aliases internally and exported them so that they can be used in the package importing AbbreviatedTypes.  Since Version 0.3, AbbreviatedTypes does not define the type aliases internally; instead, it defines the type aliases directly in the packages importing AbbreviatedTypes.  This allows the users to tailor the behavior of AbbreviatedTypes for individual packages importing it.  Specifically, the users can define `Float` as any of the concrete subtypes of `AbstractFloat`, i.e., `Float16`, `Float32`, or `Float64`.  This is useful when you want to use `AbsVecFloat` as an abstract vector of `Float32` in one package (e.g., written for GPU) and of `Float64` in another package.  The different definitions of `Float` in different packages do not conflict with one another because they live in different namespaces.

## Usage
After `using AbbreviatedTypes`, call the macro `@define_types_with()` with the concrete subtype of `AbstractFloat`.  For example,
```julia
module MyPkg

using AbbreviatedTypes; @define_types_with(Float64)  # Float == Float64

function myfun(x::AbsVecFloat)  # AbsVecFloat == AbstractVector{Float64}
    ...
end
```
The technique of using a macro to inject definitions in a calling module is discussed in [this discourse thread](https://discourse.julialang.org/t/get-the-name-of-the-invoking-module/22685).

For the definitions of available type aliases, see the code [here](https://github.com/wsshin/AbbreviatedTypes.jl/blob/main/src/AbbreviatedTypes.jl#L29-L159).  The usage of the type aliases should be trivial, but I would like to note the special usage of the aliases of [`StaticArray`](https://github.com/JuliaArrays/StaticArrays.jl) types as constructors.  For example, `SInt{K}` is an alias of `SVector{K,Int}`, but `SInt` can be also used as a constructor without specifying the length `K`:
```julia
x1 = SInt{3}(1, 2, 3)  # [1, 2, 3]
x2 = SInt(1, 2, 3)  # [1, 2, 3]
@assert x1 == x2
```
Similar type aliases `SBool`, `SFloat`, and `SComplexF` are defined.  When used as constructors, these automatically convert the arguments to the corresponding element type:
```julia
SBool(1, 0)  # [true, false]
SInt(1.0, 2.0, 3.0)  # [1, 2, 3]
SFloat(1, 2, 3)  # [1.0, 2.0, 3.0]
SComplexF(1, 2, 3)  # [1.0 + 0.0im, 2.0 + 0.0im, 3.0 + 0.0im]
```

## Absolute and relative error tolerances for floating point arithmetic
In double-precision floating point arithmetic, `eps(Float64)` and `Base,rtoldefault(Float64)` are commonly used as absolute and relative error tolerances.  In addition to type aliases, AbbreviatedTypes defines `τₐ₀` and `τᵣ₀` as `eps(Float)` and `Base.rtoldefault(Float)`, so that they can be used as the absolute and relative error tolerances for the user-defined `Float` type through `@define_types_with()`.
