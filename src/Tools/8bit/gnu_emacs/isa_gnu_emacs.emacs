;;
;;   -- init-file for GNU Emacs for Isabelle environment
;;
;;   derived from
;;   sgemacs by Ralf S. Engelschall, <rse@en.muc.de>
;;
;;   added isabelle fonts to font-selection menu
;;   the key-map is now generated by a perl script
;;   Franz Regensburger <regensbu@informatik.tu-muenchen.de>
;;   22.03.95
;;   

;;; Isabelle font as default
(set-default-font "isabelle14")

;;   activate 8bit chars 
;;   ...for all new buffers
(setq default-ctl-arrow "z")
;;   ...and for the still active buffer
(setq ctl-arrow "z")
;;  Switch to ISO display
(standard-display-european 1)
(require 'iso-syntax)

(setcdr x-fixed-font-alist
            (cons  '("Symbol fonts"
                    ;; These are the available isabelle and spectrum fonts.
("14 isabelle " "isabelle14")
("24 isabelle " "isabelle24")
)
                    (cdr x-fixed-font-alist)))

;; DO NOT EDIT the lines between BEGIN-KEY-MAP and END-KEY-MAP
;; the table is generated by the perl script `gen-isa_gnu_emacs'
;; In order to make changes to the keyboard mappings you should edit
;; the configuration file `key-table.inp' which is interpreted by
;; the perl script `gen-isa_gnu_emacs', 
;;
;;
;; key-map for Isabelle font
;;   
;; BEGIN-KEY-MAP
(global-set-key [s-space] '(lambda () (interactive) (insert "\240")))
(global-set-key [?\s-G] '(lambda () (interactive) (insert "\241")))
(global-set-key [?\s-D] '(lambda () (interactive) (insert "\242")))
(global-set-key [?\s-J] '(lambda () (interactive) (insert "\243")))
(global-set-key [?\s-L] '(lambda () (interactive) (insert "\244")))
(global-set-key [?\s-P] '(lambda () (interactive) (insert "\245")))
(global-set-key [?\s-S] '(lambda () (interactive) (insert "\246")))
(global-set-key [?\s-F] '(lambda () (interactive) (insert "\247")))
(global-set-key [?\s-Q] '(lambda () (interactive) (insert "\250")))
(global-set-key [?\s-W] '(lambda () (interactive) (insert "\251")))
(global-set-key [?\s-a] '(lambda () (interactive) (insert "\252")))
(global-set-key [?\s-b] '(lambda () (interactive) (insert "\253")))
(global-set-key [?\s-g] '(lambda () (interactive) (insert "\254")))
(global-set-key [?\s-d] '(lambda () (interactive) (insert "\255")))
(global-set-key [?\s-e] '(lambda () (interactive) (insert "\256")))
(global-set-key [?\s-z] '(lambda () (interactive) (insert "\257")))
(global-set-key [?\s-h] '(lambda () (interactive) (insert "\260")))
(global-set-key [?\s-j] '(lambda () (interactive) (insert "\261")))
(global-set-key [?\s-k] '(lambda () (interactive) (insert "\262")))
(global-set-key [?\s-l] '(lambda () (interactive) (insert "\263")))
(global-set-key [?\s-m] '(lambda () (interactive) (insert "\264")))
(global-set-key [?\s-n] '(lambda () (interactive) (insert "\265")))
(global-set-key [?\s-x] '(lambda () (interactive) (insert "\266")))
(global-set-key [?\s-p] '(lambda () (interactive) (insert "\267")))
(global-set-key [?\s-r] '(lambda () (interactive) (insert "\270")))
(global-set-key [?\s-s] '(lambda () (interactive) (insert "\271")))
(global-set-key [?\s-t] '(lambda () (interactive) (insert "\272")))
(global-set-key [?\s-f] '(lambda () (interactive) (insert "\273")))
(global-set-key [?\s-c] '(lambda () (interactive) (insert "\274")))
(global-set-key [?\s-q] '(lambda () (interactive) (insert "\275")))
(global-set-key [?\s-w] '(lambda () (interactive) (insert "\276")))
(global-set-key [?\H-n] '(lambda () (interactive) (insert "\277")))
(global-set-key [?\H-a] '(lambda () (interactive) (insert "\300")))
(global-set-key [?\H-o] '(lambda () (interactive) (insert "\301")))
(global-set-key [?\H-f] '(lambda () (interactive) (insert "\302")))
(global-set-key [?\H-t] '(lambda () (interactive) (insert "\303")))
(global-set-key [?\H-F] '(lambda () (interactive) (insert "\304")))
(global-set-key [?\H-b] '(lambda () (interactive) (insert "\330")))
(global-set-key [?\H-e] '(lambda () (interactive) (insert "\331")))
(global-set-key [?\H-E] '(lambda () (interactive) (insert "\332")))
(global-set-key [?\H-u] '(lambda () (interactive) (insert "\333")))
(global-set-key [?\H-p] '(lambda () (interactive) (insert "\334")))
(global-set-key [?\H-P] '(lambda () (interactive) (insert "\335")))
(global-set-key [?\H-l] '(lambda () (interactive) (insert "\336")))
(global-set-key [?\H-L] '(lambda () (interactive) (insert "\337")))
(global-set-key [?\H-g] '(lambda () (interactive) (insert "\340")))
(global-set-key [?\H-G] '(lambda () (interactive) (insert "\341")))
(global-set-key [?\H-s] '(lambda () (interactive) (insert "\342")))
(global-set-key [?\H-S] '(lambda () (interactive) (insert "\343")))
(global-set-key [?\H-i] '(lambda () (interactive) (insert "\347")(insert "\350")))
(global-set-key [?\H-I] '(lambda () (interactive) (insert "\352")(insert "\353")))
(global-set-key [?\H-M] '(lambda () (interactive) (insert "\350")))
(global-set-key [?\H-m] '(lambda () (interactive) (insert "\353")))
(global-set-key [?\H-N] '(lambda () (interactive) (insert "\367")))
(global-set-key [?\H-x] '(lambda () (interactive) (insert "\362")))
(global-set-key [f2] '(lambda () (interactive) (insert "\344")))
(global-set-key [f3] '(lambda () (interactive) (insert "\335")))
(global-set-key [f4] '(lambda () (interactive) (insert "\317")))
(global-set-key [f5] '(lambda () (interactive) (insert "\316")))
(global-set-key [f6] '(lambda () (interactive) (insert "\361")))
(global-set-key [f7] '(lambda () (interactive) (insert "\345")))
(global-set-key [f8] '(lambda () (interactive) (insert "\332")))
(global-set-key [f9] '(lambda () (interactive) (insert "\304")))
(global-set-key [f10] '(lambda () (interactive) (insert "\313")))
(global-set-key [f11] '(lambda () (interactive) (insert "\314")))
(global-set-key [f12] '(lambda () (interactive) (insert "\352")(insert "\353")))
(global-set-key [S-f1] '(lambda () (interactive) (insert "\351")))
(global-set-key [S-f2] '(lambda () (interactive) (insert "\352")))
(global-set-key [S-f3] '(lambda () (interactive) (insert "\353")))
(global-set-key [S-f4] '(lambda () (interactive) (insert "\351")(insert "\353")))
(global-set-key [S-f5] '(lambda () (interactive) (insert "\363")))
(global-set-key [S-f6] '(lambda () (interactive) (insert "\364")))
(global-set-key [S-f7] '(lambda () (interactive) (insert "\365")))
(global-set-key [S-f8] '(lambda () (interactive) (insert "\366")))
(global-set-key [S-f9] '(lambda () (interactive) (insert "\312")))
(global-set-key [S-f10] '(lambda () (interactive) (insert "\311")))
(global-set-key [C-f1] '(lambda () (interactive) (insert "\346")))
(global-set-key [C-f2] '(lambda () (interactive) (insert "\347")))
(global-set-key [C-f3] '(lambda () (interactive) (insert "\350")))
(global-set-key [C-f4] '(lambda () (interactive) (insert "\346")(insert "\350")))
(global-set-key [C-f5] '(lambda () (interactive) (insert "\305")))
(global-set-key [C-f6] '(lambda () (interactive) (insert "\306")))
(global-set-key [C-f7] '(lambda () (interactive) (insert "\307")))
(global-set-key [C-f8] '(lambda () (interactive) (insert "\310")))
(global-set-key [C-f9] '(lambda () (interactive) (insert "\375")))
(global-set-key [C-f10] '(lambda () (interactive) (insert "\315")))
(global-set-key [s-f1] '(lambda () (interactive) (insert "\355")))
(global-set-key [s-f2] '(lambda () (interactive) (insert "\356")))
(global-set-key [s-f3] '(lambda () (interactive) (insert "\357")))
(global-set-key [s-f4] '(lambda () (interactive) (insert "\360")))
(global-set-key [s-f5] '(lambda () (interactive) (insert "\324")))
(global-set-key [s-f6] '(lambda () (interactive) (insert "\325")))
(global-set-key [s-f7] '(lambda () (interactive) (insert "\326")))
(global-set-key [s-f8] '(lambda () (interactive) (insert "\327")))
(global-set-key [s-f9] '(lambda () (interactive) (insert "\334")))
(global-set-key [s-f10] '(lambda () (interactive) (insert "\370")))
(global-set-key [H-f1] '(lambda () (interactive) (insert "\371")))
(global-set-key [H-f2] '(lambda () (interactive) (insert "\372")))
(global-set-key [H-f3] '(lambda () (interactive) (insert "\373")))
(global-set-key [H-f4] '(lambda () (interactive) (insert "\374")))
(global-set-key [H-f5] '(lambda () (interactive) (insert "\320")))
(global-set-key [H-f6] '(lambda () (interactive) (insert "\321")))
(global-set-key [H-f7] '(lambda () (interactive) (insert "\322")))
(global-set-key [H-f8] '(lambda () (interactive) (insert "\323")))
(global-set-key [H-f9] '(lambda () (interactive) (insert "\367")))
(global-set-key [H-f10] '(lambda () (interactive) (insert "\354")))
(global-set-key [H-f11] '(lambda () (interactive) (insert "\376")))
(global-set-key [H-f12] '(lambda () (interactive) (insert "\377")))
;; END-KEY-MAP


