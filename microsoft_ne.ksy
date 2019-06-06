meta:
  id: microsoft_ne
  file-extension: microsoft_ne
  endian: le
  encoding: ascii

seq:
- id: header
  type: dos_header

instances:
  ne_header:
    type: ne_header
    io: _root._io
    pos: header.e_lfanew
  segment_table:
    type: segment_table_entry
    io: _root._io
    pos: header.e_lfanew + ne_header.ne_segtab
    repeat: expr
    repeat-expr: ne_header.ne_cseg
  resource_table:
    type: resource_table
    io: _root._io
    pos: header.e_lfanew + ne_header.ne_rsrctab
  resident_name_table:
    type: resident_name_table
    io: _root._io
    pos: header.e_lfanew + ne_header.ne_restab
  module_reference_table:
    type: module_reference_table
    io: _root._io
    pos: header.e_lfanew + ne_header.ne_modtab
  imported_name_table:
    type: imported_name_table
    io: _root._io
    pos: header.e_lfanew + ne_header.ne_imptab
  entry_table:
    type: entry_table
    io: _root._io
    pos: header.e_lfanew + ne_header.ne_enttab
    size: ne_header.ne_cbenttab
  nonresident_name_table:
    type: nonresident_name_table
    io: _root._io
    pos: ne_header.ne_nrestab
    size: ne_header.ne_cbnrestab

types:

  dos_header:
    seq:
    - id: e_magic
      type: u2
    - id: e_cblp
      type: u2
    - id: e_cp
      type: u2
    - id: e_crlc
      type: u2
    - id: e_cparhdr
      type: u2
    - id: e_minalloc
      type: u2
    - id: e_maxalloc
      type: u2
    - id: e_ss
      type: u2
    - id: e_sp
      type: u2
    - id: e_csum
      type: u2
    - id: e_ip
      type: u2
    - id: e_cs
      type: u2
    - id: e_lfarlc
      type: u2
    - id: e_ovno
      type: u2
    - id: e_res
      type: u2
      repeat: expr
      repeat-expr: 4
    - id: e_oemid
      type: u2
    - id: e_oeminfo
      type: u2
    - id: e_res2
      type: u2
      repeat: expr
      repeat-expr: 10
    - id: e_lfanew
      type: u2

  ne_header:
    seq:
    - id: ne_magic
      type: u2
    - id: ne_ver
      type: u1
    - id: ne_rev
      type: u1
    - id: ne_enttab
      type: u2
    - id: ne_cbenttab
      type: u2
    - id: ne_crc
      type: u4
    - id: ne_flags
      type: u2
    - id: ne_autodata
      type: u2
    - id: ne_heap
      type: u2
    - id: ne_stack
      type: u2
    - id: ne_csip
      type: u4
    - id: ne_sssp
      type: u4
    - id: ne_cseg
      type: u2
    - id: ne_cmod
      type: u2
    - id: ne_cbnrestab
      type: u2
    - id: ne_segtab
      type: u2
    - id: ne_rsrctab
      type: u2
    - id: ne_restab
      type: u2
    - id: ne_modtab
      type: u2
    - id: ne_imptab
      type: u2
    - id: ne_nrestab
      type: u4
    - id: ne_cmovent
      type: u2
    - id: ne_align
      type: u2
    - id: ne_cres
      type: u2
    - id: ne_exetyp
      type: u1
    - id: ne_flagsothers
      type: u1
    - id: ne_pretthunks
      type: u2
    - id: ne_psegrefu1s
      type: u2
    - id: ne_swaparea
      type: u2
    - id: ne_expver
      type: u2

  segment_table_entry:
    seq:
    - id: position
      type: u2
    - id: length
      type: u2
    - id: flags
      type: u2
    - id: min_alloc
      type: u2
    instances:
      real_pos:
        value: position << _root.ne_header.ne_align
      data:
        io: _root._io
        pos: real_pos
        type: segment_data
        size: length
      relocation:
        io: _root._io
        pos: real_pos + length
        if: (flags & 0x100) != 0
        type: segment_relocation

  resource_table:
    seq:
    - id: alignment_shift_count
      type: u2
    - id: entries
      type: resource_table_entry
      repeat: until
      repeat-until: _.type_id == 0

  resource_table_entry:
    seq:
    - id: type_id
      type: u2
    - id: num_resources
      type: u2
    - id: reserved
      type: u4
    - id: entries
      type: resource_table_entry_element
      repeat: expr
      repeat-expr: num_resources
      if: type_id != 0

  resource_table_entry_element:
    seq:
    - id: offset
      type: u2
    - id: length
      type: u2
    - id: flag
      type: u2
    - id: resource_id_with_flag
      type: u2
    - id: reserved
      type: u4
    instances:
      data:
        io: _root._io
        pos: offset << _root.resource_table.alignment_shift_count
        size: length << _root.resource_table.alignment_shift_count
      resource_id:
        if: (resource_id_with_flag & 0x8000) != 0
        value: resource_id_with_flag - 0x8000
      resource_str:
        if: (resource_id_with_flag & 0x8000) == 0
        type: string
        pos:  _root.header.e_lfanew + _root.ne_header.ne_rsrctab + resource_id_with_flag

  resident_name_table:
    seq:
    - id: entries
      type: resident_name_table_entry
      repeat: until
      repeat-until: _.string.length == 0

  resident_name_table_entry:
    seq:
    - id: string
      type: string
    - id: ordinal
      type: u2

  module_reference_table:
    seq:
    - id: entries
      type: module_reference_table_entry
      repeat: expr
      repeat-expr: _root.ne_header.ne_cmod

  module_reference_table_entry:
    seq:
    - id: offset
      type: u2
    instances:
      name:
        io: _root._io
        pos: _root.header.e_lfanew + _root.ne_header.ne_imptab + offset
        type: string

  imported_name_table:
    seq:
    - id: entries
      type: string
      repeat: expr
      repeat-expr: 0 # FIXME

  string:
    seq:
    - id: length
      type: u1
    - id: string
      type: str
      size: length

  entry_table:
    seq:
    - id: entries
      type: entry_table_entry
      repeat: eos

  entry_table_entry:
    seq:
    - id: number_entries
      type: u1
    - id: segment_indicator
      type: u1
    - id: segments_fixed
      type: entry_table_entry_fixed
      if: segment_indicator >= 0x01 and segment_indicator <= 0xfe
      repeat: expr
      repeat-expr: number_entries
    - id: segments_movable
      type: entry_table_entry_movable
      if: segment_indicator == 0xff
      repeat: expr
      repeat-expr: number_entries

  entry_table_entry_fixed:
    seq:
    - id: flag
      type: u1
    - id: offset
      type: u2

  entry_table_entry_movable:
    seq:
    - id: flag
      type: u1
    - id: int3
      contents: [0xcd, 0x3f]
    - id: segment_number
      type: u1
    - id: offset
      type: u2

  segment_data:
    seq:
    - id: unk1
      size-eos: true

  segment_relocation:
    seq:
    - id: count
      type: u2
    - id: entries
      type: segment_relocation_element
      repeat: expr
      repeat-expr: count

  segment_relocation_element:
    seq:
    - id: source_type
      type: u1
    - id: flags
      type: u1
    - id: offset
      type: u2
    - id: relocation_info
      type:
        switch-on: (flags & 3)
        cases:
          0: segment_relocation_internalref
          1: segment_relocation_importordinal
          2: segment_relocation_importname
          3: segment_relocation_osfixup

  segment_relocation_internalref:
    seq:
    - id: segment_number
      type: u1
    - id: zero
      contents: [0]
    - id: offset
      type: u2

  segment_relocation_importname:
    seq:
    - id: index
      type: u2
    - id: offset
      type: u2

  segment_relocation_importordinal:
    seq:
    - id: index
      type: u2
    - id: ordinal
      type: u2

  segment_relocation_osfixup:
    seq:
    - id: type
      type: u2
    - id: zero
      contents: [0, 0]

  nonresident_name_table:
    seq:
    - id: entries
      type: resident_name_table_entry
      repeat: eos
