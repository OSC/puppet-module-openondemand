# Defines cluster config batch_connect values
type Openondemand::Batch_connect = Struct[{
  Optional['basic']     => Struct[{
        Optional['script_wrapper'] => String,
        Optional['set_host'] => String
    }],
  Optional['vnc']       => Struct[{
        Optional['script_wrapper'] => String,
        Optional['set_host'] => String
    }],
  Optional['ssh_allow'] => Boolean,
}]
