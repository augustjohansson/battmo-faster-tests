using BattMo
using Test


@testset "3d" begin
    
    @test begin
        
        name = "p2d_40_jl_chen2020"

        fn = string(dirname(pathof(BattMo)), "/../test/data/jsonfiles/", name, ".json")
        inputparams = readBattMoJsonInputFile(fn)

        fn = string(dirname(pathof(BattMo)), "/../test/data/jsonfiles/3d_demo_geometry.json")
        inputparams_geometry = readBattMoJsonInputFile(fn)

        inputparams = mergeInputParams(inputparams_geometry, inputparams)

        inputparams["TimeStepping"]["numberOfTimeSteps"] = 20
        delete!(inputparams["TimeStepping"], "timeStepDuration")

        output = run_battery(inputparams);

        true
        
    end
    
end

