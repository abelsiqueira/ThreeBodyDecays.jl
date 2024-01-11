using ThreeBodyDecays
using Test

@testset "LS amplitude integer spin" begin
    tbs = ThreeBodySystem(2.0, 1.0, 1.5; m0=6.0)
    dpp = randomPoint(tbs)
    #
    dc = DecayChainLS(1, σ -> 1 / (4.1^2 - σ - 0.1im);
        two_j=2,
        parity='-',
        Ps=['+', '+', '+', '+'],
        tbs=tbs)
    @test sum(reim(amplitude(dc, dpp)) .≈ 0.0) == 0
end


@testset "LS amplitude half-integer spin" begin
    tbs = ThreeBodySystem(2.0, 1.0, 1.5; m0=6.0,
        two_js=ThreeBodySpins(1, 0, 0; two_h0=1))  # 1/2+ 0- 0- 1/2+
    σs = randomPoint(tbs.ms)
    dpp = DalitzPlotPoint(; σs=σs, two_λs=[1, 0, 0, 1])
    #
    dc = DecayChainLS(3, σ -> 1 / (4.1^2 - σ - 0.1im); two_j=3, parity='-', Ps=['+', '-', '-', '+'], tbs=tbs)
    # @show amplitude(dpp, dc)
    @test sum(reim(amplitude(dc, dpp)) .≈ 0.0) == 0
    # testing something else?
end
