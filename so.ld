/* ENTRY defines the first executable instruction in an
 * output file (its entry point).
 *
 * See GNU Linker Scripts ld
 * documentation:
 * https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC24
 * */
ENTRY(call_start_cpu0)

/* The MEMORY command describes the location and size of
 * blocks of memory in the target.
 *
 * See GNU Linker Scripts ld documentation:
 * https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC16
 * */
MEMORY
{
    /* "rx" means this "SRAM0" (Instruction RAM) section
     * contains readable and executable memory.
     *
     * ORIGIN is is the start address of the region in
     * physical memory.
     *
     * LENGTH is the size in bytes of the region.
     *
     * See Espressif's official ESP32 Technical Reference
     * Manual, "Table 3.3-2. Embedded Memory Address
     * Mapping" at
     * https://documentation.espressif.com/esp32_technical_reference_manual_en.pdf,
     * page 68 */
    SRAM0 (rx) : ORIGIN = 0x40080000, LENGTH = 128K
}

/* NOTE: THIS SECTION IS OPTIONAL AND CAN BE SAFELY REMOVED.
 *
 * The SECTIONS command controls exactly where input
 * sections are placed into output sections, their order in
 * the output file, and to which output sections they are
 * allocated.
 *
 * See GNU Linker Scripts ld documentation:
 * https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC17
 */
SECTIONS
{
    /* 1. ".text" before ":" is the name of the output section.
     * 2. "{ ... }" specifies contents of the output section.
     * 3. "*" stands for all files.
     * 4. "( ... )" is a selector (space-separated), which
     *    includes a list of source sections located in source
     *    files, in output sections.
     * 5. "> SRAM0" assign this section to a previously
     *    defined region of memory. See MEMORY command above.
     *
     * See GNU Linker Scripts ld documentation:
     * https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC19
     * https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html#SEC21
     */
    .text : { *(.text) } > SRAM0
}
