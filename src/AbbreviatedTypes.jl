module AbbreviatedTypes

# @reexport makes all exported symbols of the exported packages available in module using
# AbbreviatedTypes
using Reexport
@reexport using StaticArrays

export Float, CFloat
export Tuple2, Tuple3, Tuple23
export AbsVec, AbsMat, AbsArr
export VecBool, VecInt, VecFloat, VecComplex
export AbsVecBool, AbsVecInt, AbsVecFloat, AbsVecComplex, AbsVecInteger, AbsVecReal, AbsVecNumber
export MatFloat, MatComplex, AbsMatFloat, AbsMatComplex, AbsMatReal, AbsMatNumber
export ArrFloat, ArrComplex, AbsArrFloat, AbsArrComplex, AbsArrInteger, AbsArrNumber
export SVec, SBool, SFloat, SInt, SReal, SComplex, SNumber

## Type aliases
# Below, use Int instead of Int64 for compatibility with 32-bit systems (e.g., x86 in appveyor.yml).
const Float = typeof(0.0)  # use Float = Float128 for quadruple precision in the future
const CFloat = Complex{Float}

const Tuple2 = NTuple{2}
const Tuple3 = NTuple{3}
const Tuple23{T} = Tuple2{Tuple3{T}}

const AbsVec = AbstractVector
const AbsMat = AbstractMatrix
const AbsArr = AbstractArray

const VecBool = Vector{Bool}
const VecInt = Vector{Int}
const VecFloat = Vector{Float}
const VecComplex = Vector{CFloat}

const AbsVecBool = AbsVec{Bool}
const AbsVecInt = AbsVec{Int}
const AbsVecFloat = AbsVec{Float}
const AbsVecComplex = AbsVec{CFloat}

const AbsVecInteger = AbsVec{<:Integer}
const AbsVecReal = AbsVec{<:Real}
const AbsVecNumber = AbsVec{<:Number}

const MatFloat = Matrix{Float}
const MatComplex = Matrix{CFloat}

const AbsMatFloat = AbsMat{Float}
const AbsMatComplex = AbsMat{CFloat}

const AbsMatReal = AbsMat{<:Real}
const AbsMatNumber = AbsMat{<:Number}

const ArrFloat{N} = Array{Float,N}
const ArrComplex{N} = Array{CFloat,N}

# Below, without {N}, `where {T<:AbsArrNumber{3}}` is not equivalent to
# `where {T<:AbstractArray{<:Number,3}}`.
const AbsArrFloat{N} = AbsArr{Float,N}
const AbsArrComplex{N} = AbsArr{CFloat,N}

const AbsArrInteger{N} = AbsArr{<:Integer,N}
const AbsArrNumber{N} = AbsArr{<:Number,N}

const SVec{K,T} = SVector{K,T}
const SBool{K} = SVec{K,Bool}
const SFloat{K} = SVec{K,Float}
const SInt{K} = SVec{K,Int}
const SReal{K} = SVec{K,<:Real}
const SComplex{K} = SVec{K,CFloat}
const SNumber{K} = SVec{K,<:Number}

end
