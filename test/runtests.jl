using Unitful
using UnitfulEquivalences
using Test

@testset "Equivalences" begin

    # Concentration of solids in solution
    #
    # It is a proportional relation but we do it here this way just to check the code
    #
    # need to use derived dimensions Unitful.Density since g(Unitful.Mass / Unitful.Volume) 
    # is not allowed/understood
    g(x) = (1.0u"L"/u"kg") * x
    @equivalence Solutions
    @eqrelation Solutions Unitful.Volume = g(Unitful.Mass)
    @eqrelation Solutions Unitful.NoDims = g(Unitful.Density)
    @test uconvert(u"ml", 1u"kg", Solutions()) === 1000.0u"ml"
    @test uconvert(Unitful.NoUnits, 1u"mg/L", Solutions()) == 1.0e-6

    # Squared area, just a nonlinear relation for testing
    h(x) = 4π * x^3 / 3
    @equivalence Ball
    @eqrelation Ball Unitful.Volume = h(Unitful.Length)
    @test uconvert(u"m^3", 1u"m", Ball()) ≈ (4π/3) * u"m^3"
    
    # MassEnergy
    @test uconvert(u"keV", 1u"me", MassEnergy()) ≈ 510.999u"keV" (atol = 0.001u"keV")
    @test uconvert(u"kg", 1000u"keV", MassEnergy()) ≈ 1.957u"me" (atol = 0001u"me")

    # Spectral
    @test uconvert(u"eV", 589u"nm", Spectral()) === 2.104994880020378u"eV"
    @test uconvert(u"μm", 1u"eV", Spectral()) ≈ 1.239u"μm" (atol = 0.001u"μm")

    @test uconvert(u"km", 1u"s^-1", Spectral()) === 299792.458u"km"
    @test uconvert(u"ms^-1", 1u"m", Spectral()) === 299792.458u"ms^-1"

    @test uconvert(u"eV", 1u"fs^-1", Spectral()) === 4.135667696923859u"eV"
    @test uconvert(u"ns^-1", 1u"eV", Spectral()) === 241798.9242084918u"ns^-1"

    # Throw errors
    @test_throws ArgumentError uconvert(u"kg", 1u"eV", Spectral())
    @test_throws ArgumentError uconvert(u"ms^-1", 1u"m", MassEnergy())
end