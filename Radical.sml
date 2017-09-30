signature RADICAL  =
sig
  type style = BasicTypes.style
  type box = BoxTypes.box
  type delim = BoxTypes.delim
  
  val makeRadical:  style -> delim -> box -> box
end  (* signature RADICAL *)
(*----------*)

structure Radical: RADICAL  =
struct
  open BasicTypes;  open BoxTypes
  fun makeRadical st del box  =  raise (NotImplemented "makeRadical")
end  (* structure Radical *)
