(herald "PAKE 1" (algebra diffie-hellman))
  
(defprotocol pake1 diffie-hellman
	(defrole init
	(vars (P Q name)(m data)(a rndx)(p skey)(v base))
	(trace 
		(send (exp (gen) a))
		(recv v)
		(send (enc m (hash p P Q (exp (gen) a) v (exp v a))))))
	(defrole resp
	(vars (d data)(b rndx)(u base))
	(trace	
		(recv u)
		(send (exp (gen) b))
		(recv d))))
 
(defskeleton pake1
 (vars (P Q name)(m d data)(a rndx)(p skey)(v base))
 (defstrand init 3  (P P)(Q Q)(m m)(a a)(p p)(v v))
 (deflistener (hash p P Q (exp (gen) a) v (exp v a)))
 (uniq-orig m)
 (pen-non-orig p))
 
 (defskeleton pake1
 (vars (P Q name)(d data)(a b rndx)(p skey)(u v base))
 (defstrand resp 3  (d d)(u u)(b b))
 (deflistener (hash p P Q (exp (gen) a) v (exp v a)))
 (pen-non-orig p))
 