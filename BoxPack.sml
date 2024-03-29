signature BOX_PACK  =
sig
  type hlist = BoxTypes.hlist
  type box = BoxTypes.box
  type dist = BasicTypes.dist

  val boxList:       hlist -> box

  val setWidth:      dist -> hlist -> box
  (* sets width to a given value, using glue adaptation *)

  val increaseWidth: dist -> hlist -> box
  (* increases width by a given value which may be negative,
     using glue adaptation *)

  val rebox:         dist -> box -> box
end  (* signature BOX_PACK *)
(*----------*)

structure BoxPack: BOX_PACK  =
struct
  open BasicTypes;  open BoxTypes
  open BasicBox;    open NodeListDim;  open HListGlue

  fun desiredDimensions w nl  =
      {width = w,  height = hlistHeight nl,  depth = hlistDepth nl}

  fun naturalDimensions nl  =
      desiredDimensions  (hlistWidth nl)  nl

  fun hpackNat nl  =  hbox  (naturalDimensions nl)  nl

  fun boxList [Box (0, b)]  =  b
  |   boxList  nl           =  hpackNat nl

  fun setWidth w nl  =
    let val nw   =  hlistWidth nl
        val dim  =  desiredDimensions w nl
    in  hlistGlue dim (w - nw) nl  end

  fun increaseWidth dw nl  =
    let val nw   =  hlistWidth nl
        val dim  =  desiredDimensions (nw + dw) nl
    in  hlistGlue dim dw nl  end

  fun rebox  newWidth  (b as {kind, width, height, depth, content, ...})  =
  if  newWidth = width  then  b  else
  if  null content  then  hpackNat [Kern newWidth]  else
  let val hl   =  if  kind = VBox  then  HL b  else  content
      val glue =  Glue ssGlue
      val dim  =  {width = newWidth, height = height, depth = depth}
  in  hlistGlue  dim  (newWidth - width)  (glue :: hl @ [glue])  end

end  (* structure BoxPack *)
