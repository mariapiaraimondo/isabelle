(*  Title:      HOL/ex/CASC_Setup.thy
    Author:     Jasmin Blanchette
    Copyright   2011

Setup for Isabelle, Nitpick, and Refute for participating at CASC in the THF and
TNT divisions. This theory file should be loaded by the Isabelle theory files
generated by Geoff Sutcliffe's TPTP2X tool from the original THF0 files.
*)

theory CASC_Setup
imports Complex_Main
uses "sledgehammer_tactics.ML"
begin

declare mem_def [simp add]

declare [[smt_oracle]]

refute_params [maxtime = 10000, no_assms, expect = genuine]
nitpick_params [timeout = none, card = 1-50, verbose, dont_box, no_assms,
                batch_size = 1, expect = genuine]

ML {* Proofterm.proofs := 0 *}

ML {*
fun SOLVE_TIMEOUT seconds name tac st =
  let
    val result =
      TimeLimit.timeLimit (Time.fromSeconds seconds)
        (fn () => SINGLE (SOLVE tac) st) ()
      handle TimeLimit.TimeOut => NONE
        | ERROR _ => NONE
  in
    (case result of
      NONE => (warning ("FAILURE: " ^ name); Seq.empty)
    | SOME st' => (warning ("SUCCESS: " ^ name); Seq.single st'))
  end
*}

ML {*
fun isabellep_tac ctxt max_secs =
   SOLVE_TIMEOUT (max_secs div 10) "smt" (ALLGOALS (SMT_Solver.smt_tac ctxt []))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 5) "sledgehammer"
       (ALLGOALS (Sledgehammer_Tactics.sledgehammer_as_oracle_tac ctxt))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 10) "simp" (ALLGOALS (asm_full_simp_tac (simpset_of ctxt)))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 20) "blast" (ALLGOALS (blast_tac ctxt))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 10) "auto" (auto_tac ctxt
       THEN ALLGOALS (Sledgehammer_Tactics.sledgehammer_as_oracle_tac ctxt))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 10) "metis"
       (ALLGOALS (Metis_Tactics.metis_tac [] ctxt []))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 10) "fast" (ALLGOALS (fast_tac ctxt))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 10) "best" (ALLGOALS (best_tac ctxt))
   ORELSE
   SOLVE_TIMEOUT (max_secs div 10) "force" (ALLGOALS (force_tac ctxt))
   ORELSE
   SOLVE_TIMEOUT max_secs "fastsimp" (ALLGOALS (fast_simp_tac ctxt))
*}

method_setup isabellep = {*
  Scan.lift (Scan.optional Parse.nat 1) >>
    (fn m => fn ctxt => SIMPLE_METHOD (isabellep_tac ctxt m))
*} "combination of Isabelle provers and oracles for CASC"

end
