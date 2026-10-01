# Defines cluster config batch_connect values
type Openondemand::Batch_connect = Struct[{
    Optional['basic']     => Struct[{
        Optional['script_wrapper'] => String,
        Optional['set_host'] => String
    }],
    Optional['vnc']       => Struct[{
        Optional['script_wrapper'] => String,
        Optional['set_host'] => String,
        Optional['vnc_args'] => String,
    }],
    Optional['wayvnc']    => Struct[{
        Optional['script_wrapper'] => String,
        Optional['set_host'] => String,
        Optional['wayvnc_cmd'] => String,
        Optional['wayvnc_log'] => String,
        Optional['wayvnc_config'] => String,
        Optional['wayvnc_log_level'] => Enum['error', 'warning', 'info', 'debug', 'trace', 'quiet'],
        Optional['wayvnc_extra_args'] => String,
        Optional['wayland_socket'] => String,
        Optional['wayvnc_attach_timeout_seconds'] => Variant[Integer[1], String],
    }],
    Optional['ssh_allow'] => Boolean,
}]
