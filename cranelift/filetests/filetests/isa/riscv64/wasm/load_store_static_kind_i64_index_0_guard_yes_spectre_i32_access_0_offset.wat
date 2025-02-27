;;! target = "riscv64"
;;!
;;! settings = ['enable_heap_access_spectre_mitigation=true']
;;!
;;! compile = true
;;!
;;! [globals.vmctx]
;;! type = "i64"
;;! vmctx = true
;;!
;;! [globals.heap_base]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 0, readonly = true }
;;!
;;! # (no heap_bound global for static heaps)
;;!
;;! [[heaps]]
;;! base = "heap_base"
;;! min_size = 0x10000
;;! offset_guard_size = 0
;;! index_type = "i64"
;;! style = { kind = "static", bound = 0x10000000 }

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store offset=0)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load offset=0))

;; function u0:0:
;; block0:
;;   ld a7,0(a2)
;;   add a7,a7,a0
;;   lui a5,65536
;;   addi a5,a5,4092
;;   ugt t3,a0,a5##ty=i64
;;   li t0,0
;;   selectif_spectre_guard t4,t0,a7##test=t3
;;   sw a1,0(t4)
;;   j label1
;; block1:
;;   ret
;;
;; function u0:1:
;; block0:
;;   ld a7,0(a1)
;;   add a7,a7,a0
;;   lui a5,65536
;;   addi a5,a5,4092
;;   ugt t3,a0,a5##ty=i64
;;   li t0,0
;;   selectif_spectre_guard t4,t0,a7##test=t3
;;   lw a0,0(t4)
;;   j label1
;; block1:
;;   ret
