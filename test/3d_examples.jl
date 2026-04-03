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

        # Use a large time step to keep the test fast (~20 steps).
        # p2d_40_jl_chen2020: CCCV 10-cycle, totalTime=108000s -> 5400s/step gives ~20 steps.
        inputparams["TimeStepping"]["timeStepDuration"] = 5400.0
        delete!(inputparams["TimeStepping"], "numberOfTimeSteps")

        output = run_battery(inputparams);

        true
        
    end
    
end

