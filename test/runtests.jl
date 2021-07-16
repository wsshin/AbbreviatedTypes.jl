using AbbreviatedTypes
using Test

@testset "AbbreviatedTypes.jl" begin
    @test typeof((1,2)) == Tuple2{Int}
    @test typeof((1,2,3)) == Tuple3{Int}

    m = 3
    @test typeof(rand(Bool,m)) == VecBool
    @test typeof(rand(Int,m)) == VecInt
    @test typeof(rand(Float,m)) == VecFloat
    @test typeof(rand(ComplexF,m)) == VecComplexF

    m, n = 3, 4
    @test typeof(rand(Bool,m,n)) == MatBool
    @test typeof(rand(Int,m,n)) == MatInt
    @test typeof(rand(Float,m,n)) == MatFloat
    @test typeof(rand(ComplexF,m,n)) == MatComplexF

    m, n, l = 3, 4, 5
    @test typeof(rand(Bool,m,n,l)) == ArrBool{3}
    @test typeof(rand(Int,m,n,l)) == ArrInt{3}
    @test typeof(rand(Float,m,n,l)) == ArrFloat{3}
    @test typeof(rand(ComplexF,m,n,l)) == ArrComplexF{3}

    m = 3
    @test (sv = @SVector rand(Bool,m); sv === SVec{m}(sv.data))
    @test (sv = @SVector rand(Int,m); sv === SVec{m}(sv.data))
    @test (sv = @SVector rand(Float,m); sv === SVec{m}(sv.data))
    @test (sv = @SVector rand(ComplexF,m); sv === SVec{m}(sv.data))

    m = 3
    @test (sm = @SMatrix rand(Bool,m,m); sm === S²Mat{m,m^2}(sm.data))
    @test (sm = @SMatrix rand(Int,m,m); sm === S²Mat{m,m^2}(sm.data))
    @test (sm = @SMatrix rand(Float,m,m); sm === S²Mat{m,m^2}(sm.data))
    @test (sm = @SMatrix rand(ComplexF,m,m); sm === S²Mat{m,m^2}(sm.data))
end
