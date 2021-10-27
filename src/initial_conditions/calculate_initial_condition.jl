"""
Default implementation of set_initial_condition_value
"""
function set_ic_quantity!(
    ic::InitialCondition{T, PJ.ParameterRef},
    var_value::Float64,
) where {T <: InitialConditionType}
    PJ.set_value(ic.value, var_value)
    return
end

"""
Default implementation of set_initial_condition_value
"""
function set_ic_quantity!(
    ic::InitialCondition{T, Float64},
    var_value::Float64,
) where {T <: InitialConditionType}
    @debug "Initial condition value set with Float64. Won't update the model until rebuild" _group =
        LOG_GROUP_BUILD_INITIAL_CONDITIONS
    ic.value = var_value
    return
end
