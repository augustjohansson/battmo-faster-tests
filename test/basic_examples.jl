using BattMo
using Test

names  =[
    "p2d_40",
    "p2d_40_jl_chen2020",
    "p2d_40_jl_ud_func",
    "p2d_40_jl_ud_tab",
    "p2d_40_no_cc",
    "p2d_40_cccv"
]

# Use larger time steps to keep test run times short (~20 steps each).
# Values computed as totalSimTime/20 for each case.
time_step_durations = Dict(
    "p2d_40"             => 198.0,   # CCDischarge DRate=1: totalTime=3960s
    "p2d_40_jl_ud_func"  => 198.0,   # CCDischarge DRate=1: totalTime=3960s
    "p2d_40_no_cc"       => 198.0,   # CCDischarge DRate=1: totalTime=3960s
    "p2d_40_jl_ud_tab"   => 540.0,   # CCCV 1-cycle DRate=1 CRate=1: totalTime=10800s
    "p2d_40_jl_chen2020" => 5400.0,  # CCCV 10-cycle DRate=1 CRate=1: totalTime=108000s
    "p2d_40_cccv"        => 2430.0,  # CCCV 3-cycle DRate=1 CRate=0.5: totalTime=48600s
)

@testset "basic tests"  begin
    for name in names
        @testset "$name" begin
            @test begin
                fn = string(dirname(pathof(BattMo)), "/../test/data/jsonfiles/", name, ".json")
                inputparams = readBattMoJsonInputFile(fn)
                inputparams["TimeStepping"]["timeStepDuration"] = time_step_durations[name]
                delete!(inputparams["TimeStepping"], "numberOfTimeSteps")
                function hook(simulator,
                              model,
                              state0,
                              forces,
                              timesteps,
                              cfg)
                    cfg[:error_on_incomplete] = true
                end
                output = run_battery(inputparams; hook = hook)
                true
            end
        end
    end
end

