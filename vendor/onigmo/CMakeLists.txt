# Copyright(C) 2015 Brazil
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License version 2.1 as published by the Free Software Foundation.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

if(GRN_WITH_ONIGMO)
  set(ONIGMO_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../onigmo-source")
  set(ONIGMO_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/../onigmo-source")

  include(CheckTypeSize)

  macro(ac_check_sizeof type)
    string(TOUPPER "${type}" output_variable_base_name)
    set(output_variable_name "ONIG_SIZEOF_${output_variable_base_name}")
    check_type_size(${type} ${output_variable_name})
    if(HAVE_${output_variable_name})
      add_definitions(
	-DSIZEOF_${output_variable_base_name}=${${output_variable_name}}
	)
    endif()
  endmacro()

  ac_check_sizeof(short)
  ac_check_sizeof(int)
  ac_check_sizeof(long)

  if(MSVC)
    add_definitions(-Dinline=__inline)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
  endif()

  include_directories(
    ${ONIGMO_BINARY_DIR}
    ${ONIGMO_SOURCE_DIR}
    )

  set(ONIGMO_SOURCES
    "${ONIGMO_SOURCE_DIR}/regint.h"
    "${ONIGMO_SOURCE_DIR}/regparse.h"
    "${ONIGMO_SOURCE_DIR}/regenc.h"
    "${ONIGMO_SOURCE_DIR}/st.h"
    "${ONIGMO_SOURCE_DIR}/regerror.c"
    "${ONIGMO_SOURCE_DIR}/regparse.c"
    "${ONIGMO_SOURCE_DIR}/regext.c"
    "${ONIGMO_SOURCE_DIR}/regcomp.c"
    "${ONIGMO_SOURCE_DIR}/regexec.c"
    "${ONIGMO_SOURCE_DIR}/reggnu.c"
    "${ONIGMO_SOURCE_DIR}/regenc.c"
    "${ONIGMO_SOURCE_DIR}/regsyntax.c"
    "${ONIGMO_SOURCE_DIR}/regtrav.c"
    "${ONIGMO_SOURCE_DIR}/regversion.c"
    "${ONIGMO_SOURCE_DIR}/st.c"
    "${ONIGMO_SOURCE_DIR}/regposix.c"
    "${ONIGMO_SOURCE_DIR}/regposerr.c"
    "${ONIGMO_SOURCE_DIR}/enc/unicode.c"
    "${ONIGMO_SOURCE_DIR}/enc/ascii.c"
    "${ONIGMO_SOURCE_DIR}/enc/utf8.c"
    "${ONIGMO_SOURCE_DIR}/enc/utf16_be.c"
    "${ONIGMO_SOURCE_DIR}/enc/utf16_le.c"
    "${ONIGMO_SOURCE_DIR}/enc/utf32_be.c"
    "${ONIGMO_SOURCE_DIR}/enc/utf32_le.c"
    "${ONIGMO_SOURCE_DIR}/enc/unicode/casefold.h"
    "${ONIGMO_SOURCE_DIR}/enc/unicode/name2ctype.h"
    "${ONIGMO_SOURCE_DIR}/enc/euc_jp.c"
    "${ONIGMO_SOURCE_DIR}/enc/sjis.c"
    "${ONIGMO_SOURCE_DIR}/enc/cp932.c"
    "${ONIGMO_SOURCE_DIR}/enc/jis/props.h"
#    "${ONIGMO_SOURCE_DIR}/enc/jis/props.kwd"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_1.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_2.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_3.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_4.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_5.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_6.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_7.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_8.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_9.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_10.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_11.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_13.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_14.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_15.c"
    "${ONIGMO_SOURCE_DIR}/enc/iso8859_16.c"
    "${ONIGMO_SOURCE_DIR}/enc/euc_tw.c"
    "${ONIGMO_SOURCE_DIR}/enc/euc_kr.c"
    "${ONIGMO_SOURCE_DIR}/enc/big5.c"
    "${ONIGMO_SOURCE_DIR}/enc/gb18030.c"
    "${ONIGMO_SOURCE_DIR}/enc/koi8_r.c"
    "${ONIGMO_SOURCE_DIR}/enc/cp1251.c"
    )

  add_library(onigmo STATIC ${ONIGMO_SOURCES})
  set_source_files_properties(${ONIGMO_SOURCES}
    PROPERTIES
    COMPILE_FLAGS "${GRN_C_COMPILE_FLAGS}")
  set_target_properties(
    onigmo
    PROPERTIES
    POSITION_INDEPENDENT_CODE ON)
endif()
