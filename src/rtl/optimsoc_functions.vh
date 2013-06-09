/**
 * This file is part of OpTiMSoC.
 *
 * OpTiMSoC is free hardware: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * As the LGPL in general applies to software, the meaning of
 * "linking" is defined as using the OpTiMSoC in your projects at
 * the external interfaces.
 *
 * OpTiMSoC is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with OpTiMSoC. If not, see <http://www.gnu.org/licenses/>.
 *
 * =================================================================
 *
 * Utility functions
 *
 *
 * (c) 2013 by the author(s)
 *
 * Author(s):
 *    Stefan Wallentowitz, stefan.wallentowitz@tum.de
 *    Philipp Wagner, philipp.wagner@tum.de
 */

/**
 * Math function: $clog2 as specified in Verilog-2005
 *
 * clog2 =          0        for value == 0
 *         ceil(log2(value)) for value >= 1
 *
 * This implementation is a synthesizable variant of the $clog2 function as
 * specified in the Verilog-2005 standard (IEEE 1364-2005).
 *
 * To quote the standard:
 *   The system function $clog2 shall return the ceiling of the log base 2 of
 *   the argument (the log rounded up to an integer value). The argument can be
 *   an integer or an arbitrary sized vector value. The argument shall be
 *   treated as an unsigned value, and an argument value of 0 shall produce a
 *   result of 0.
 */
function integer clog2;
   input integer value;
   begin
      value = value - 1;
      for (clog2 = 0; value > 0; clog2 = clog2 + 1) begin
         value = value >> 1;
      end
   end
endfunction


/**
 * Math function: enhanced clog2 function
 *
 *                        0        for value == 0
 * clog2_width =          1        for value == 1
 *               ceil(log2(value)) for value > 1
 *
 *
 * This function is a variant of the clog2() function, which returns 1 if the
 * input value is 1. In all other cases it behaves exactly like clog2().
 * This is useful to define registers which are wide enough to contain
 * "value" values.
 *
 * Example 1:
 *   parameter ITEMS = 1;
 *   localparam ITEMS_WIDTH = clog2_width(ITEMS); // 1
 *   reg [ITEMS_WIDTH-1:0] item_register; // items_register is now [0:0]
 *
 * Example 2:
 *   parameter ITEMS = 64;
 *   localparam ITEMS_WIDTH = clog2_width(ITEMS); // 6
 *   reg [ITEMS_WIDTH-1:0] item_register; // items_register is now [5:0]
 *
 * Note: I if you want to store the number "value" inside a register, you
 * need a register with size clog2(value + 1), since you also need to store the
 * number 0.
 *
 * Example 3:
 *   reg [clog2_width(64) - 1 : 0]     store_64_items;  // width is [5:0]
 *   reg [clog2_width(64 + 1) - 1 : 0] store_number_64; // width is [6:0]
 */
function integer clog2_width;
   input integer value;
   begin
      if (value == 1) begin
         clog2_width = 1;
      end else begin
         clog2_width = clog2(value);
      end
   end
endfunction