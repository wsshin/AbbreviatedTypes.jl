module AbbreviatedTypes

# @reexport makes all exported symbols of the exported packages available in module using
# AbbreviatedTypes
using Reexport
@reexport using StaticArrays

export Float, ComplexF
export Tuple2, Tuple3, Tuple23
export AbsVec, AbsMat, AbsArr
export VecBool, VecInt, VecFloat, VecComplexF
export AbsVecBool, AbsVecInt, AbsVecFloat, AbsVecComplexF, AbsVecInteger, AbsVecReal, AbsVecNumber
export MatFloat, MatComplexF, AbsMatFloat, AbsMatComplexF, AbsMatReal, AbsMatNumber
export ArrFloat, ArrComplexF, AbsArrFloat, AbsArrComplexF, AbsArrInteger, AbsArrNumber
export SVec, SBool, SFloat, SInt, SInteger, SReal, SComplexF, SNumber
export SMat, SSBool, SSFloat, SSInt, SSInteger, SSReal, SSComplexF, SSNumber

## Type aliases
# Below, use Int instead of Int64 for compatibility with 32-bit systems (e.g., x86 in appveyor.yml).
const Float = typeof(0.0)  # use Float = Float128 for quadruple precision in the future
const ComplexF = Complex{Float}

const Tuple2 = NTuple{2}
const Tuple3 = NTuple{3}
const Tuple23{T} = Tuple2{Tuple3{T}}

const AbsVec = AbstractVector
const AbsMat = AbstractMatrix
const AbsArr = AbstractArray

const VecBool = Vector{Bool}
const VecInt = Vector{Int}
const VecFloat = Vector{Float}
const VecComplexF = Vector{ComplexF}

const AbsVecBool = AbsVec{Bool}
const AbsVecInt = AbsVec{Int}
const AbsVecFloat = AbsVec{Float}
const AbsVecComplexF = AbsVec{ComplexF}

const AbsVecInteger = AbsVec{<:Integer}
const AbsVecReal = AbsVec{<:Real}
const AbsVecNumber = AbsVec{<:Number}

const MatFloat = Matrix{Float}
const MatComplexF = Matrix{ComplexF}

const AbsMatFloat = AbsMat{Float}
const AbsMatComplexF = AbsMat{ComplexF}

const AbsMatReal = AbsMat{<:Real}
const AbsMatNumber = AbsMat{<:Number}

const ArrFloat{N} = Array{Float,N}
const ArrComplexF{N} = Array{ComplexF,N}

# Below, without {N}, `where {T<:AbsArrNumber{3}}` is not equivalent to
# `where {T<:AbstractArray{<:Number,3}}`.
const AbsArrFloat{N} = AbsArr{Float,N}
const AbsArrComplexF{N} = AbsArr{ComplexF,N}

const AbsArrInteger{N} = AbsArr{<:Integer,N}
const AbsArrNumber{N} = AbsArr{<:Number,N}

# Static vectors
const SVec{K,T} = SVector{K,T}
const SBool{K} = SVec{K,Bool}
const SFloat{K} = SVec{K,Float}
const SInt{K} = SVec{K,Int}
const SInteger{K} = SVec{K,<:Integer}
const SReal{K} = SVec{K,<:Real}
const SComplexF{K} = SVec{K,ComplexF}
const SNumber{K} = SVec{K,<:Number}

# Static square matrices
const SMat{K,K²,T} = SMatrix{K,K,T,K²}
const SSBool{K,K²} = SMat{K,K²,Bool}
const SSFloat{K,K²} = SMat{K,K²,Float}
const SSInt{K,K²} = SMat{K,K²,Int}
const SSInteger{K,K²} = SMat{K,K²,<:Integer}
const SSReal{K,K²} = SMat{K,K²,<:Real}
const SSComplexF{K,K²} = SMat{K,K²,ComplexF}
const SSNumber{K,K²} = SMat{K,K²,<:Number}

end
