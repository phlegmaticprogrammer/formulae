signature FORMULA  =
sig
  type hlist = BoxTypes.hlist
  type mlist = MathTypes.mlist

  val inlineFormula:   mlist -> hlist
  val displayFormula:  mlist -> hlist
end  (* signature FORMULA *)
(*----------*)

structure Formula: FORMULA  =
struct
  open BasicTypes
  open MathTranslate

  val displayFormula  =  MListToHList D false false
  val inlineFormula   =  MListToHList T false true
end  (* structure Formula *)
