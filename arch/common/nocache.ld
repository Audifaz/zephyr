/*
 * Copyright (c) 2019 Nordic Semiconductor ASA
 * Copyright (c) 2019 Intel Corporation
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/* Copied from linker.ld */

#if DT_NODE_HAS_STATUS(DT_CHOSEN(zephyr_nocache_ram), okay)
#define NOCACHE_REGION LINKER_DT_NODE_REGION_NAME_TOKEN(DT_CHOSEN(zephyr_nocache_ram))
#else
#define NOCACHE_REGION RAMABLE_REGION
#endif

/* Non-cached region of RAM */
SECTION_DATA_PROLOGUE(_NOCACHE_SECTION_NAME,(NOLOAD),)
{
#if defined(CONFIG_MMU)
	MMU_ALIGN;
#else
	MPU_ALIGN(_nocache_ram_size);
#endif
	_nocache_ram_start = .;
	*(.nocache)
	*(".nocache.*")

#include <snippets-nocache-section.ld>

#if defined(CONFIG_MMU)
	MMU_ALIGN;
#else
	MPU_ALIGN(_nocache_ram_size);
#endif
	_nocache_ram_end = .;
} GROUP_DATA_LINK_IN(NOCACHE_REGION, NOCACHE_REGION)
_nocache_ram_size = _nocache_ram_end - _nocache_ram_start;
