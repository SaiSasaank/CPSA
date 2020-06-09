(herald "PAKE 2" (algebra diffie-hellman))
  
(defprotocol pake2 diffie-hellman
	(defrole init
	(vars (P Q name)(m n1 data)(a rndx)(v base)(p skey))
	(trace 
		(send (enc (exp (gen) a) (hash n1 p)))
		(recv v)
		(send (enc m (hash p P Q (enc (exp (gen) a) (hash n1 p)) v (exp v a)))))
		(uniq-gen a n1))
	(defrole resp
	(vars (d n2 data)(b rndx)(u base)(p skey))
	(trace	
		(recv u)
		(send (enc (exp (gen) b) (hash n2 p)))
		(recv d))
		(uniq-gen b n2)))
 
(defskeleton pake2
 (vars (P Q name)(m n1 data)(a b rndx)(p skey)(v base))
 (defstrand init 3 (m m)(p p))
 (deflistener p)
 (uniq-orig m)
 (pen-non-orig p))
 
(defskeleton pake2
 (vars (P Q name)(d n2 data)(b rndx)(p skey)(u base))
 (defstrand resp 3 (p p))
 (deflistener p)
 (pen-non-orig p))
