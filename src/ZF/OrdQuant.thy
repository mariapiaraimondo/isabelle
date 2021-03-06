(*  Title:      ZF/OrdQuant.thy
    Authors:    Krzysztof Grabczewski and L C Paulson
*)

section \<open>Special quantifiers\<close>

theory OrdQuant imports Ordinal begin

subsection \<open>Quantifiers and union operator for ordinals\<close>

definition
  (* Ordinal Quantifiers *)
  oall :: "[i, i => o] => o"  where
    "oall(A, P) == \<forall>x. x<A \<longrightarrow> P(x)"

definition
  oex :: "[i, i => o] => o"  where
    "oex(A, P)  == \<exists>x. x<A & P(x)"

definition
  (* Ordinal Union *)
  OUnion :: "[i, i => i] => i"  where
    "OUnion(i,B) == {z: \<Union>x\<in>i. B(x). Ord(i)}"

syntax
  "_oall"     :: "[idt, i, o] => o"        (\<open>(3\<forall>_<_./ _)\<close> 10)
  "_oex"      :: "[idt, i, o] => o"        (\<open>(3\<exists>_<_./ _)\<close> 10)
  "_OUNION"   :: "[idt, i, i] => i"        (\<open>(3\<Union>_<_./ _)\<close> 10)
translations
  "\<forall>x<a. P" \<rightleftharpoons> "CONST oall(a, \<lambda>x. P)"
  "\<exists>x<a. P" \<rightleftharpoons> "CONST oex(a, \<lambda>x. P)"
  "\<Union>x<a. B" \<rightleftharpoons> "CONST OUnion(a, \<lambda>x. B)"


subsubsection \<open>simplification of the new quantifiers\<close>


(*MOST IMPORTANT that this is added to the simpset BEFORE Ord_atomize
  is proved.  Ord_atomize would convert this rule to
    x < 0 ==> P(x) == True, which causes dire effects!*)
lemma [simp]: "(\<forall>x<0. P(x))"
by (simp add: oall_def)

lemma [simp]: "~(\<exists>x<0. P(x))"
by (simp add: oex_def)

lemma [simp]: "(\<forall>x<succ(i). P(x)) <-> (Ord(i) \<longrightarrow> P(i) & (\<forall>x<i. P(x)))"
apply (simp add: oall_def le_iff)
apply (blast intro: lt_Ord2)
done

lemma [simp]: "(\<exists>x<succ(i). P(x)) <-> (Ord(i) & (P(i) | (\<exists>x<i. P(x))))"
apply (simp add: oex_def le_iff)
apply (blast intro: lt_Ord2)
done

subsubsection \<open>Union over ordinals\<close>

lemma Ord_OUN [intro,simp]:
     "[| !!x. x<A ==> Ord(B(x)) |] ==> Ord(\<Union>x<A. B(x))"
by (simp add: OUnion_def ltI Ord_UN)

lemma OUN_upper_lt:
     "[| a<A;  i < b(a);  Ord(\<Union>x<A. b(x)) |] ==> i < (\<Union>x<A. b(x))"
by (unfold OUnion_def lt_def, blast )

lemma OUN_upper_le:
     "[| a<A;  i\<le>b(a);  Ord(\<Union>x<A. b(x)) |] ==> i \<le> (\<Union>x<A. b(x))"
apply (unfold OUnion_def, auto)
apply (rule UN_upper_le )
apply (auto simp add: lt_def)
done

lemma Limit_OUN_eq: "Limit(i) ==> (\<Union>x<i. x) = i"
by (simp add: OUnion_def Limit_Union_eq Limit_is_Ord)

(* No < version of this theorem: consider that @{term"(\<Union>i\<in>nat.i)=nat"}! *)
lemma OUN_least:
     "(!!x. x<A ==> B(x) \<subseteq> C) ==> (\<Union>x<A. B(x)) \<subseteq> C"
by (simp add: OUnion_def UN_least ltI)

lemma OUN_least_le:
     "[| Ord(i);  !!x. x<A ==> b(x) \<le> i |] ==> (\<Union>x<A. b(x)) \<le> i"
by (simp add: OUnion_def UN_least_le ltI Ord_0_le)

lemma le_implies_OUN_le_OUN:
     "[| !!x. x<A ==> c(x) \<le> d(x) |] ==> (\<Union>x<A. c(x)) \<le> (\<Union>x<A. d(x))"
by (blast intro: OUN_least_le OUN_upper_le le_Ord2 Ord_OUN)

lemma OUN_UN_eq:
     "(!!x. x \<in> A ==> Ord(B(x)))
      ==> (\<Union>z < (\<Union>x\<in>A. B(x)). C(z)) = (\<Union>x\<in>A. \<Union>z < B(x). C(z))"
by (simp add: OUnion_def)

lemma OUN_Union_eq:
     "(!!x. x \<in> X ==> Ord(x))
      ==> (\<Union>z < \<Union>(X). C(z)) = (\<Union>x\<in>X. \<Union>z < x. C(z))"
by (simp add: OUnion_def)

(*So that rule_format will get rid of this quantifier...*)
lemma atomize_oall [symmetric, rulify]:
     "(!!x. x<A ==> P(x)) == Trueprop (\<forall>x<A. P(x))"
by (simp add: oall_def atomize_all atomize_imp)

subsubsection \<open>universal quantifier for ordinals\<close>

lemma oallI [intro!]:
    "[| !!x. x<A ==> P(x) |] ==> \<forall>x<A. P(x)"
by (simp add: oall_def)

lemma ospec: "[| \<forall>x<A. P(x);  x<A |] ==> P(x)"
by (simp add: oall_def)

lemma oallE:
    "[| \<forall>x<A. P(x);  P(x) ==> Q;  ~x<A ==> Q |] ==> Q"
by (simp add: oall_def, blast)

lemma rev_oallE [elim]:
    "[| \<forall>x<A. P(x);  ~x<A ==> Q;  P(x) ==> Q |] ==> Q"
by (simp add: oall_def, blast)


(*Trival rewrite rule.  @{term"(\<forall>x<a.P)<->P"} holds only if a is not 0!*)
lemma oall_simp [simp]: "(\<forall>x<a. True) <-> True"
by blast

(*Congruence rule for rewriting*)
lemma oall_cong [cong]:
    "[| a=a';  !!x. x<a' ==> P(x) <-> P'(x) |]
     ==> oall(a, %x. P(x)) <-> oall(a', %x. P'(x))"
by (simp add: oall_def)


subsubsection \<open>existential quantifier for ordinals\<close>

lemma oexI [intro]:
    "[| P(x);  x<A |] ==> \<exists>x<A. P(x)"
apply (simp add: oex_def, blast)
done

(*Not of the general form for such rules... *)
lemma oexCI:
   "[| \<forall>x<A. ~P(x) ==> P(a);  a<A |] ==> \<exists>x<A. P(x)"
apply (simp add: oex_def, blast)
done

lemma oexE [elim!]:
    "[| \<exists>x<A. P(x);  !!x. [| x<A; P(x) |] ==> Q |] ==> Q"
apply (simp add: oex_def, blast)
done

lemma oex_cong [cong]:
    "[| a=a';  !!x. x<a' ==> P(x) <-> P'(x) |]
     ==> oex(a, %x. P(x)) <-> oex(a', %x. P'(x))"
apply (simp add: oex_def cong add: conj_cong)
done


subsubsection \<open>Rules for Ordinal-Indexed Unions\<close>

lemma OUN_I [intro]: "[| a<i;  b \<in> B(a) |] ==> b: (\<Union>z<i. B(z))"
by (unfold OUnion_def lt_def, blast)

lemma OUN_E [elim!]:
    "[| b \<in> (\<Union>z<i. B(z));  !!a.[| b \<in> B(a);  a<i |] ==> R |] ==> R"
apply (unfold OUnion_def lt_def, blast)
done

lemma OUN_iff: "b \<in> (\<Union>x<i. B(x)) <-> (\<exists>x<i. b \<in> B(x))"
by (unfold OUnion_def oex_def lt_def, blast)

lemma OUN_cong [cong]:
    "[| i=j;  !!x. x<j ==> C(x)=D(x) |] ==> (\<Union>x<i. C(x)) = (\<Union>x<j. D(x))"
by (simp add: OUnion_def lt_def OUN_iff)

lemma lt_induct:
    "[| i<k;  !!x.[| x<k;  \<forall>y<x. P(y) |] ==> P(x) |]  ==>  P(i)"
apply (simp add: lt_def oall_def)
apply (erule conjE)
apply (erule Ord_induct, assumption, blast)
done


subsection \<open>Quantification over a class\<close>

definition
  "rall"     :: "[i=>o, i=>o] => o"  where
    "rall(M, P) == \<forall>x. M(x) \<longrightarrow> P(x)"

definition
  "rex"      :: "[i=>o, i=>o] => o"  where
    "rex(M, P) == \<exists>x. M(x) & P(x)"

syntax
  "_rall"     :: "[pttrn, i=>o, o] => o"        (\<open>(3\<forall>_[_]./ _)\<close> 10)
  "_rex"      :: "[pttrn, i=>o, o] => o"        (\<open>(3\<exists>_[_]./ _)\<close> 10)
translations
  "\<forall>x[M]. P" \<rightleftharpoons> "CONST rall(M, \<lambda>x. P)"
  "\<exists>x[M]. P" \<rightleftharpoons> "CONST rex(M, \<lambda>x. P)"


subsubsection\<open>Relativized universal quantifier\<close>

lemma rallI [intro!]: "[| !!x. M(x) ==> P(x) |] ==> \<forall>x[M]. P(x)"
by (simp add: rall_def)

lemma rspec: "[| \<forall>x[M]. P(x); M(x) |] ==> P(x)"
by (simp add: rall_def)

(*Instantiates x first: better for automatic theorem proving?*)
lemma rev_rallE [elim]:
    "[| \<forall>x[M]. P(x);  ~ M(x) ==> Q;  P(x) ==> Q |] ==> Q"
by (simp add: rall_def, blast)

lemma rallE: "[| \<forall>x[M]. P(x);  P(x) ==> Q;  ~ M(x) ==> Q |] ==> Q"
by blast

(*Trival rewrite rule;   (\<forall>x[M].P)<->P holds only if A is nonempty!*)
lemma rall_triv [simp]: "(\<forall>x[M]. P) \<longleftrightarrow> ((\<exists>x. M(x)) \<longrightarrow> P)"
by (simp add: rall_def)

(*Congruence rule for rewriting*)
lemma rall_cong [cong]:
    "(!!x. M(x) ==> P(x) <-> P'(x)) ==> (\<forall>x[M]. P(x)) <-> (\<forall>x[M]. P'(x))"
by (simp add: rall_def)


subsubsection\<open>Relativized existential quantifier\<close>

lemma rexI [intro]: "[| P(x); M(x) |] ==> \<exists>x[M]. P(x)"
by (simp add: rex_def, blast)

(*The best argument order when there is only one M(x)*)
lemma rev_rexI: "[| M(x);  P(x) |] ==> \<exists>x[M]. P(x)"
by blast

(*Not of the general form for such rules... *)
lemma rexCI: "[| \<forall>x[M]. ~P(x) ==> P(a); M(a) |] ==> \<exists>x[M]. P(x)"
by blast

lemma rexE [elim!]: "[| \<exists>x[M]. P(x);  !!x. [| M(x); P(x) |] ==> Q |] ==> Q"
by (simp add: rex_def, blast)

(*We do not even have (\<exists>x[M]. True) <-> True unless A is nonempty!!*)
lemma rex_triv [simp]: "(\<exists>x[M]. P) \<longleftrightarrow> ((\<exists>x. M(x)) \<and> P)"
by (simp add: rex_def)

lemma rex_cong [cong]:
    "(!!x. M(x) ==> P(x) <-> P'(x)) ==> (\<exists>x[M]. P(x)) <-> (\<exists>x[M]. P'(x))"
by (simp add: rex_def cong: conj_cong)

lemma rall_is_ball [simp]: "(\<forall>x[%z. z\<in>A]. P(x)) <-> (\<forall>x\<in>A. P(x))"
by blast

lemma rex_is_bex [simp]: "(\<exists>x[%z. z\<in>A]. P(x)) <-> (\<exists>x\<in>A. P(x))"
by blast

lemma atomize_rall: "(!!x. M(x) ==> P(x)) == Trueprop (\<forall>x[M]. P(x))"
by (simp add: rall_def atomize_all atomize_imp)

declare atomize_rall [symmetric, rulify]

lemma rall_simps1:
     "(\<forall>x[M]. P(x) & Q)   <-> (\<forall>x[M]. P(x)) & ((\<forall>x[M]. False) | Q)"
     "(\<forall>x[M]. P(x) | Q)   <-> ((\<forall>x[M]. P(x)) | Q)"
     "(\<forall>x[M]. P(x) \<longrightarrow> Q) <-> ((\<exists>x[M]. P(x)) \<longrightarrow> Q)"
     "(~(\<forall>x[M]. P(x))) <-> (\<exists>x[M]. ~P(x))"
by blast+

lemma rall_simps2:
     "(\<forall>x[M]. P & Q(x))   <-> ((\<forall>x[M]. False) | P) & (\<forall>x[M]. Q(x))"
     "(\<forall>x[M]. P | Q(x))   <-> (P | (\<forall>x[M]. Q(x)))"
     "(\<forall>x[M]. P \<longrightarrow> Q(x)) <-> (P \<longrightarrow> (\<forall>x[M]. Q(x)))"
by blast+

lemmas rall_simps [simp] = rall_simps1 rall_simps2

lemma rall_conj_distrib:
    "(\<forall>x[M]. P(x) & Q(x)) <-> ((\<forall>x[M]. P(x)) & (\<forall>x[M]. Q(x)))"
by blast

lemma rex_simps1:
     "(\<exists>x[M]. P(x) & Q) <-> ((\<exists>x[M]. P(x)) & Q)"
     "(\<exists>x[M]. P(x) | Q) <-> (\<exists>x[M]. P(x)) | ((\<exists>x[M]. True) & Q)"
     "(\<exists>x[M]. P(x) \<longrightarrow> Q) <-> ((\<forall>x[M]. P(x)) \<longrightarrow> ((\<exists>x[M]. True) & Q))"
     "(~(\<exists>x[M]. P(x))) <-> (\<forall>x[M]. ~P(x))"
by blast+

lemma rex_simps2:
     "(\<exists>x[M]. P & Q(x)) <-> (P & (\<exists>x[M]. Q(x)))"
     "(\<exists>x[M]. P | Q(x)) <-> ((\<exists>x[M]. True) & P) | (\<exists>x[M]. Q(x))"
     "(\<exists>x[M]. P \<longrightarrow> Q(x)) <-> (((\<forall>x[M]. False) | P) \<longrightarrow> (\<exists>x[M]. Q(x)))"
by blast+

lemmas rex_simps [simp] = rex_simps1 rex_simps2

lemma rex_disj_distrib:
    "(\<exists>x[M]. P(x) | Q(x)) <-> ((\<exists>x[M]. P(x)) | (\<exists>x[M]. Q(x)))"
by blast


subsubsection\<open>One-point rule for bounded quantifiers\<close>

lemma rex_triv_one_point1 [simp]: "(\<exists>x[M]. x=a) <-> ( M(a))"
by blast

lemma rex_triv_one_point2 [simp]: "(\<exists>x[M]. a=x) <-> ( M(a))"
by blast

lemma rex_one_point1 [simp]: "(\<exists>x[M]. x=a & P(x)) <-> ( M(a) & P(a))"
by blast

lemma rex_one_point2 [simp]: "(\<exists>x[M]. a=x & P(x)) <-> ( M(a) & P(a))"
by blast

lemma rall_one_point1 [simp]: "(\<forall>x[M]. x=a \<longrightarrow> P(x)) <-> ( M(a) \<longrightarrow> P(a))"
by blast

lemma rall_one_point2 [simp]: "(\<forall>x[M]. a=x \<longrightarrow> P(x)) <-> ( M(a) \<longrightarrow> P(a))"
by blast


subsubsection\<open>Sets as Classes\<close>

definition
  setclass :: "[i,i] => o"       (\<open>##_\<close> [40] 40)  where
   "setclass(A) == %x. x \<in> A"

lemma setclass_iff [simp]: "setclass(A,x) <-> x \<in> A"
by (simp add: setclass_def)

lemma rall_setclass_is_ball [simp]: "(\<forall>x[##A]. P(x)) <-> (\<forall>x\<in>A. P(x))"
by auto

lemma rex_setclass_is_bex [simp]: "(\<exists>x[##A]. P(x)) <-> (\<exists>x\<in>A. P(x))"
by auto


ML
\<open>
val Ord_atomize =
  atomize ([(\<^const_name>\<open>oall\<close>, @{thms ospec}), (\<^const_name>\<open>rall\<close>, @{thms rspec})] @
    ZF_conn_pairs, ZF_mem_pairs);
\<close>
declaration \<open>fn _ =>
  Simplifier.map_ss (Simplifier.set_mksimps (fn ctxt =>
    map mk_eq o Ord_atomize o Variable.gen_all ctxt))
\<close>

text \<open>Setting up the one-point-rule simproc\<close>

simproc_setup defined_rex ("\<exists>x[M]. P(x) & Q(x)") = \<open>
  fn _ => Quantifier1.rearrange_bex
    (fn ctxt =>
      unfold_tac ctxt @{thms rex_def} THEN
      Quantifier1.prove_one_point_ex_tac ctxt)
\<close>

simproc_setup defined_rall ("\<forall>x[M]. P(x) \<longrightarrow> Q(x)") = \<open>
  fn _ => Quantifier1.rearrange_ball
    (fn ctxt =>
      unfold_tac ctxt @{thms rall_def} THEN
      Quantifier1.prove_one_point_all_tac ctxt)
\<close>

end
