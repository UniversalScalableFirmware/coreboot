
/* SPDX-License-Identifier: GPL-2.0-only */


#define  UPLD_IMAGE_HEADER_ID    SIGNATURE_32('P','L','D', 'H')
#define  UPLD_RELOC_ID           SIGNATURE_32('P','L','D', 'R')
#define  UPLD_AUTH_ID            SIGNATURE_32('P','L','D', 'A')

#define  UPLD_AUTH_PUBKEY_ID     SIGNATURE_32('P','U','B', 'K')
#define  UPLD_AUTH_SIGNATURE_ID  SIGNATURE_32('S','I','G', 'N')

#define  UPLD_RELOC_FMT_RAW      0
#define  UPLD_RELOC_FMT_PTR      1

#define  UPLD_IMAGE_CAP_PIC      BIT0
#define  UPLD_IMAGE_CAP_RELOC    BIT1
#define  UPLD_IMAGE_CAP_AUTH     BIT2

#define UPLD_SIGNATURE 0x48444c50

typedef struct {
  uint32_t               identifier;
  uint32_t               header_length;
  uint8_t                header_revision;
  uint8_t                reserved1[3];
} upld_common_header_t;


typedef struct {
  upld_common_header_t   header;
  char                   producer_id[8];
  char                   image_id[8];
  uint32_t               revision;
  uint32_t               length;
  uint32_t               svn;
  uint16_t               reserved2;
  uint16_t               machine;
  uint32_t               capability;
  uint32_t               image_offset;
  uint32_t               image_length;
  uint64_t               image_base;
  uint32_t               image_alignment;
  uint32_t               entry_point_offset;
} upld_info_header_t;


typedef struct {
  upld_common_header_t   header;
  uint8_t                reloc_format;
  uint8_t                reserved;
  uint16_t               reloc_image_stripped;
  uint32_t               reloc_image_offset;
} upd_relo_header;


typedef struct {
  uint32_t              page_rva;
  uint32_t              block_size;
} pe_reloc_block_header;




