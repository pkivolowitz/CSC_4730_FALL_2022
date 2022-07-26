#pragma once

/*	Machine Architecture

	Pages are 2048 bytes long 		--- 11 bits
	VA Space is 32 pages			---  5 bits
	Virtual Addresses are therefore --- 16 bits

	Physical memory can fit         ---  8 pages
	PFN in bits						---  3 bits 
*/

const uint32_t PAGE_BITS    = 11;
const uint32_t PAGE_SIZE    = (1 << PAGE_BITS);
const uint32_t PFN_BITS     = 3;
const uint32_t VPN_BITS     = 5;
const uint32_t VRT_PAGES    = (1 << VPN_BITS);
const uint32_t PHYS_PAGES   = (1 << PFN_BITS);
const uint32_t PHYS_SIZE    = PHYS_PAGES * PAGE_SIZE;

const uint32_t VA_SIZE_BITS = VPN_BITS + PAGE_BITS;
const uint32_t VA_SIZE      = 1 << (VA_SIZE_BITS);

struct PTE {
	uint32_t dirty : 1;
	uint32_t referenced : 1;		// UNUSED
	uint32_t present : 1;
	uint32_t valid : 1;
	uint32_t rw : 1;				// UNUSED
	uint32_t pfn : PFN_BITS;
};

struct _VA {
	uint16_t offset : PAGE_BITS;
	uint16_t vpn : VPN_BITS;
};

struct VRT_Address {
	union {
		uint16_t value;
		_VA virtual_address;
	};
};
