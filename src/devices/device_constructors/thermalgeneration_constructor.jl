"""
This function creates the model for a full themal dispatch formulation depending on combination of devices, device_formulation and system_formulation
"""
function _internal_device_constructor!(ps_m::CanonicalModel,
                                        device::Type{T},
                                        device_formulation::Type{D},
                                        system_formulation::Type{S},
                                        sys::PSY.System,
                                        time_steps::UnitRange{Int64},
                                        resolution::Dates.Period;
                                        kwargs...) where {T <: PSY.ThermalGen,
                                                            D <: AbstractThermalFormulation,
                                                            S <: PM.AbstractPowerFormulation}

    devices = PSY.get_components(device, sys)

    if validate_available_devices(devices, device)
        return
    end

    parameters = get(kwargs, :parameters, true)

    #Variables
    activepower_variables(ps_m, devices, time_steps);

    reactivepower_variables(ps_m, devices, time_steps);

    commitment_variables(ps_m, devices, time_steps)

    #Constraints
    activepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    reactivepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    commitment_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, parameters)

    ramp_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, resolution, parameters)

    time_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, resolution, parameters)

    #Cost Function
    cost_function(ps_m, devices, device_formulation, system_formulation, resolution)

    return

end


"""
This function creates the model for a full themal dispatch formulation depending on combination of devices, device_formulation and system_formulation
"""
function _internal_device_constructor!(ps_m::CanonicalModel,
                                        device::Type{T},
                                        device_formulation::Type{D},
                                        system_formulation::Type{S},
                                        sys::PSY.System,
                                        time_steps::UnitRange{Int64},
                                        resolution::Dates.Period;
                                        kwargs...) where {T <: PSY.ThermalGen,
                                                            D <: AbstractThermalFormulation,
                                                            S <: PM.AbstractActivePowerFormulation}

    devices = PSY.get_components(device, sys)

    if validate_available_devices(devices, device)
        return
    end

    parameters = get(kwargs, :parameters, true)

    #Variables
    activepower_variables(ps_m, devices, time_steps);

    commitment_variables(ps_m, devices, time_steps)

    #Constraints
    activepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    commitment_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, parameters)

    ramp_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, resolution, parameters)

    time_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, resolution, parameters)

    #Cost Function
    cost_function(ps_m, devices, device_formulation, system_formulation, resolution)

    return

end

"""
This function creates the model for a full themal dispatch formulation depending on combination of devices, device_formulation and system_formulation
"""
function _internal_device_constructor!(ps_m::CanonicalModel,
                                        device::Type{T},
                                        device_formulation::Type{ThermalRampLimited},
                                        system_formulation::Type{S},
                                        sys::PSY.System,
                                        time_steps::UnitRange{Int64},
                                        resolution::Dates.Period;
                                        kwargs...) where {T <: PSY.ThermalGen,
                                                            S <: PM.AbstractPowerFormulation}

    devices = PSY.get_components(device, sys)

    if validate_available_devices(devices, device)
        return
    end

    parameters = get(kwargs, :parameters, true)

    #Variables
    activepower_variables(ps_m, devices, time_steps);

    reactivepower_variables(ps_m, devices, time_steps);

    #Constraints
    activepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    reactivepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    ramp_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, resolution, parameters)

    #Cost Function
    cost_function(ps_m, devices, device_formulation, system_formulation, resolution)

    return

end


"""
This function creates the model for a full themal dispatch formulation depending on combination of devices, device_formulation and system_formulation
"""
function _internal_device_constructor!(ps_m::CanonicalModel,
                                        device::Type{T},
                                        device_formulation::Type{ThermalRampLimited},
                                        system_formulation::Type{S},
                                        sys::PSY.System,
                                        time_steps::UnitRange{Int64},
                                        resolution::Dates.Period;
                                        kwargs...) where {T <: PSY.ThermalGen,
                                                            S <: PM.AbstractActivePowerFormulation}

    devices = PSY.get_components(device, sys)

    if validate_available_devices(devices, device)
        return
    end

    parameters = get(kwargs, :parameters, true)

    #Variables
    activepower_variables(ps_m, devices, time_steps);

    #Constraints
    activepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    ramp_constraints(ps_m, devices, device_formulation, system_formulation, time_steps, resolution, parameters)

    #Cost Function
    cost_function(ps_m, devices, device_formulation, system_formulation, resolution)

    return

end



function _internal_device_constructor!(ps_m::CanonicalModel,
                                        device::Type{T},
                                        device_formulation::Type{D},
                                        system_formulation::Type{S},
                                        sys::PSY.System,
                                        time_steps::UnitRange{Int64},
                                        resolution::Dates.Period;
                                        kwargs...) where {T<: PSY.ThermalGen,
                                                            D <: AbstractThermalDispatchForm,
                                                            S <: PM.AbstractPowerFormulation}

    devices = PSY.get_components(device, sys)

    if validate_available_devices(devices, device)
        return
    end

    #Variables
    activepower_variables(ps_m, devices, time_steps);

    reactivepower_variables(ps_m, devices, time_steps);

    #Constraints
    activepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    reactivepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    #Cost Function
    cost_function(ps_m, devices, device_formulation, system_formulation, resolution)

    return

end

function _internal_device_constructor!(ps_m::CanonicalModel,
                                        device::Type{T},
                                        device_formulation::Type{D},
                                        system_formulation::Type{S},
                                        sys::PSY.System,
                                        time_steps::UnitRange{Int64},
                                        resolution::Dates.Period;
                                        kwargs...) where {T<: PSY.ThermalGen,
                                                            D <: AbstractThermalDispatchForm,
                                                            S <: PM.AbstractActivePowerFormulation}

    devices = PSY.get_components(device, sys)

    if validate_available_devices(devices, device)
        return
    end

    #Variables
    activepower_variables(ps_m, devices, time_steps);

    #Constraints
    activepower_constraints(ps_m, devices, device_formulation, system_formulation, time_steps)

    #Cost Function
    cost_function(ps_m, devices, device_formulation, system_formulation, resolution)

    return

end
