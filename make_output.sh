make ARCH=arm src/arm/am5729-beagleboneai-prugpuoff-in.dtb
set -e;
  echo '  DTC     src/arm/am5729-beagleboneai-prugpuoff-in.dtb';
 cpp -Wp,-MD,src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.pre.tmp -nostdinc -Iinclude -Isrc/arm -Isrc -Itestcase-data -undef -D__DTS__ -x assembler-with-cpp -o src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.dts.tmp src/arm/am5729-beagleboneai-prugpuoff-in.dts ;
 dtc -O dtb -o src/arm/am5729-beagleboneai-prugpuoff-in.dtb -b 0 -@ -i src/arm -Wno-unit_address_vs_reg -Wno-pci_bridge -Wno-simple_bus_reg -Wno-avoid_unnecessary_addr_size -Wno-alias_paths -Wno-unique_unit_address -d src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.dtc.tmp src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.dts.tmp ;
 cat src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.pre.tmp src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.dtc.tmp > src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d;
 scripts/basic/fixdep src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d src/arm/am5729-beagleboneai-prugpuoff-in.dtb 'cpp -Wp,-MD,src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.pre.tmp -nostdinc -Iinclude -Isrc/arm -Isrc -Itestcase-data -undef -D__DTS__ -x assembler-with-cpp -o src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.dts.tmp src/arm/am5729-beagleboneai-prugpuoff-in.dts ;
 dtc -O dtb -o src/arm/am5729-beagleboneai-prugpuoff-in.dtb -b 0 -@ -i src/arm -Wno-unit_address_vs_reg -Wno-pci_bridge -Wno-simple_bus_reg -Wno-avoid_unnecessary_addr_size -Wno-alias_paths -Wno-unique_unit_address -d src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.dtc.tmp src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.dts.tmp ;
 cat src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.pre.tmp src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d.dtc.tmp > src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d' > src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.tmp;
 rm -f src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.d;
 mv -f src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.tmp src/arm/.am5729-beagleboneai-prugpuoff-in.dtb.cmd
