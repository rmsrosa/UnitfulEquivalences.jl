using Unitful
using UnitfulEquivalences
using Test

@testset "Equivalences" begin
    # MassEnergy
    @test uconvert(u"keV", 1u"me", MassEnergy()) ≈ 510.999u"keV" (atol = 0.001u"keV")
    @test uconvert(u"kg", 1000u"keV", MassEnergy()) ≈ 1.957u"me" (atol = 0001u"me")

    # PhotonEnergy
    @test uconvert(u"eV", 589u"nm", PhotonEnergy()) === 2.104994880020378u"eV"
    @test uconvert(u"μm", 1u"eV", PhotonEnergy()) ≈ 1.239u"μm" (atol = 0.001u"μm")

    @test uconvert(u"km", 1u"s^-1", PhotonEnergy()) === 299792.458u"km"
    @test uconvert(u"ms^-1", 1u"m", PhotonEnergy()) === 299792.458u"ms^-1"

    @test uconvert(u"eV", 1u"fs^-1", PhotonEnergy()) === 4.135667696923859u"eV"
    @test uconvert(u"ns^-1", 1u"eV", PhotonEnergy()) === 241798.9242084918u"ns^-1"

    # Throw errors
    @test_throws ArgumentError uconvert(u"kg", 1u"eV", PhotonEnergy())
    @test_throws ArgumentError uconvert(u"ms^-1", 1u"m", MassEnergy())
end