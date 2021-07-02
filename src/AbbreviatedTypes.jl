module AbbreviatedTypes

# @reexport makes all exported symbols of the exported packages available in module using
# AbbreviatedTypes
using Reexport
@reexport using StaticArrays

export AbsFloat, Float, ComplexF
export Tuple2, Tuple3, Tuple23
export AbsVec, AbsMat, AbsArr
export VecBool, VecInt, VecFloat, VecComplexF
export AbsVecBool, AbsVecInt, AbsVecFloat, AbsVecComplexF
export AbsVecInteger, AbsVecReal, AbsVecComplex, AbsVecNumber
export MatBool, MatInt, MatFloat, MatComplexF
export AbsMatBool, AbsMatInt, AbsMatFloat, AbsMatComplexF
export AbsMatInteger, AbsMatReal, AbsMatComplex, AbsMatNumber
export ArrBool, ArrInt, ArrFloat, ArrComplexF
export AbsArrBool, AbsArrInt, AbsArrFloat, AbsArrComplexF
export AbsArrInteger, AbsArrReal, AbsArrComplex, AbsArrNumber
export SVec, S²Mat
export SBool, SInt, SFloat, SComplexF
export SInteger, SReal, SComplex, SNumber
export S²Bool, S²Int, S²Float, S²ComplexF
export S²Integer, S²Real, S²Complex, S²Number

## Type aliases
# Below, use Int instead of Int64 for compatibility with 32-bit systems (e.g., x86 in appveyor.yml).
const AbsFloat = AbstractFloat
const Float = typeof(0.0)  # use Float = Float128 for quadruple precision in the future
const ComplexF = Complex{Float}

const Tuple2 = NTuple{2}
const Tuple3 = NTuple{3}
const Tuple23{T} = Tuple2{Tuple3{T}}

const AbsVec = AbstractVector
const AbsMat = AbstractMatrix
const AbsArr = AbstractArray

## Vectors
# Concrete containers with concrete elements
const VecBool = Vector{Bool}
const VecInt = Vector{Int}
const VecFloat = Vector{Float}
const VecComplexF = Vector{ComplexF}

# Abstract containers with concrete elements
const AbsVecBool = AbsVec{Bool}
const AbsVecInt = AbsVec{Int}
const AbsVecFloat = AbsVec{Float}
const AbsVecComplexF = AbsVec{ComplexF}

# Abstract containers with abstract elements
const AbsVecInteger = AbsVec{<:Integer}
const AbsVecReal = AbsVec{<:Real}
const AbsVecComplex = AbsVec{<:Complex}
const AbsVecNumber = AbsVec{<:Number}

## Matrices
# Concrete containers with concrete elements
const MatBool = Matrix{Bool}
const MatInt = Matrix{Int}
const MatFloat = Matrix{Float}
const MatComplexF = Matrix{ComplexF}

# Abstract containers with concrete elements
const AbsMatBool = AbsMat{Bool}
const AbsMatInt = AbsMat{Int}
const AbsMatFloat = AbsMat{Float}
const AbsMatComplexF = AbsMat{ComplexF}

# Abstract containers with abstract elements
const AbsMatInteger = AbsMat{<:Integer}
const AbsMatReal = AbsMat{<:Real}
const AbsMatComplex = AbsMat{<:Complex}
const AbsMatNumber = AbsMat{<:Number}

## Arrays
# Below, without {N} in alias, for example `where {T<:AbsArrNumber{3}}` is not equivalent to
# `where {T<:AbstractArray{<:Number,3}}`.

# Concrete containers with concrete elements
const ArrBool{N} = Array{Bool,N}
const ArrInt{N} = Array{Int,N}
const ArrFloat{N} = Array{Float,N}
const ArrComplexF{N} = Array{ComplexF,N}

# Abstract containers with concrete elements
const AbsArrBool{N} = AbsArr{Bool,N}
const AbsArrInt{N} = AbsArr{Int,N}
const AbsArrFloat{N} = AbsArr{Float,N}
const AbsArrComplexF{N} = AbsArr{ComplexF,N}

# Abstract containers with abstract elements
const AbsArrInteger{N} = AbsArr{<:Integer,N}
const AbsArrReal{N} = AbsArr{<:Real,N}
const AbsArrComplex{N} = AbsArr{<:Complex,N}
const AbsArrNumber{N} = AbsArr{<:Number,N}

## StaticArrays
const SVec{K,T} = SVector{K,T}
const S²Mat{K,K²,T} = SMatrix{K,K,T,K²}  # square static matrix

# Vectors with concrete elements
const SBool{K} = SVec{K,Bool}
const SInt{K} = SVec{K,Int}
const SFloat{K} = SVec{K,Float}
const SComplexF{K} = SVec{K,ComplexF}

# Vectors with abstract elements
const SInteger{K} = SVec{K,<:Integer}
const SReal{K} = SVec{K,<:Real}
const SComplex{K} = SVec{K,<:Complex}
const SNumber{K} = SVec{K,<:Number}

# Square matrices with concrete elements
const S²Bool{K,K²} = S²Mat{K,K²,Bool}
const S²Int{K,K²} = S²Mat{K,K²,Int}
const S²Float{K,K²} = S²Mat{K,K²,Float}
const S²ComplexF{K,K²} = S²Mat{K,K²,ComplexF}

# Square matrices with abstract elements
const S²Integer{K,K²} = S²Mat{K,K²,<:Integer}
const S²Real{K,K²} = S²Mat{K,K²,<:Real}
const S²Complex{K,K²} = S²Mat{K,K²,<:Complex}
const S²Number{K,K²} = S²Mat{K,K²,<:Number}

end
