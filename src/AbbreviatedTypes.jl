module AbbreviatedTypes

# @reexport makes all exported symbols of the exported packages available in module using
# AbbreviatedTypes
using Reexport
@reexport using StaticArrays

export @define_types_with

macro define_types_with(F)
    return :( define_types_with(@__MODULE__, $F) )
end

function define_types_with(m::Module, F::DataType)
    F<:AbstractFloat || throw(ArgumentError("F = $F should be <:AbstractFloat."))

    if isdefined(m, :Float)  # Float is already defined in m; assume it is defined by define_types_with()
        if m.Float == F  # @define_types_with() is called with same F; this is allowed and do nothing
            return nothing
        else  # @define_types_with() is called with different F; this is not allowed
            throw(ArgumentError("AbbreviatedTypes.@define_types_with(F) is probably already called with F = $(m.Float) in $m" *
                "; it cannot be called again with different F = $F."))
        end
    end

    m.eval( :(begin
        ## Type aliases
        # Below, use Int instead of Int64 for compatibility with 32-bit systems (e.g., x86 in appveyor.yml).
        const Float = $F
        const AbsFloat = AbstractFloat
        const ComplexF = Complex{Float}

        const Tuple2 = NTuple{2}
        const Tuple3 = NTuple{3}
        const Tuple22{T} = Tuple2{Tuple2{T}}
        const Tuple23{T} = Tuple2{Tuple3{T}}
        const Tuple32{T} = Tuple3{Tuple2{T}}

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
        const SMat{M,N,T,MN} = SMatrix{M,N,T,MN}
        const S²Mat{K,K²,T} = SMat{K,K,T,K²}  # square static matrix

        ## Square SMatrices with specific dimensions
        const S²Mat1{T} = S²Mat{1,1,T}
        const S²Mat2{T} = S²Mat{2,4,T}
        const S²Mat3{T} = S²Mat{3,9,T}

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

        # Square matrices with concrete elements; superscript 2 reads "square".
        const S²Bool{K,K²} = S²Mat{K,K²,Bool}
        const S²Int{K,K²} = S²Mat{K,K²,Int}
        const S²Float{K,K²} = S²Mat{K,K²,Float}
        const S²ComplexF{K,K²} = S²Mat{K,K²,ComplexF}

        # Square matrices with abstract elements; superscript 2 reads "square".
        const S²Integer{K,K²} = S²Mat{K,K²,<:Integer}
        const S²Real{K,K²} = S²Mat{K,K²,<:Real}
        const S²Complex{K,K²} = S²Mat{K,K²,<:Complex}
        const S²Number{K,K²} = S²Mat{K,K²,<:Number}

        ## StaticArrays, mutable
        const MVec{K,T} = MVector{K,T}
        const MMat{M,N,T,MN} = MMatrix{M,N,T,MN}
        const M²Mat{K,K²,T} = MMat{K,K,T,K²}  # square mutable matrix

        # Vectors with concrete elements
        const MBool{K} = MVec{K,Bool}
        const MInt{K} = MVec{K,Int}
        const MFloat{K} = MVec{K,Float}
        const MComplexF{K} = MVec{K,ComplexF}

        # Vectors with abstract elements
        const MInteger{K} = MVec{K,<:Integer}
        const MReal{K} = MVec{K,<:Real}
        const MComplex{K} = MVec{K,<:Complex}
        const MNumber{K} = MVec{K,<:Number}

        # Square matrices with concrete elements; superscript 2 reads "square".
        const M²Bool{K,K²} = M²Mat{K,K²,Bool}
        const M²Int{K,K²} = M²Mat{K,K²,Int}
        const M²Float{K,K²} = M²Mat{K,K²,Float}
        const M²ComplexF{K,K²} = M²Mat{K,K²,ComplexF}

        # Square matrices with abstract elements; superscript 2 reads "square".
        const M²Integer{K,K²} = M²Mat{K,K²,<:Integer}
        const M²Real{K,K²} = M²Mat{K,K²,<:Real}
        const M²Complex{K,K²} = M²Mat{K,K²,<:Complex}
        const M²Number{K,K²} = M²Mat{K,K²,<:Number}

        const τₐ₀ = eps(Float)  # default absolute tolerance
        const τᵣ₀ = Base.rtoldefault(Float)  # dedault relative tolerance
    end) )

    return nothing
end

end
