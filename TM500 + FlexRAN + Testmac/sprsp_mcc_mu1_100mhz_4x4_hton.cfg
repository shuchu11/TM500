<?xml version="1.0"?>
<!--                                                                                         -->
<!--   <COPYRIGHT_TAG>                                                                       -->
<!--                                                                                         -->
<!--                                                                                         -->
<!--   This set of tests was run on: Intel(R) Xeon(R) Sapphire Rapids CPU (32 Cores) @ 2.50GHz -->

testfilename sprsp_mcc_mu1_100mhz_4x4_hton.cfg

#setoption spr_pipeline 1

#phystart 1 1 60200
phystart 4 0 0

setoption ebbu_pool_num_queue 4
setoption ebbu_pool_queue_size 1024
setoption ebbu_pool_num_context 4
setoption ebbu_pool_max_context_fetch 2

setoption pdsch_proc_type 0
setoption pdsch_split 2
setoption pusch_mmse_split 2
setoption pucch_split 2

setoption ce_interp_method 2
setoption linear_interp_enable 4 0xFFFFFF
setoption remove_memcpy_memset 1

setcore 0x3000000030
TEST_FD, 1600, 1, 5GNR, fd/mu1_100mhz/600/fd_testconfig_tst600.cfg


