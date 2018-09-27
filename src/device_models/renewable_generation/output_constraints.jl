"""
This function adds the power limits of generators when there are no CommitmentVariables
"""
function activepower(m::JuMP.Model, devices::Array{T,1}, device_formulation::Type{D}, system_formulation::Type{S}, time_periods::Int64) where {T <: PowerSystems.RenewableGen, D <: AbstractRenewableDispatchForm, S <: PM.AbstractPowerFormulation}

    p_re = m[:p_re]
    time_index = m[:p_re].axes[2]
    name_index = m[:p_re].axes[1]

    (length(time_index) != time_periods) ? error("Length of time dimension inconsistent") : true

    pmax_re = JuMP.JuMPArray(Array{ConstraintRef}(length.(indices(p_re))), name_index, time_index)

    for t in time_index, (ix, name) in enumerate(name_index)

        if name == devices[ix].name
            pmax_re[name, t] = @constraint(m, p_re[name, t] <= devices[ix].tech.installedcapacity*devices[ix].scalingfactor.values[t])
        else
            error("Bus name in Array and variable do not match")
        end

    end

    JuMP.registercon(m, :pmax_re, pmax_re)

    return m

end


"""
This function adds the power limits of generators when there are no CommitmentVariables
"""
function reactivepower(m::JuMP.Model, devices::Array{PowerSystems.RenewableFullDispatch,1}, device_formulation::Type{D}, system_formulation::Type{S}, time_periods::Int64) where {D <: AbstractRenewableDispatchForm,  S <: AbstractACPowerModel}

    q_re = m[:q_re]
    time_index = m[:q_re].axes[2]
    name_index = m[:q_re].axes[1]

    (length(time_index) != time_periods) ? error("Length of time dimension inconsistent") : true

    qmax_re = JuMP.JuMPArray(Array{ConstraintRef}(length.(indices(q_re))), name_index, time_index)
    qmin_re = JuMP.JuMPArray(Array{ConstraintRef}(length.(indices(q_re))), name_index, time_index)

    for t in time_index, (ix, name) in enumerate(name_index)

        if name == devices[ix].name

            qmax_re[name, t] = @constraint(m, q_re[name, t] <= devices[ix].tech.reactivepowerlimits.max)
            qmin_re[name, t] = @constraint(m, q_re[name, t] >= devices[ix].tech.reactivepowerlimits.min)

        else
            error("Bus name in Array and variable do not match")
        end

    end

    JuMP.registercon(m, :qmax_re, qmax_re)
    JuMP.registercon(m, :qmin_re, qmin_re)

    return m

end
